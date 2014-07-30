"
I'm a placeholder with a key. My content is substituted with a value.
"
Class {
	#name : #TeaPlaceholder,
	#superclass : #TeaUrlPatternSegment,
	#instVars : [
		'placeholderName',
		'type'
	],
	#category : #'Teapot-Core'
}

{ #category : #private }
TeaPlaceholder class >> createPlaceholderName: key type: typeSymbol atLast: aBoolean [
	| class |
	class := aBoolean
		ifTrue: [ TeaPlaceholderStop ]
		ifFalse: [ TeaPlaceholder ].
	^ class new 
		setPlaceholderName: key 
		type: typeSymbol
]

{ #category : #'instance creation' }
TeaPlaceholder class >> fromString: aString atLast: aBoolean [
	| spec type key |
	self mustBeValidPlaceholder: aString.
	spec := aString allButFirst allButLast findTokens: ':'.
	key := spec first.
	type := spec at: 2 ifAbsent: #asString.
	^ self 
		createPlaceholderName: key 
		type: type asSymbol
		atLast: aBoolean
]

{ #category : #private }
TeaPlaceholder class >> mustBeValidPlaceholder: aString [
	((aString beginsWith: '<') and: [ aString endsWith: '>' ])
		ifFalse: [ self error: 'Invalid placeholder name: ', aString ]
]

{ #category : #'url pattern segment' }
TeaPlaceholder >> matches: urlSegments rest: adjacentPatterns placeholders: aDictionary [
	aDictionary 
		at: placeholderName 
		put: (urlSegments first perform: type).
	^ adjacentPatterns first 
		matches: urlSegments allButFirst 
		rest: adjacentPatterns allButFirst 
		placeholders: aDictionary
]

{ #category : #printing }
TeaPlaceholder >> printOn: aStream [
	aStream 
		nextPut: $<;
		nextPutAll: placeholderName;
		nextPut: $>
]

{ #category : #initialization }
TeaPlaceholder >> setPlaceholderName: aString type: typeSymbol [
	placeholderName := aString asSymbol.
	type := typeSymbol.
	^ self
]
