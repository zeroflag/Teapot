"
I'm a placeholder with a key. My content is substituted with a value.
"
Class {
	#name : #Placeholder,
	#superclass : #UrlPatternSegment,
	#instVars : [
		'placeholderName',
		'type'
	],
	#category : #'Teapot-Core'
}

{ #category : #private }
Placeholder class >> createPlaceholderName: key type: typeSymbol atLast: aBoolean [
	| class |
	class := aBoolean
		ifTrue: [ PlaceholderStop ]
		ifFalse: [ Placeholder ].
	^ class new 
		setPlaceholderName: key 
		type: typeSymbol
]

{ #category : #'instance creation' }
Placeholder class >> fromString: aString atLast: aBoolean [
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
Placeholder class >> mustBeValidPlaceholder: aString [
	((aString beginsWith: '<') and: [ aString endsWith: '>' ])
		ifFalse: [ self error: 'Invalid placeholder name: ', aString ]
]

{ #category : #'url pattern segment' }
Placeholder >> matches: urlSegments rest: adjacentPatterns placeholders: aDictionary [
	aDictionary 
		at: placeholderName 
		put: (urlSegments first perform: type).
	^ adjacentPatterns first 
		matches: urlSegments allButFirst 
		rest: adjacentPatterns allButFirst 
		placeholders: aDictionary
]

{ #category : #printing }
Placeholder >> printOn: aStream [
	aStream 
		nextPut: $<;
		nextPutAll: placeholderName;
		nextPut: $>
]

{ #category : #initialization }
Placeholder >> setPlaceholderName: aString type: typeSymbol [
	placeholderName := aString asSymbol.
	type := typeSymbol.
	^ self
]
