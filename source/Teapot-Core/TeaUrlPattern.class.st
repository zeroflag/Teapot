"
An URL pattern can be matched agains actual urls. The pattern may collect named parameters from the URL in case of match.
"
Class {
	#name : 'TeaUrlPattern',
	#superclass : 'Object',
	#category : 'Teapot-Core',
	#package : 'Teapot-Core'
}

{ #category : 'url matcher' }
TeaUrlPattern >> matchesUrl: anUrl placeholders: aDictionary [
	self subclassResponsibility 
]
