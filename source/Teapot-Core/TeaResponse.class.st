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

{ #category : #accessing }
TeaResponse >> code: anInteger [
	^ self code: anInteger reason: nil
]

{ #category : #accessing }
TeaResponse >> code: anInteger reason: aString [
	znResponse statusLine 
		code: anInteger;
		reason: aString.
	^ ''
]

{ #category : #accessing }
TeaResponse >> contentType [
	^ znResponse headers contentType 
]

{ #category : #accessing }
TeaResponse >> contentType: aZnMimeType [
	^ znResponse setContentType: aZnMimeType
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
