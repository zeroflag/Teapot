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
		'port',
		'dynamicRouter',
		'staticRouter',
		'compositeRouter',
		'defaultTransformer'
	],
	#category : #'Teapot-Core'
}

{ #category : #'instance creation' }
Teapot class >> defaultFormat: transformerBlockOrSymbol [
	^ self new setDefaultFormat: transformerBlockOrSymbol
]

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

{ #category : #private }
Teapot >> defaultTransformer [
	^ defaultTransformer
]

{ #category : #'error handing' }
Teapot >> exception: anExceptionSetHandlerAssoc [    
	compositeRouter 
		addErrorHandler: anExceptionSetHandlerAssoc value 
		exceptions: anExceptionSetHandlerAssoc key   
    
]

{ #category : #initialization }
Teapot >> initialize [
	super initialize.
	dynamicRouter := TeaDynamicRouter new.
	staticRouter := TeaStaticRouter new.
	compositeRouter := TeaCompositeRouter routers: { dynamicRouter. staticRouter }.
	defaultTransformer := TeaFormat html.
	port := 8080.

]

{ #category : #controlling }
Teapot >> logToTranscript [
	^ server logToTranscript
]

{ #category : #private }
Teapot >> newRouteMethod: methodSymbol pattern: patternString handler: handlerBlock [
	currentRoute := dynamicRouter addRoute:
		(TeaRoute
			method: methodSymbol
			urlPattern: patternString
			handler: handlerBlock
			transformer: self defaultTransformer)
]

{ #category : #'response transform' }
Teapot >> output: transformerBlockOrSymbol [
	currentRoute responseTransformer: (self responseTransformer: transformerBlockOrSymbol)
	
]

{ #category : #accessing }
Teapot >> port [
	^ port
]

{ #category : #accessing }
Teapot >> port: aNumber [
	port := aNumber
]

{ #category : #private }
Teapot >> responseTransformer: transformerBlockOrSymbol [
	^ transformerBlockOrSymbol isSymbol
		ifTrue: [ TeaFormat perform: transformerBlockOrSymbol ]
		ifFalse: [ transformerBlockOrSymbol ]
]

{ #category : #'url mapping' }
Teapot >> serveStatic: urlPrefixString from: pathString [	
	staticRouter 
		urlPrefix: urlPrefixString 
		path: pathString.
]

{ #category : #accessing }
Teapot >> server [
	^ server
]

{ #category : #initialization }
Teapot >> setDefaultFormat: transformerBlockOrSymbol [
	defaultTransformer := self responseTransformer: transformerBlockOrSymbol.
	^ self
]

{ #category : #controlling }
Teapot >> start [
	server := (ZnServer startOn: self port)
		delegate: compositeRouter;
		yourself.
	^ self
]

{ #category : #controlling }
Teapot >> stop [
	server ifNotNil: [ server stop ]
]
