"
I extend the ZnResponse with addition methods for convenience.
"
Class {
	#name : #TeaResponse,
	#superclass : #Object,
	#instVars : [
		'znResponse'
	],
	#category : #'Teapot-Core'
}

{ #category : #'instance creation' }
TeaResponse class >> fromZnResponse: aZnResponse [
	^ self new setZnResponse: aZnResponse
]

{ #category : #'reflective operations' }
TeaResponse >> doesNotUnderstand: aMessage [
	^ aMessage sendTo: znResponse 
]

{ #category : #initialization }
TeaResponse >> setZnResponse: aZnResponse [
	znResponse := aZnResponse.
	^ self
]
