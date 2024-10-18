"
I'm a placeholder with a key. My content is substituted with a value.
"
Class {
	#name : 'TeaPlaceholder',
	#superclass : 'TeaGlobUrlSegment',
	#instVars : [
		'placeholderName',
		'typeConstraint'
	],
	#category : 'Teapot-Core',
	#package : 'Teapot-Core'
}

{ #category : 'private' }
TeaPlaceholder class >> createPlaceholderName: key typeConstraint: aTypeConstraint atLast: aBoolean [
	| class |
	class := aBoolean
		ifTrue: [ TeaPlaceholderStop ]
		ifFalse: [ TeaPlaceholder ].
	^ class new 
		setPlaceholderName: key 
		typeConstraint: aTypeConstraint
]

{ #category : 'instance creation' }
TeaPlaceholder class >> fromString: aString atLast: aBoolean [
	| spec typeConstraint key |
	self mustBeValidPlaceholder: aString.
	spec := aString allButFirst allButLast findTokens: ':'.
	key := spec first.
	typeConstraint := spec at: 2 ifAbsent: #IsObject.
	^ self 
		createPlaceholderName: key 
		typeConstraint: (Smalltalk at: typeConstraint asSymbol)
		atLast: aBoolean
]

{ #category : 'private' }
TeaPlaceholder class >> mustBeValidPlaceholder: aString [
	((aString beginsWith: '<') and: [ aString endsWith: '>' ])
		ifFalse: [ self error: 'Invalid placeholder name: ', aString ]
]

{ #category : 'url pattern segment' }
TeaPlaceholder >> matches: urlSegments rest: adjacentPatterns placeholders: aDictionary [
	(urlSegments first = TeaPadding or: [ (typeConstraint matchesTo: urlSegments first) not]) 
		ifTrue: [ ^ false ].		
	aDictionary 
		at: placeholderName 
		put: (typeConstraint parseString: urlSegments first).				
	^ adjacentPatterns first 
		matches: urlSegments allButFirst 
		rest: adjacentPatterns allButFirst 
		placeholders: aDictionary
]

{ #category : 'printing' }
TeaPlaceholder >> printOn: aStream [
	aStream 
		nextPut: $<;
		nextPutAll: placeholderName;
		nextPut: $>
]

{ #category : 'initialization' }
TeaPlaceholder >> setPlaceholderName: aString typeConstraint: aTypeConstraint [
	placeholderName := aString asSymbol.
	typeConstraint := aTypeConstraint.
	^ self
]
