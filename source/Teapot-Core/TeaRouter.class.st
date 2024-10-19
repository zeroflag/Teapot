"
A zn delegate baseclass
"
Class {
	#name : 'TeaRouter',
	#superclass : 'Object',
	#category : 'Teapot-Core',
	#package : 'Teapot-Core'
}

{ #category : 'router' }
TeaRouter >> handleRequest: aZnRequest ifUnhandled: aBlock [
	self subclassResponsibility 
]
