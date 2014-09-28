"
A TeaResponse represents an HTTP response returned by a Route. The ZnResponse is generated from the TeaResponse by the given response transformer.
"
Class {
	#name : #TeaResponse,
	#superclass : #Object,
	#instVars : [
		'code',
		'body',
		'headers'
	],
	#category : #'Teapot-Core'
}

{ #category : #'instance creation' }
TeaResponse class >> code: anInteger body: anObject [
	^ self code: anInteger body: anObject headers: Dictionary new
]

{ #category : #'instance creation' }
TeaResponse class >> code: anInteger body: anObject headers: aDictionary [
	^ self new
		setCode: anInteger
		body: anObject
		header: aDictionary asDictionary
]

{ #category : #accessing }
TeaResponse >> body [
	^ body
]

{ #category : #accessing }
TeaResponse >> code [
	^ code
]

{ #category : #accessing }
TeaResponse >> headers [
	^ headers
]

{ #category : #initialization }
TeaResponse >> setCode: anInteger body: anObject header: aDictionary [
	code := anInteger.
	body := anObject.
	headers := aDictionary.
	^ self
]

{ #category : #'response transforming' }
TeaResponse >> teaTransform: aResponseTransformer request: aTeaRequest [
	^ aResponseTransformer cull: self cull: aTeaRequest
]
