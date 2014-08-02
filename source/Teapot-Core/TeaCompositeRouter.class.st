"
I'm a composite zn delegate, built from other zn delegates. I forward the request to the first delegate that returns other than 404.
"
Class {
	#name : #TeaCompositeRouter,
	#superclass : #TeaRouter,
	#instVars : [
		'routers'
	],
	#category : #'Teapot-Core'
}

{ #category : #'instance creation' }
TeaCompositeRouter class >> routers: teaRouterCollection [
	^ self new setRouters: teaRouterCollection
]

{ #category : #'zn delegate' }
TeaCompositeRouter >> handleRequest: aZnRequest [
	| response |
	routers do: [ :each | 
		response := each handleRequest: aZnRequest. 
		response isNotFound ifFalse: [^ response ] ].
	^ ZnResponse notFound: aZnRequest uri
]

{ #category : #initialization }
TeaCompositeRouter >> setRouters: teaRouterCollection [
	routers := teaRouterCollection.
	^ self
]
