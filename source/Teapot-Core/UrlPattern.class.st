"
An UrlPattern is made from segments. I can be matched against an actual URL.

I can parse the pattern from a string by saying:

	UrlPattern parseString: '/foo/*/:id/bar'

Which will create a pattern that matches to an URL like this: 

	/foo/xyz/12/bar
"
Class {
	#name : #UrlPattern,
	#superclass : #Object,
	#instVars : [
		'segments'
	],
	#category : #'Teapot-Core'
}

{ #category : #private }
UrlPattern class >> createSegment: aString atLast: aBoolean [
	aString = '*' 
		ifTrue: [ ^ Wildcard atLast: aBoolean ].
	(aString beginsWith: '<')
		ifTrue: [ ^ Placeholder fromString: aString atLast: aBoolean ].
	^ Literal 
		fromString: aString 
		atLast: aBoolean
]

{ #category : #private }
UrlPattern class >> parseSegments: aString [
	| tokens |
	tokens := aString findTokens: '/'.
	^ tokens collectWithIndex: [ :each :idx | 
			self 
				createSegment: each 
				atLast: idx = tokens size ]
]

{ #category : #'instance creation' }
UrlPattern class >> parseString: aString [
	^ self new setSegments: (self parseSegments: aString)
]

{ #category : #'url matcher' }
UrlPattern >> matchesUrl: anUrl placeholders: aDictionary [
	| urlSegments |
	urlSegments := self padUrlSegments: anUrl with: Padding size: segments size.
	segments isEmpty
		ifTrue: [ ^ urlSegments isEmpty ].
	^ segments first 
		matches: urlSegments 
		rest: segments allButFirst 
		placeholders: aDictionary
]

{ #category : #private }
UrlPattern >> padUrlSegments: anUrl with: padding size: anInteger [
	| urlSegments |
	anUrl segments ifNil: [ ^ OrderedCollection new ].
	urlSegments := self trimTrailingSlash: anUrl segments.
	urlSegments size < segments size
		ifTrue: [ urlSegments := urlSegments forceTo: anInteger paddingWith: padding ].
	^ urlSegments
]

{ #category : #printing }
UrlPattern >> printOn: aStream [
	segments 
		do: [ :each | each printOn: aStream ]
		separatedBy: [ aStream nextPut: $/ ]
]

{ #category : #initialization }
UrlPattern >> setSegments: anArray [
	segments := anArray.
	^ self
]

{ #category : #private }
UrlPattern >> trimTrailingSlash: urlSegments [ 
	^ urlSegments last = '/' 
		ifTrue: [ urlSegments allButLast ]
		ifFalse: [ urlSegments ]
]
