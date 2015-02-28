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
	ZnClient new
		url: self baseUrl, '/books';
		formAt: 'title' put:  (aDictionary at: #title);
		formAt: 'authors' put: (aDictionary at: #authors);
		post.

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
		get.		
	^ NeoJSONReader fromString: response


]

{ #category : #'book library' }
LibraryClient >> findBook: bookId [
	| response |
	response := ZnClient new
		url: self baseUrl, '/books/', bookId asString;
		get.
	^ NeoJSONReader fromString: response
]

{ #category : #initialization }
LibraryClient >> initializePort: anInteger [
	port := anInteger.
	^ self
]

{ #category : #private }
LibraryClient >> port [
	^ port
]

{ #category : #'book library' }
LibraryClient >> removeBook: bookId [
	^ ZnClient new
		url: self baseUrl, '/books/', bookId asString;
		delete


]

{ #category : #'book library' }
LibraryClient >> replaceBook: bookId with: aDictionary [
	ZnClient new
		url: self baseUrl, '/books/', bookId asString;
		formAt: 'title' put:  (aDictionary at: #title);
		formAt: 'authors' put: (aDictionary at: #authors);
		put
]
