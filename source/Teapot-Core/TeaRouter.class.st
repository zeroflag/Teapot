"
A zn delegate baseclass
"
Class {
	#name : #TeaRouter,
	#superclass : #Object,
	#category : #'Teapot-Core'
}

{ #category : #'zn delegate' }
TeaRouter >> handleRequest: aZnRequest [
	self subclassResponsibility 
]
