"
I'm a ZnDelegate. I serve dynamically generated content.
"
Class {
	#name : #TeaDynamicRouter,
	#superclass : #TeaRouter,
	#instVars : [
		'routes'
	],
	#category : #'Teapot-Core'
}

{ #category : #'route dispatcher' }
TeaDynamicRouter >> addRoute: aRoute [
	^ routes add: aRoute.
	
]

{ #category : #'zn delegate' }
TeaDynamicRouter >> handleRequest: aZnRequest [
	| response |
	response := self newResponse.
	routes
		detect: [ :each | each handleRequest: aZnRequest response: response ]
		ifNone: [ ^ ZnResponse notFound: aZnRequest uri ].
	^ response
]

{ #category : #initialization }
TeaDynamicRouter >> initialize [
	super initialize.
	routes := OrderedCollection new.
]

{ #category : #private }
TeaDynamicRouter >> newResponse [
	| response |
	response := ZnResponse new 
		statusLine: ZnStatusLine ok;
		headers: ZnHeaders defaultResponseHeaders;
		yourself.
	response headers contentType: ZnMimeType textPlain. "TODO, van default transformer, de ha a user to:-nal megad vmit es nem allit be semmit akkor elszall"
	^ response
]
