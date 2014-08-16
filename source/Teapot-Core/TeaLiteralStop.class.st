"
I'm a placeholder at the last position.
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
