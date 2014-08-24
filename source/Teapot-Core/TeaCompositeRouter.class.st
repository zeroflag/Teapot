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
TeaCompositeRouter >> addErrorHandler: aTeaErrorHandler [
	^ errorhandlers add: aTeaErrorHandler
]

{ #category : #private }
TeaCompositeRouter >> exceptionOccurred: anException request: aTeaRequest [
	| handler |
	handler := errorhandlers 
		detect: [ :each | each canHandleError: anException ]
		ifNone: [ anException pass ].		
	^ handler handleError: anException request: aTeaRequest.
	
]

{ #category : #'zn delegate' }
TeaCompositeRouter >> handleRequest: aZnRequest [	
	[ beforeRoutes do: [ :each | each handleRequest: aZnRequest ].
	 routers do: [ :each | | response |
		response := each handleRequest: aZnRequest.
		response isNotFound ifFalse: [ ^ response ] ] 
	] on: Exception
	  do: [ :ex | 
		^ self exceptionOccurred: ex request: (TeaRequest fromZnRequest: aZnRequest) ].
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
