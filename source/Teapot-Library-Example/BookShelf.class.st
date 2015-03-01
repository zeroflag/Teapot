"
A simple in-memory storage for books with basic CRUD operations. Books are stored in a Dicionary with a generated id. 

Books are represented by simple Dictionaries.
"
Class {
	#name : #BookShelf,
	#superclass : #Object,
	#instVars : [
		'books',
		'sequence'
	],
	#category : #'Teapot-Library-Example'
}

{ #category : #'book library' }
BookShelf >> addBook: aDictionary [
	| bookId |
	bookId := self uniqueId.
	^ books 
		at: bookId
		put: (aDictionary copyWith: #id -> bookId)
]

{ #category : #'book library' }
BookShelf >> books [
	^ books values
]

{ #category : #'book library' }
BookShelf >> findBook: bookId [ 
	^ books 
		at: bookId
		ifAbsent: [ BookNotFound signalWithBookId: bookId ]
]

{ #category : #initialization }
BookShelf >> initialize [ 
	super initialize.
	books := Dictionary new.
	sequence := 0.
]

{ #category : #'book library' }
BookShelf >> removeBook: bookId [ 
	^ books 
		removeKey: bookId 
		ifAbsent: [ BookNotFound signalWithBookId: bookId ]
]

{ #category : #'book library' }
BookShelf >> replaceBook: bookId with: aDictionary [
	^ books 
		at: bookId 
		put: (aDictionary copyWith: #id -> bookId)
]

{ #category : #private }
BookShelf >> uniqueId [
	^ sequence := sequence + 1
]
