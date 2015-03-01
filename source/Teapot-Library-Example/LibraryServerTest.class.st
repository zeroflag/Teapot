Class {
	#name : #LibraryServerTest,
	#superclass : #TestCase,
	#instVars : [
		'client',
		'server',
		'book1',
		'book2'
	],
	#category : #'Teapot-Library-Example'
}

{ #category : #private }
LibraryServerTest >> port [
	^ 17834
]

{ #category : #running }
LibraryServerTest >> setUp [
	client := LibraryClient port: self port.
	server := LibraryServer serveOn: self port.
	book1 := {#title -> 'book 1'. #authors -> 'author 1'} asDictionary.
	book2 := {#title -> 'book 2'. #authors -> 'author 2'} asDictionary
]

{ #category : #running }
LibraryServerTest >> tearDown [
	server stop
]

{ #category : #'tests - an empty library' }
LibraryServerTest >> testAllowsReplacing [
	client 
		replaceBook: 1 
		with: book1.
	self 
		assert: client books size
		equals: 1.
		
]

{ #category : #'tests  - a non empty library' }
LibraryServerTest >> testDoesNotFindDeletedBook [
	book1 := client addBook: book1.
	book2 := client addBook: book2.
			
	client removeBook: (book1 at: #id).
	
	self 
		should: [ client findBook: (book1 at: #id) ] 
		raise: BookNotFound.	
	self 
		assert: client books size 
		equals: 1.
	self 
		assert: client books first 
		equals: book2.
	
]

{ #category : #'tests - a new library' }
LibraryServerTest >> testHasNoBooks [
	self 
		assert: client books size
		equals: 0
]

{ #category : #'tests  - a non empty library' }
LibraryServerTest >> testReplacesExistingBook [
	| old new id |
	old := client addBook: book1.
	id := old at: #id.
	
	client 
		replaceBook: id 
		with: book2.		
	new := client findBook: id.
	
	self 
		assert: new 
		equals: (book2 copyWith: #id -> id)
]

{ #category : #'tests  - a non empty library' }
LibraryServerTest >> testReturnsAllBooks [
	| books |	
	books := client 
		addBook: book1;
		addBook: book2;
		books.
		
	self 
		assert: books size 
		equals: 2.
	
	
]

{ #category : #'tests - an empty library' }
LibraryServerTest >> testReturnsSingleAddedBook [
	| added found |	
	added := client addBook: book1.
	found := client findBook: (added at: #id).
	
	self assert: found equals: added.
]

{ #category : #'tests - an empty library' }
LibraryServerTest >> testSignalsErrorWhenRemoving [
	self 
		should: [ client removeBook: 1 ]
		raise: BookNotFound
]
