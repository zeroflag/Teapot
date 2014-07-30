"
I'm a placeholder at the last position.
"
Class {
	#name : #TeaPlaceholderStop,
	#superclass : #TeaPlaceholder,
	#category : #'Teapot-Core'
}

{ #category : #'url pattern segment' }
TeaPlaceholderStop >> matches: urlSegments rest: adjacentPatterns placeholders: aDictionary [
	| match |
	match := urlSegments size = 1 and: [ urlSegments first ~= TeaPadding ].
	match ifTrue:
		 [ aDictionary
			at: placeholderName 
			put: (urlSegments first perform: type) ].
	^ match
]

{ #category : #printing }
TeaPlaceholderStop >> printOn: aStream [
	aStream 
		nextPut: $<;
		nextPutAll: placeholderName;
		nextPut: $>;		
		nextPut: $$
]
