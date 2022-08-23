"
An UrlPattern is made from segments. I can be matched against an actual URL. '*' and <named-parameters> can be used inside the pattern.

I can parse the pattern from a string by saying:

	self parseString: '/foo/*/<id>/bar'

Which will create a pattern that matches to an URL like this: 

	/foo/xyz/12/bar
"
Class {
	#name : #TeaGlobUrlPattern,
	#superclass : #TeaUrlPattern,
	#instVars : [
		'segments'
	],
	#category : #'Teapot-Core'
}

{ #category : #private }
TeaGlobUrlPattern class >> createSegment: aString atLast: aBoolean [
	aString = '*' 
		ifTrue: [ ^ TeaWildcard atLast: aBoolean ].
	(aString beginsWith: '<')
		ifTrue: [ ^ TeaPlaceholder fromString: aString atLast: aBoolean ].
	^ TeaLiteral fromString: aString atLast: aBoolean
]

{ #category : #private }
TeaGlobUrlPattern class >> parseSegments: aString [
	| tokens |
	tokens := aString findTokens: '/'.
	^ tokens collectWithIndex: [ :each :idx | 
		self createSegment: each atLast: idx = tokens size ]
]

{ #category : #'instance creation' }
TeaGlobUrlPattern class >> parseString: aString [
	^ self new setSegments: (self parseSegments: aString)
]

{ #category : #'url matcher' }
TeaGlobUrlPattern >> matchesUrl: anUrl placeholders: aDictionary [
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
TeaGlobUrlPattern >> padUrlSegments: anUrl with: padding size: anInteger [
	| urlSegments |
	urlSegments := anUrl segments isEmptyOrNil 
		ifTrue: [ OrderedCollection new ]
		ifFalse: [ self trimTrailingSlash: anUrl segments ].
	urlSegments size < segments size
		ifTrue: [ urlSegments := urlSegments forceTo: anInteger paddingWith: padding ].
	^ urlSegments
]

{ #category : #printing }
TeaGlobUrlPattern >> printOn: aStream [
	aStream nextPut: $'.
	segments 
		do: [ :each | each printOn: aStream ]
		separatedBy: [ aStream nextPut: $/ ].
	aStream nextPut: $'.
]

{ #category : #initialization }
TeaGlobUrlPattern >> setSegments: anArray [
	segments := anArray.
	^ self
]

{ #category : #private }
TeaGlobUrlPattern >> trimTrailingSlash: urlSegments [ 
	^ (urlSegments isNotEmpty and: [ urlSegments last asString = '/' ])
		ifTrue: [ urlSegments allButLast ]
		ifFalse: [ urlSegments ]
]
