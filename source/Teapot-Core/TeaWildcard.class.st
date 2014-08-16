"
A wildcard url pattern segment that matches to anything.
"
Class {
	#name : #TeaWildcard,
	#superclass : #TeaGlobUrlSegment,
	#category : #'Teapot-Core'
}

{ #category : #'instance creation' }
TeaWildcard class >> atLast: aBoolean [
	^ aBoolean
		ifTrue: [ TeaWildcardStop new ]
		ifFalse: [ TeaWildcard new ]
]

{ #category : #'url pattern segment' }
TeaWildcard >> matches: urlSegments rest: adjacentPatterns placeholders: aDictionary [
	^ adjacentPatterns first 
		matches: urlSegments allButFirst 
		rest: adjacentPatterns allButFirst 
		placeholders: aDictionary
]

{ #category : #printing }
TeaWildcard >> printOn: aStream [
	aStream nextPut: $*
]
