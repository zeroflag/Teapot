Class {
	#name : #LibraryServer,
	#superclass : #Object,
	#instVars : [
		'port',
		'teapot',
		'library'
	],
	#category : #'Teapot-Library-Example'
}

{ #category : #'instance creation' }
LibraryServer class >> serveOn: portNumber [
	^ self basicNew  
		setPort: portNumber;
		initialize;
		start
]

{ #category : #rest }
LibraryServer >> createBook: request [
	| book bookId |
	book := self makeBook: request.
	bookId := library addBook: book.
	^ TeaResponse created: '/books/', bookId asString
]

{ #category : #rest }
LibraryServer >> deleteBook: request [
	| bookId |
	bookId := request at: #id.
	^ [ 
		library removeBook: bookId.
		TeaResponse ok: 'Deleted /books/' , bookId asString 
	   ]
		on: BookNotFound
		do: [ TeaResponse code: 204 body: 'No content' ]
]

{ #category : #initialization }
LibraryServer >> initialize [ 
	super initialize.
	library := Library new.
	teapot := Teapot configure: { 
		#port -> port. 
		#debugMode -> true. 
		#defaultOutput -> #json 
	}.
	self registerRoutes.
]

{ #category : #private }
LibraryServer >> makeBook: request [
	^ {#title      -> (request at: #title).
          #authors -> (request at: #authors) } asDictionary.
]

{ #category : #rest }
LibraryServer >> readBook: request [
	^ library findBook: (request at: #id)
]

{ #category : #rest }
LibraryServer >> readBooks: aTeaRequest [ 
	^ library findAll
]

{ #category : #initialization }
LibraryServer >> registerRoutes [
	teapot
		GET: '/books' -> (Send message: #readBooks: to: self);
		GET: '/books/<id:IsInteger>' -> (Send message: #readBook: to: self);
		POST: '/books' -> (Send message: #createBook: to: self);		
		PUT: '/books/<id:IsInteger>' -> (Send message: #updateBook: to: self);
		DELETE: '/books/<id:IsInteger>' -> (Send message: #deleteBook: to: self);
		exception: TeaNoSuchParam -> [ :ex :req | TeaResponse badRequest: req ];
		exception: BookNotFound -> [ :ex :req | TeaResponse notFound: '/books/', ex messageText ].
]

{ #category : #initialization }
LibraryServer >> setPort: anInteger [ 
	port := anInteger.
	^ self
]

{ #category : #controlling }
LibraryServer >> start [
	teapot start.
	^ self
]

{ #category : #controlling }
LibraryServer >> stop [
	teapot stop
]

{ #category : #rest }
LibraryServer >> updateBook: request [
	| updatedBook |
	updatedBook := self makeBook: request.
	^ [ 
		library replaceBook: (request at: 'id') with: updatedBook.
		TeaResponse ok: 'updated'
  	   ]
		on: BookNotFound
		do: [ TeaResponse code: 204 body: 'No content' ]	
	

	
]
