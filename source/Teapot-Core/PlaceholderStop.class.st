"
I'm a placeholder at the last position.
"
Class {
	#name : #PlaceholderStop,
	#superclass : #Placeholder,
	#category : #'Teapot-Core-Teapot-Core'
}

{ #category : #'url pattern segment' }
PlaceholderStop >> matches: urlSegments rest: adjacentPatterns placeholders: aDictionary [
	| match |
	match := urlSegments size = 1 and: [ urlSegments first ~= Padding ].
	match ifTrue:
		 [ aDictionary
			at: placeholderName 
			put: urlSegments first ].
	^ match
]

{ #category : #printing }
PlaceholderStop >> printOn: aStream [
	aStream 
		nextPut: $:;
		nextPutAll: placeholderName;
		nextPut: $$
]
