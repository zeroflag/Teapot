"
I'm a ZnDelegate. I dispatches http requests to routes.
"
Class {
	#name : #TeaDispatcher,
	#superclass : #Object,
	#instVars : [
		'routes'
	],
	#category : #'Teapot-Core'
}

{ #category : #'route dispatcher' }
TeaDispatcher >> addRoute: aRoute [
	^ routes add: aRoute.
	
]

{ #category : #'zn delegate' }
TeaDispatcher >> handleRequest: aZnRequest [
	| response |
	response := self newResponse.
	routes
		detect: [ :each | each handleRequest: aZnRequest response: response ]
		ifNone: [ ^ ZnResponse notFound: aZnRequest uri ].
	^ response
]

{ #category : #initialization }
TeaDispatcher >> initialize [
	super initialize.
	routes := OrderedCollection new.
]

{ #category : #private }
TeaDispatcher >> newResponse [
	| response |
	response := ZnResponse new 
		statusLine: ZnStatusLine ok;
		headers: ZnHeaders defaultResponseHeaders;
		yourself.
	response headers contentType: ZnMimeType textPlain. "TODO, van default transformer, de ha a user to:-nal megad vmit es nem allit be semmit akkor elszall"
	^ response
]
