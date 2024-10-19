"
A literal url pattern segment that matches to a string.
"
Class {
	#name : 'TeaLiteral',
	#superclass : 'TeaGlobUrlSegment',
	#instVars : [
		'literal'
	],
	#category : 'Teapot-Core',
	#package : 'Teapot-Core'
}

{ #category : 'instance creation' }
TeaLiteral class >> fromString: aString atLast: aBoolean [
	| class |
	class := aBoolean ifTrue: [ TeaLiteralStop ] ifFalse: [ TeaLiteral ].
	^ class new setLiteral: aString
]

{ #category : 'url pattern segment' }
TeaLiteral >> matches: urlSegments rest: adjacentPatterns placeholders: aDictionary [
	^ literal = urlSegments first and: 
		[ adjacentPatterns first 
			matches: urlSegments allButFirst 
			rest: adjacentPatterns allButFirst 
			placeholders: aDictionary ]
]

{ #category : 'printing' }
TeaLiteral >> printOn: aStream [
	aStream nextPutAll: literal.
	
]

{ #category : 'initialization' }
TeaLiteral >> setLiteral: aString [
	literal := aString.
	^ self
]
