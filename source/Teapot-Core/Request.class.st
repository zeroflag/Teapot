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
Request >> param: aString [
	^ pathParams at: aString	
]

{ #category : #initialization }
Request >> setZnRequest: aZnRequest pathParams: aDictionary [
	znRequest := aZnRequest.
	pathParams := aDictionary.
	^ self
]
