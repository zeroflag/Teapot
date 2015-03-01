"
A simple HTTP Client for communication with the LibraryServer
"
Class {
	#name : #LibraryClient,
	#superclass : #Object,
	#instVars : [
		'port'
	],
	#category : #'Teapot-Library-Example'
}

{ #category : #'instance creation' }
LibraryClient class >> port: anInteger [
	^ self new initializePort: anInteger
]

{ #category : #'book library' }
LibraryClient >> addBook: aDictionary [		
	| response |
	response := ZnClient new
		url: self baseUrl, '/books';
		formAt: 'title' put:  (aDictionary at: #title);
		formAt: 'authors' put: (aDictionary at: #authors);
		post;
		response.
	^ self parseResponse: response
]

{ #category : #private }
LibraryClient >> baseUrl [
	^ 'http://localhost:', self port asString
]

{ #category : #'book library' }
LibraryClient >> books [
	| response |
	response := ZnClient new
		url: self baseUrl, '/books';
		get;
		response.		
	^ self parseResponse: response


]

{ #category : #private }
LibraryClient >> checkForNotFound: aZnResponse book: bookId [
	404 = aZnResponse code 
		ifTrue: [ BookNotFound signalWithBookId: bookId ]
]

{ #category : #'book library' }
LibraryClient >> findBook: bookId [
	| response |
	response := ZnClient new
		url: self baseUrl, '/books/', bookId asString;
		get;
		response.
	self checkForNotFound: response book: bookId.
	^ self parseResponse: response
]

{ #category : #initialization }
LibraryClient >> initializePort: anInteger [
	port := anInteger.
	^ self
]

{ #category : #private }
LibraryClient >> parseResponse: aZnResponse [
	^ aZnResponse isSuccess
		ifTrue: [ (NeoJSONReader on: aZnResponse entity readStream) next ]
		ifFalse: [ self error: 'Unexpected response: ', aZnResponse code asString ]
]

{ #category : #private }
LibraryClient >> port [
	^ port
]

{ #category : #'book library' }
LibraryClient >> removeBook: bookId [
	| response |
	response := ZnClient new
		url: self baseUrl, '/books/', bookId asString;
		delete;
		response.
	self checkForNotFound: response book: bookId.
	^ self parseResponse: response
]

{ #category : #'book library' }
LibraryClient >> replaceBook: bookId with: aDictionary [
	| response |
	response := ZnClient new
		url: self baseUrl, '/books/', bookId asString;
		formAt: 'title' put:  (aDictionary at: #title);
		formAt: 'authors' put: (aDictionary at: #authors);
		put;
		response.
	^ self parseResponse: response
]
