"
I'm an exception that immediately stops a request within a filter or route.
"
Class {
	#name : 'TeaAbort',
	#superclass : 'Error',
	#instVars : [
		'response'
	],
	#category : 'Teapot-Core',
	#package : 'Teapot-Core'
}

{ #category : 'instance creation' }
TeaAbort class >> response: aZnResponse [
	^ self new setResponse: aZnResponse
]

{ #category : 'converting' }
TeaAbort >> response [
	^ response
]

{ #category : 'initialization' }
TeaAbort >> setResponse: aZnResponse [
	response := aZnResponse.
	^ self
]
