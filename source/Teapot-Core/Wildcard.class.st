"
A wildcard url pattern segment that matches to anything.
"
Class {
	#name : #Wildcard,
	#superclass : #UrlPatternSegment,
	#category : #'Teapot-Core'
}

{ #category : #'instance creation' }
Wildcard class >> atLast: aBoolean [
	^ aBoolean
		ifTrue: [ WildcardStop new ]
		ifFalse: [ Wildcard new ]
]

{ #category : #'url pattern segment' }
Wildcard >> matches: urlSegments rest: adjacentPatterns placeholders: aDictionary [
	^ adjacentPatterns first 
		matches: urlSegments allButFirst 
		rest: adjacentPatterns allButFirst 
		placeholders: aDictionary
]

{ #category : #private }
Wildcard >> matchesTo: aString [
	^ true
]

{ #category : #printing }
Wildcard >> printOn: aStream [
	aStream nextPut: $*
]
