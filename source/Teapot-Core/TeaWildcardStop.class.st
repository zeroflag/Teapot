"
I'm a Wildcard at the last position.
"
Class {
	#name : 'TeaWildcardStop',
	#superclass : 'TeaWildcard',
	#category : 'Teapot-Core',
	#package : 'Teapot-Core'
}

{ #category : 'url pattern segment' }
TeaWildcardStop >> matches: urlSegments rest: adjacentPatterns placeholders: aDictionary [
	^ true
]
