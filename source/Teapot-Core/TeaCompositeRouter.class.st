"
I'm a composite zn delegate, built from other zn delegates. I forward the request to the first delegate that returns other than 404.
"
Class {
	#name : #TeaCompositeRouter,
	#superclass : #TeaRouter,
	#instVars : [
		'routers',
		'errorhandlers'
	],
	#category : #'Teapot-Core'
}

{ #category : #'instance creation' }
TeaCompositeRouter class >> routers: teaRouterCollection [
	^ self new setRouters: teaRouterCollection
]

{ #category : #'error handing' }
TeaCompositeRouter >> addErrorHandler: errorHandler exceptions: anExceptionSet [
	errorhandlers add: anExceptionSet -> errorHandler
]

{ #category : #private }
TeaCompositeRouter >> handleException: anError request: aZnRequest [
	| handler |
	handler := errorhandlers 
		detect: [ :each | each key handles: anError ] 
		ifNone: [ anError pass ].
	^ handler value 
		cull: anError
		cull: aZnRequest
]

{ #category : #'zn delegate' }
TeaCompositeRouter >> handleRequest: aZnRequest [	
	[ routers do: [ :each | | response |
		response := each handleRequest: aZnRequest.
		response isNotFound ifFalse: [ ^ response ] ] 
	] on: Exception
	  do: [ :ex | ^ self handleException: ex request: aZnRequest ].
		
	^ ZnResponse notFound: aZnRequest uri
]

{ #category : #initialization }
TeaCompositeRouter >> initialize [
	super initialize.
	errorhandlers := OrderedCollection new.
]

{ #category : #initialization }
TeaCompositeRouter >> setRouters: teaRouterCollection [
	routers := teaRouterCollection asArray.
	^ self
]
