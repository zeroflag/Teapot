Class {
	#name : #Request,
	#superclass : #Object,
	#instVars : [
		'znRequest',
		'pathParams'
	],
	#category : #'Teapot-Core'
}

{ #category : #'instance creation' }
Request class >> fromZnRequest: aZnRequest pathParams: aDictionary [
	^ self new 
		setZnRequest: aZnRequest 
		pathParams: aDictionary
]

{ #category : #'acccessing - params' }
Request >> at: aSymbol [
	^ self 
		at: aSymbol 
		ifAbsent: [ KeyNotFound signal: 'Param ', aSymbol printString, ' not found' ]
]

{ #category : #'acccessing - params' }
Request >> at: aSymbol ifAbsent: aBlock [
	"Gets the value of a path parameter, query parameter for form parameter.
		E.g. /foo/<path-param>/bar
		E.g. /foo?queryParam=value"

	^ pathParams at: aSymbol ifAbsent: [ self queryOrFormParam: aSymbol ifAbsent: aBlock	"XXX do something better" ]
]

{ #category : #'reflective operations' }
Request >> doesNotUnderstand: aMessage [
	^ aMessage sendTo: znRequest
]

{ #category : #private }
Request >> formParam: aSymbol ifAbsent: aBlock [
	^ (znRequest entity isKindOf: ZnApplicationFormUrlEncodedEntity) "XXX do something better" 
		ifTrue: [ znRequest entity at: aSymbol ifAbsent: aBlock ]
		ifFalse: aBlock
]

{ #category : #private }
Request >> queryOrFormParam: aSymbol ifAbsent: aBlock [
	^ znRequest uri 
		queryAt: aSymbol 
		ifAbsent: [ self formParam: aSymbol ifAbsent: aBlock ]
]

{ #category : #initialization }
Request >> setZnRequest: aZnRequest pathParams: aDictionary [
	znRequest := aZnRequest.
	pathParams := aDictionary.
	^ self
]
