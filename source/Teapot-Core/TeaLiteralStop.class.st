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
	^ literal = urlSegments first and: [ urlSegments size = 1 ]
]

{ #category : #printing }
TeaLiteralStop >> printOn: aStream [	
	aStream 
		nextPutAll: literal;
		nextPut: $$
]
