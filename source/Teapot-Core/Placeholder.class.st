"
I'm a placeholder with a key. My content is substituted with a value.
"
Class {
	#name : #Placeholder,
	#superclass : #UrlPatternSegment,
	#instVars : [
		'placeholderName'
	],
	#category : #'Teapot-Core-Teapot-Core'
}

{ #category : #'instance creation' }
Placeholder class >> fromString: aString atLast: aBoolean [
	| class |
	((aString beginsWith: '<') and: [ aString endsWith: '>' ]) 
		ifFalse: [ self error: 'Invalid placeholder name: ', aString ].
	class := aBoolean ifTrue: [ PlaceholderStop ] ifFalse: [ Placeholder ].		
	^ class new setPlaceholderName: aString allButFirst allButLast.
]

{ #category : #'url pattern segment' }
Placeholder >> matches: urlSegments rest: adjacentPatterns placeholders: aDictionary [
	aDictionary 
		at: placeholderName 
		put: urlSegments first.
	^ adjacentPatterns first 
		matches: urlSegments allButFirst 
		rest: adjacentPatterns allButFirst 
		placeholders: aDictionary
]

{ #category : #printing }
Placeholder >> printOn: aStream [
	aStream 
		nextPut: $:;
		nextPutAll: placeholderName
]

{ #category : #initialization }
Placeholder >> setPlaceholderName: aString [ 
	placeholderName := aString asSymbol.
	^ self
]
