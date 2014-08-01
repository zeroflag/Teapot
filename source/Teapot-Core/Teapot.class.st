"
I'm the Teapot server on top of ZnServer. I can handle URL routing as follows:

Teapot on
	GET: '/user' do: [ 'Test user' ];	
	GET: '/user/:id' do: [ :req :resp :params | (params at: #id) ];
	start.
"
Class {
	#name : #Teapot,
	#superclass : #Object,
	#instVars : [
		'server',
		'currentRoute',
		'dispatcher'
	],
	#category : #'Teapot-Core'
}

{ #category : #'instance creation' }
Teapot class >> on [
	^ self new
]

{ #category : #controlling }
Teapot class >> stopAll [
	self allInstancesDo: #stop
]

{ #category : #'url mapping' }
Teapot >> CONNECT: patternHandlerAssoc [
	self 
		newRouteMethod: #CONNECT 
		pattern: patternHandlerAssoc key
		handler: patternHandlerAssoc value
]

{ #category : #'url mapping' }
Teapot >> DELETE: patternHandlerAssoc [
	self 
		newRouteMethod: #DELETE
		pattern: patternHandlerAssoc key
		handler: patternHandlerAssoc value
]

{ #category : #'url mapping' }
Teapot >> GET: patternHandlerAssoc [
	self 
		newRouteMethod: #GET
		pattern: patternHandlerAssoc key
		handler: patternHandlerAssoc value
]

{ #category : #'url mapping' }
Teapot >> HEAD: patternHandlerAssoc [
	self 
		newRouteMethod: #HEAD
		pattern: patternHandlerAssoc key
		handler: patternHandlerAssoc value
]

{ #category : #'url mapping' }
Teapot >> OPTIONS: patternHandlerAssoc [
	self 
		newRouteMethod: #OPTIONS
		pattern: patternHandlerAssoc key
		handler: patternHandlerAssoc value

]

{ #category : #'url mapping' }
Teapot >> PATCH: patternHandlerAssoc [
	self 
		newRouteMethod: #PATCH
		pattern: patternHandlerAssoc key
		handler: patternHandlerAssoc value
]

{ #category : #'url mapping' }
Teapot >> POST: patternHandlerAssoc [
	self 
		newRouteMethod: #POST
		pattern: patternHandlerAssoc key
		handler: patternHandlerAssoc value
]

{ #category : #'url mapping' }
Teapot >> PUT: patternHandlerAssoc [
	self 
		newRouteMethod: #PUT
		pattern: patternHandlerAssoc key
		handler: patternHandlerAssoc value

]

{ #category : #'url mapping' }
Teapot >> TRACE: patternHandlerAssoc [
	self 
		newRouteMethod: #TRACE
		pattern: patternHandlerAssoc key 
		handler: patternHandlerAssoc value
]

{ #category : #initialization }
Teapot >> initialize [
	super initialize.
	dispatcher := TeaDispatcher new.
]

{ #category : #controlling }
Teapot >> logToTranscript [
	^ server logToTranscript
]

{ #category : #private }
Teapot >> newRouteMethod: methodSymbol pattern: patternString handler: handlerBlock [
	currentRoute := dispatcher addRoute:
		(TeaRoute
			method: methodSymbol
			urlPattern: patternString
			handler: handlerBlock
			transformer: TeaFormat text)
]

{ #category : #controlling }
Teapot >> start [
	server := (ZnServer startOn: 8080) 
		delegate: dispatcher;
		yourself
]

{ #category : #controlling }
Teapot >> stop [
	server ifNotNil: [ server stop ]
]

{ #category : #'url mapping' }
Teapot >> to: transformerBlock [
	"transform the result of the handler block"
	currentRoute responseTransformer: transformerBlock
]
