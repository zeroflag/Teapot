"
I decides what response to return when there were not matching routes (and no static path) for the incoming request. By default I just return 404.
"
Class {
	#name : 'TeaNotFoundHandler',
	#superclass : 'Object',
	#instVars : [
		'routes'
	],
	#category : 'Teapot-Core',
	#package : 'Teapot-Core'
}

{ #category : 'initialization' }
TeaNotFoundHandler >> initialize [
	super initialize.
	routes := OrderedCollection new.
]

{ #category : 'initialization' }
TeaNotFoundHandler >> initializeRoutes: aTeaRouteCollection [
	routes := aTeaRouteCollection.
	^ self
]

{ #category : 'not found handler' }
TeaNotFoundHandler >> requestNotFound: aZnRequest [
	^ ZnResponse notFound: aZnRequest url
]
