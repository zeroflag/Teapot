"
I'm the Teapot server on top of ZnServer. I can handle URL routing as follows:

Teapot on
      GET: '/hi' -> 'Hello World!';
      GET: '/a/*/b' -> (Send message: #ab: to: controller);
	GET: '/users' -> [ users ]; output: #json	
	GET: '/user/<id>' -> [ :req | (req at: #id) ]; output: #ston;
      PUT: '/books/<id>' -> [ :req | | book |
	  book := Book author: (req at: #author) title: (req at: #title).
	  books at: (req at: #id) put: book ]; 
	  output: #ston;
	start.
"
Class {
	#name : #Teapot,
	#superclass : #Object,
	#instVars : [
		'server',
		'currentRoute',
		'dynamicRouter',
		'staticRouter',
		'compositeRouter',
		'defaultOutput'
	],
	#category : #'Teapot-Core'
}

{ #category : #'instance creation' }
Teapot class >> configure: optionsAssociations [
	"Create a new Teapot instance with optional properties.
 	 - Teapot properties: #defaultOutput
	 - ZnServer properties: See options protocol of ZnServer for specific usages.	
	Example: Teapot configure: { #defaultOutput -> #json. #port -> 8080 }."
	
	^ self new initializeOptions: optionsAssociations
]

{ #category : #'instance creation' }
Teapot class >> on [
	"Create Teapot with default properties."
	
	^ self configure: { }
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
Teapot >> addAbortHandlerTo: aRouter [
	aRouter
		addErrorHandler: [ :ex | ZnResponse new
				statusLine: ex asStatusLine;
				headers: ZnHeaders defaultResponseHeaders;
				yourself ]
		exceptions: TeaAbort
]

{ #category : #filters }
Teapot >> before: patternHandlerAssoc [
	compositeRouter addBeforeFilter:
		(TeaRoute
			method: TeaMethodMatcher any
			urlPattern: (TeaUrlPattern parseString: patternHandlerAssoc key)
			handler: patternHandlerAssoc value
			transformer: TeaOutput none)
]

{ #category : #'error handing' }
Teapot >> exception: anExceptionSetHandlerAssoc [    
	compositeRouter 
		addErrorHandler: anExceptionSetHandlerAssoc value 
		exceptions: anExceptionSetHandlerAssoc key   
    
]

{ #category : #initialization }
Teapot >> initializeOptions: optionsAssociations [		
	dynamicRouter := TeaDynamicRouter new.
	staticRouter := TeaStaticRouter new.
	compositeRouter := TeaCompositeRouter routers: {dynamicRouter. staticRouter}.	
	self addAbortHandlerTo: compositeRouter.

	server := ZnServer defaultServerClass new.
	server delegate: compositeRouter.
	
	optionsAssociations do: [ :each | server optionAt: each key put:  each value ].
	defaultOutput := self responseTransformer: (optionsAssociations asDictionary at: #defaultOutput ifAbsent: #html).							
	^ self
]

{ #category : #controlling }
Teapot >> logToTranscript [
	^ server logToTranscript
]

{ #category : #private }
Teapot >> newRouteMethod: methodSymbol pattern: patternString handler: handlerBlock [
	currentRoute := dynamicRouter addRoute:
		(TeaRoute
			method: (TeaMethodMatcher exactly: methodSymbol)
			urlPattern: (TeaUrlPattern parseString: patternString)
			handler: handlerBlock
			transformer: defaultOutput)
]

{ #category : #'response transform' }
Teapot >> output: transformerBlockOrSymbol [
	currentRoute responseTransformer: (self responseTransformer: transformerBlockOrSymbol)
	
]

{ #category : #private }
Teapot >> responseTransformer: transformerBlockOrSymbol [
	^ transformerBlockOrSymbol isSymbol
		ifTrue: [ TeaOutput perform: transformerBlockOrSymbol ]
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

{ #category : #controlling }
Teapot >> start [
	^ server start.
]

{ #category : #controlling }
Teapot >> startOn: portNumber [
	server port: portNumber.
	server start.
	^ self
]

{ #category : #controlling }
Teapot >> stop [
	server stop
]
