Class {
	#name : #Library,
	#superclass : #Object,
	#instVars : [
		'books',
		'sequence'
	],
	#category : #'Teapot-Library-Example'
}

{ #category : #library }
Library >> addBook: aDictionary [
	| bookId |
	bookId := self uniqueId.
	books 
		at: bookId 
		put: (aDictionary copyWith: #id -> bookId).
	^ bookId
]

{ #category : #library }
Library >> findAll [
	^ books values
]

{ #category : #library }
Library >> findBook: bookId [ 
	^ books 
		at:  bookId
		ifAbsent: [ BookNotFound signal: bookId asString ]
]

{ #category : #initialization }
Library >> initialize [ 
	super initialize.
	books := Dictionary new.
	sequence := 0.
]

{ #category : #library }
Library >> removeBook: bookId [ 
	books 
		removeKey: bookId 
		ifAbsent: [ BookNotFound signal: bookId asString ]
]

{ #category : #library }
Library >> replaceBook: bookId with: aDictionary [
	books 
		at: bookId 
		put: (aDictionary copyWith: #id -> bookId)
]

{ #category : #private }
Library >> uniqueId [
	^ sequence := sequence + 1
]
