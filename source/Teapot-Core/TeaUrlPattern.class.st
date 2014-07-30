"
An UrlPattern is made from segments. I can be matched against an actual URL.

I can parse the pattern from a string by saying:

	UrlPattern parseString: '/foo/*/:id/bar'

Which will create a pattern that matches to an URL like this: 

	/foo/xyz/12/bar
"
Class {
	#name : #TeaUrlPattern,
	#superclass : #Object,
	#instVars : [
		'segments'
	],
	#category : #'Teapot-Core'
}

{ #category : #private }
TeaUrlPattern class >> createSegment: aString atLast: aBoolean [
	aString = '*' 
		ifTrue: [ ^ TeaWildcard atLast: aBoolean ].
	(aString beginsWith: '<')
		ifTrue: [ ^ TeaPlaceholder fromString: aString atLast: aBoolean ].
	^ TeaLiteral 
		fromString: aString 
		atLast: aBoolean
]

{ #category : #private }
TeaUrlPattern class >> parseSegments: aString [
	| tokens |
	tokens := aString findTokens: '/'.
	^ tokens collectWithIndex: [ :each :idx | 
			self 
				createSegment: each 
				atLast: idx = tokens size ]
]

{ #category : #'instance creation' }
TeaUrlPattern class >> parseString: aString [
	^ self new setSegments: (self parseSegments: aString)
]

{ #category : #'url matcher' }
TeaUrlPattern >> matchesUrl: anUrl placeholders: aDictionary [
	| urlSegments |
	urlSegments := self padUrlSegments: anUrl with: TeaPadding size: segments size.
	segments isEmpty
		ifTrue: [ ^ urlSegments isEmpty ].
	^ segments first 
		matches: urlSegments 
		rest: segments allButFirst 
		placeholders: aDictionary
]

{ #category : #private }
TeaUrlPattern >> padUrlSegments: anUrl with: padding size: anInteger [
	| urlSegments |
	anUrl segments ifNil: [ ^ OrderedCollection new ].
	urlSegments := self trimTrailingSlash: anUrl segments.
	urlSegments size < segments size
		ifTrue: [ urlSegments := urlSegments forceTo: anInteger paddingWith: padding ].
	^ urlSegments
]

{ #category : #printing }
TeaUrlPattern >> printOn: aStream [
	segments 
		do: [ :each | each printOn: aStream ]
		separatedBy: [ aStream nextPut: $/ ]
]

{ #category : #initialization }
TeaUrlPattern >> setSegments: anArray [
	segments := anArray.
	^ self
]

{ #category : #private }
TeaUrlPattern >> trimTrailingSlash: urlSegments [ 
	^ urlSegments last = '/' 
		ifTrue: [ urlSegments allButLast ]
		ifFalse: [ urlSegments ]
]
