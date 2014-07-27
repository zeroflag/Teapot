"
An url pattern segment that matches to nothing.
"
Class {
	#name : #LiteralStop,
	#superclass : #Literal,
	#category : #'Teapot-Core'
}

{ #category : #'url pattern segment' }
LiteralStop >> matches: urlSegments rest: adjacentPatterns placeholders: aDictionary [
	^ literal = urlSegments first and: [ urlSegments size = 1 ]
]

{ #category : #printing }
LiteralStop >> printOn: aStream [	
	aStream 
		nextPutAll: literal;
		nextPut: $$
]
