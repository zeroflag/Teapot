"
My subclasses form te elements of url patterns.

"
Class {
	#name : #TeaUrlPatternSegment,
	#superclass : #Object,
	#category : #'Teapot-Core'
}

{ #category : #'url pattern segment' }
TeaUrlPatternSegment >> matches: urlSegments rest: adjacentPatterns placeholders: aDictionary [
	self subclassResponsibility
]
