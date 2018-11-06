"
I'm a composite zn delegate, built from other zn delegates. I forward the request to the first delegate that returns other than 404 as response. Errors are handled with the help of the registered error handlers.
"
Class {
	#name : #TeaCompositeRouter,
	#superclass : #TeaRouter,
	#instVars : [
		'routers',
		'errorhandlers',
		'beforeFilters',
		'afterFilters',
		'notFoundHandler'
	],
	#category : #'Teapot-Core'
}

{ #category : #'instance creation' }
TeaCompositeRouter class >> routers: teaRouterCollection [
	^ self new setRouters: teaRouterCollection
]

{ #category : #filters }
TeaCompositeRouter >> addAfterFilter: aTeaFilter [
	^ afterFilters add: aTeaFilter
]

{ #category : #filters }
TeaCompositeRouter >> addBeforeFilter: aTeaFilter [
	^ beforeFilters add: aTeaFilter
]

{ #category : #'error handing' }
TeaCompositeRouter >> addErrorHandler: aTeaErrorHandler [
	^ errorhandlers add: aTeaErrorHandler
]

{ #category : #accessing }
TeaCompositeRouter >> afterFilters [

	^afterFilters 
]

{ #category : #accessing }
TeaCompositeRouter >> beforeFilters [

	^beforeFilters 
]

{ #category : #private }
TeaCompositeRouter >> evaluateAfterFilters: aZnRequest response: aZnResponse [
	afterFilters do: [ :each | each handleRequest: aZnRequest response: aZnResponse ]
]

{ #category : #private }
TeaCompositeRouter >> evaluateBeforeFilters: aZnRequest [
	beforeFilters do: [ :each | each handleRequest: aZnRequest ]
]

{ #category : #private }
TeaCompositeRouter >> evaluateRouters: aZnRequest ifUnhandled: aBlock [
	routers do: [ :each | | response |
		response := each handleRequest: aZnRequest ifUnhandled: nil.
		response ifNotNil: [ ^ response ] ].
	^ aBlock value
]

{ #category : #private }
TeaCompositeRouter >> exceptionOccurred: anException request: aZnRequest [
	| handler |
	handler := errorhandlers 
		detect: [ :each | each canHandleError: anException ]
		ifNone: [ anException pass ].		
	^ handler handleError: anException request: (TeaRequest fromZnRequest: aZnRequest).
	
]

{ #category : #'zn delegate' }
TeaCompositeRouter >> handleRequest: aZnRequest [
	^ self 
		handleRequest: aZnRequest 
		ifUnhandled: [ notFoundHandler requestNotFound: aZnRequest ] 
]

{ #category : #'zn delegate' }
TeaCompositeRouter >> handleRequest: aZnRequest ifUnhandled: aBlock [
	| response |
	^ [ self evaluateBeforeFilters: aZnRequest.
	     response := self evaluateRouters: aZnRequest ifUnhandled: aBlock.
	     self evaluateAfterFilters: aZnRequest response: response.
	     response	
	   ] on: Exception 
	     do: [ :ex | self exceptionOccurred: ex request: aZnRequest ]
]

{ #category : #initialization }
TeaCompositeRouter >> initialize [
	super initialize.
	errorhandlers := OrderedCollection new.
	beforeFilters := OrderedCollection new.
	afterFilters := OrderedCollection new.
	notFoundHandler := TeaNotFoundHandler new.
]

{ #category : #'error handing' }
TeaCompositeRouter >> notFoundHandler: aTeaNotFoundHandler [
	notFoundHandler := aTeaNotFoundHandler
]

{ #category : #initialization }
TeaCompositeRouter >> setRouters: teaRouterCollection [
	routers := teaRouterCollection asArray.
	^ self
]
