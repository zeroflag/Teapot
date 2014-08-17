"
I extend the ZnRequest with addition methods for convenience.
"
Class {
	#name : #TeaRequest,
	#superclass : #Object,
	#instVars : [
		'znRequest',
		'pathParams'
	],
	#category : #'Teapot-Core'
}

{ #category : #'instance creation' }
TeaRequest class >> fromZnRequest: aZnRequest [
	^ self fromZnRequest: aZnRequest pathParams: Dictionary new
]

{ #category : #'instance creation' }
TeaRequest class >> fromZnRequest: aZnRequest pathParams: aDictionary [
	^ self new setZnRequest: aZnRequest pathParams: aDictionary
]

{ #category : #aborting }
TeaRequest >> abort: aZnResponse [
	(TeaAbort response: aZnResponse) signal
]

{ #category : #'acccessing - params' }
TeaRequest >> at: aSymbol [
	^ self 
		at: aSymbol 
		ifAbsent: [ KeyNotFound signal: 'Param ', aSymbol printString, ' not found' ]
]

{ #category : #'acccessing - params' }
TeaRequest >> at: aSymbol ifAbsent: aBlock [
	"Gets the value of a path parameter, query parameter for form parameter.
		E.g. /foo/<path-param>/bar
		E.g. /foo?queryParam=value"

	^ pathParams at: aSymbol ifAbsent: [ self queryOrFormParam: aSymbol ifAbsent: aBlock	"XXX do something better" ]
]

{ #category : #'reflective operations' }
TeaRequest >> doesNotUnderstand: aMessage [
	^ aMessage sendTo: znRequest
]

{ #category : #private }
TeaRequest >> formParam: aSymbol ifAbsent: aBlock [
	^ (znRequest entity isKindOf: ZnApplicationFormUrlEncodedEntity) "XXX do something better" 
		ifTrue: [ znRequest entity at: aSymbol ifAbsent: aBlock ]
		ifFalse: aBlock
]

{ #category : #private }
TeaRequest >> queryOrFormParam: aSymbol ifAbsent: aBlock [
	^ znRequest uri 
		queryAt: aSymbol 
		ifAbsent: [ self formParam: aSymbol ifAbsent: aBlock ]
]

{ #category : #initialization }
TeaRequest >> setZnRequest: aZnRequest pathParams: aDictionary [
	znRequest := aZnRequest.
	pathParams := aDictionary.
	^ self
]
