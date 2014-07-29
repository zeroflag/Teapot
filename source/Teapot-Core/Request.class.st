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

{ #category : #'reflective operations' }
Request >> doesNotUnderstand: aMessage [
	^ aMessage sendTo: znRequest
]

{ #category : #acccessing }
Request >> form: aSymbol [
	^ znRequest entity at: aSymbol
]

{ #category : #acccessing }
Request >> param: aString [
	"Gets the value of a path parameter. E.g. /foo/<path-param>/bar"
	
	^ pathParams at: aString	
]

{ #category : #acccessing }
Request >> query: aSymbol [
	"Gets a parameter from the query string"
	
	^ znRequest uri queryAt: aSymbol
]

{ #category : #acccessing }
Request >> query: aSymbol ifAbsent: aBlock [
	"Gets an optional parameter from the query string"
	
	^ znRequest uri 
		queryAt: aSymbol 
		ifAbsent: aBlock
]

{ #category : #initialization }
Request >> setZnRequest: aZnRequest pathParams: aDictionary [
	znRequest := aZnRequest.
	pathParams := aDictionary.
	^ self
]
