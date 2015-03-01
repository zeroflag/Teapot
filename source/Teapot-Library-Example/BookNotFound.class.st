"
Signaled when a book was not found.
"
Class {
	#name : #BookNotFound,
	#superclass : #NotFound,
	#instVars : [
		'bookId'
	],
	#category : #'Teapot-Library-Example'
}

{ #category : #signaling }
BookNotFound class >> signalWithBookId: anInteger [
	(self new initializeBookId: anInteger) signal
]

{ #category : #acccessing }
BookNotFound >> bookId [
	^ bookId
]

{ #category : #initialization }
BookNotFound >> initializeBookId: anInteger [
	bookId := anInteger.
	^ self
]
