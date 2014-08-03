"
An url pattern segment that matches to nothing.
"
Class {
	#name : #TeaLiteralStop,
	#superclass : #TeaLiteral,
	#category : #'Teapot-Core'
}

{ #category : #'url pattern segment' }
TeaLiteralStop >> matches: urlSegments rest: adjacentPatterns placeholders: aDictionary [
	^ urlSegments size = 1 and: [ literal = urlSegments first ]
]

{ #category : #printing }
TeaLiteralStop >> printOn: aStream [	
	super printOn: aStream.
	aStream nextPut: $$.
]
