"
My subclasses form te elements of url patterns.

"
Class {
	#name : #UrlPatternSegment,
	#superclass : #Object,
	#category : #'Teapot-Core'
}

{ #category : #'url pattern segment' }
UrlPatternSegment >> matches: urlSegments rest: adjacentPatterns placeholders: aDictionary [
	self subclassResponsibility
]
