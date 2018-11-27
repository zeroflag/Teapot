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
	match := urlSegments size = 1 
		and: [ urlSegments first ~= TeaPadding 
		and: [ (typeConstraint matchesTo: urlSegments first) ] ].
	match ifTrue:
		 [ aDictionary
			at: placeholderName 
			put: (typeConstraint parseString: urlSegments first) ].
	^ match
]
