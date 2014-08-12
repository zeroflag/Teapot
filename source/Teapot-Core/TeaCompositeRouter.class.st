"
I'm a composite zn delegate, built from other zn delegates. I forward the request to the first delegate that returns other than 404 as response. Errors are handled with the help of the registered error handlers.
"
Class {
	#name : #TeaCompositeRouter,
	#superclass : #TeaRouter,
	#instVars : [
		'routers',
		'errorhandlers',
		'beforeRoutes'
	],
	#category : #'Teapot-Core'
}

{ #category : #'instance creation' }
TeaCompositeRouter class >> routers: teaRouterCollection [
	^ self new setRouters: teaRouterCollection
]

{ #category : #filters }
TeaCompositeRouter >> addBeforeFilter: aRoute [
	beforeRoutes add: aRoute
]

{ #category : #'error handing' }
TeaCompositeRouter >> addErrorHandler: errorHandler exceptions: anExceptionSet [
	errorhandlers add: anExceptionSet -> errorHandler
]

{ #category : #private }
TeaCompositeRouter >> exceptionOccurred: anException request: aZnRequest [
	| handler |
	handler := errorhandlers 
		detect: [ :each | each key handles: anException ] 
		ifNone: [ anException pass ].
	^ handler value 
		handleTeaException: anException 
		request: aZnRequest		
]

{ #category : #'zn delegate' }
TeaCompositeRouter >> handleRequest: aZnRequest [	
	[ beforeRoutes do: [ :each | each handleRequest: aZnRequest ].
	 routers do: [ :each | | response |
		response := each handleRequest: aZnRequest.
		response isNotFound ifFalse: [ ^ response ] ] 
	] on: Exception
	  do: [ :ex | ^ self exceptionOccurred: ex request: aZnRequest ]. "TODO TeaRequest instead of ZN"
		
	^ ZnResponse notFound: aZnRequest uri
]

{ #category : #initialization }
TeaCompositeRouter >> initialize [
	super initialize.
	errorhandlers := OrderedCollection new.
	beforeRoutes := OrderedCollection new.
]

{ #category : #initialization }
TeaCompositeRouter >> setRouters: teaRouterCollection [
	routers := teaRouterCollection asArray.
	^ self
]
