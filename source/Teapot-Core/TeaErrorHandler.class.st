"
An error handler handles Exceptions signaled by the Routes or before actions.
"
Class {
	#name : 'TeaErrorHandler',
	#superclass : 'Object',
	#instVars : [
		'action',
		'responseTransformer',
		'exceptions'
	],
	#category : 'Teapot-Core',
	#package : 'Teapot-Core'
}

{ #category : 'instance creation' }
TeaErrorHandler class >> for: anExceptionSet action: aTeaAction responseTransformer: aResponseTransformer [
	^ self new 
		setExceptions: anExceptionSet 
		action: aTeaAction 
		responseTransformer: aResponseTransformer
]

{ #category : 'error handler' }
TeaErrorHandler >> canHandleError: anException [
	^ exceptions handles: anException
]

{ #category : 'error handler' }
TeaErrorHandler >> handleError: anException request: aTeaRequest [
	| result |
	^ (self canHandleError: anException)
		ifTrue:
			[ result := action teaEvalActionOnException: anException request: aTeaRequest.
			result teaTransform: responseTransformer request: aTeaRequest ]
		ifFalse: 
			[ self error: 'Cannot handle ', anException printString ]
]

{ #category : 'error handler' }
TeaErrorHandler >> responseTransformer: aResponseTransformer [ 
	responseTransformer := aResponseTransformer
]

{ #category : 'initialization' }
TeaErrorHandler >> setExceptions: anExceptionSet action: aTeaAction responseTransformer: aResponseTransformer [
	exceptions := anExceptionSet.
	action := aTeaAction.
	responseTransformer := aResponseTransformer.
	^ self
]
