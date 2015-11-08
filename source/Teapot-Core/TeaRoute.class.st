"
A route handles http requests if it matches to the route. I have four major parts.

- A handler that can be a block, a value or a message send.
- An url pattern that can be matched against actual urls.
- An http method that can be matched against the actual http method.
- A response transformer for creating ZnResponse from the object returned by the handler.
"
Class {
	#name : #TeaRoute,
	#superclass : #Object,
	#instVars : [
		'responseTransformer',
		'action',
		'requestMatcher',
		'port'
	],
	#category : #'Teapot-Core'
}

{ #category : #'instance creation' }
TeaRoute class >> matcher: aTeaRequestMatcher action: aTeaAction transformer: aResponseTransformer port: portNumber [
	^ self new 
		setMatcher: aTeaRequestMatcher
		action: aTeaAction
		transformer: aResponseTransformer
		port: portNumber "XXX only used by teapsoon inspector"
]

{ #category : #'request handling' }
TeaRoute >> handleRequest: aZnRequest [
	^ requestMatcher 
		matchRequest: aZnRequest 
		ifMatch: 
			[ :aTeaRequest | | result |
			result := action teaEvalActionOnRequest: aTeaRequest.
			result teaTransform: responseTransformer request: aTeaRequest ]
		ifNoMatch: 
			[ ZnResponse notFound: aZnRequest uri ]
]

{ #category : #printing }
TeaRoute >> printOn: aStream [
	requestMatcher printOn: aStream.
	aStream nextPutAll: ' -> '.
	action printOn: aStream.
]

{ #category : #accessing }
TeaRoute >> responseTransformer: aBlock [
	responseTransformer := aBlock
]

{ #category : #initialization }
TeaRoute >> setMatcher: aTeaRequestMatcher action: aTeaAction transformer: aResponseTransformer port: portNumber [
	requestMatcher := aTeaRequestMatcher.
	action := aTeaAction.
	responseTransformer := aResponseTransformer.
	port := portNumber.
	^ self
]

{ #category : #acccessing }
TeaRoute >> whenClause: aBlockClosure [ 
	requestMatcher whenClause: aBlockClosure
]
