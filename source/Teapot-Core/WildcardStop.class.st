"
I'm a Wildcard at the last position.
"
Class {
	#name : #WildcardStop,
	#superclass : #Wildcard,
	#category : #'Teapot-Core'
}

{ #category : #'url pattern segment' }
WildcardStop >> matches: urlSegments rest: adjacentPatterns placeholders: aDictionary [
	^ true
]

{ #category : #printing }
WildcardStop >> printOn: aStream [
	aStream nextPutAll: '*$'
]
