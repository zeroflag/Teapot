"
A literal url pattern segment that matches to a string.
"
Class {
	#name : #Literal,
	#superclass : #UrlPatternSegment,
	#instVars : [
		'literal'
	],
	#category : #'Teapot-Core-Teapot-Core'
}

{ #category : #'instance creation' }
Literal class >> fromString: aString atLast: aBoolean [
	| class |
	class := aBoolean ifTrue: [ LiteralStop ] ifFalse: [ Literal ].
	^ class new setLiteral: aString
]

{ #category : #'url pattern segment' }
Literal >> matches: urlSegments rest: adjacentPatterns placeholders: aDictionary [
	^ literal = urlSegments first and: 
		[ adjacentPatterns first 
			matches: urlSegments allButFirst 
			rest: adjacentPatterns allButFirst 
			placeholders: aDictionary ]
]

{ #category : #printing }
Literal >> printOn: aStream [
	aStream nextPutAll: literal
	
]

{ #category : #initialization }
Literal >> setLiteral: aString [
	literal := aString.
	^ self
]
