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
	Example: Teapot configure: { #defaultOutput -> #json. #port -> 8080. #debugMode -> true }."
	
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
Teapot >> CONNECT: patternActionAssoc [
	self 
		addRouteMethod: #CONNECT 
		pattern: patternActionAssoc key
		action: patternActionAssoc value
]

{ #category : #'url mapping' }
Teapot >> DELETE: patternActionAssoc [
	self 
		addRouteMethod: #DELETE
		pattern: patternActionAssoc key
		action: patternActionAssoc value
]

{ #category : #'url mapping' }
Teapot >> GET: patternActionAssoc [
	self 
		addRouteMethod: #GET
		pattern: patternActionAssoc key
		action: patternActionAssoc value
]

{ #category : #'url mapping' }
Teapot >> HEAD: patternActionAssoc [
	self 
		addRouteMethod: #HEAD
		pattern: patternActionAssoc key
		action: patternActionAssoc value
]

{ #category : #'url mapping' }
Teapot >> OPTIONS: patternActionAssoc [
	self 
		addRouteMethod: #OPTIONS
		pattern: patternActionAssoc key
		action: patternActionAssoc value

]

{ #category : #'url mapping' }
Teapot >> PATCH: patternActionAssoc [
	self 
		addRouteMethod: #PATCH
		pattern: patternActionAssoc key
		action: patternActionAssoc value
]

{ #category : #'url mapping' }
Teapot >> POST: patternActionAssoc [
	self 
		addRouteMethod: #POST
		pattern: patternActionAssoc key
		action: patternActionAssoc value
]

{ #category : #'url mapping' }
Teapot >> PUT: patternActionAssoc [
	self 
		addRouteMethod: #PUT
		pattern: patternActionAssoc key
		action: patternActionAssoc value

]

{ #category : #'url mapping' }
Teapot >> TRACE: patternActionAssoc [
	self 
		addRouteMethod: #TRACE
		pattern: patternActionAssoc key 
		action: patternActionAssoc value
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

{ #category : #private }
Teapot >> addRouteMethod: methodSymbol pattern: pattern action: aTeaAction [
	currentRoute := dynamicRouter addRoute:
		(TeaRoute
			method: (TeaMethodMatcher exactly: methodSymbol)
			urlPattern: pattern asTeaUrlPattern
			action: aTeaAction
			transformer: defaultOutput)
]

{ #category : #'url mapping' }
Teapot >> before: patternActionAssoc [
	compositeRouter addBeforeFilter:
		(TeaRoute
			method: TeaMethodMatcher any
			urlPattern: patternActionAssoc key asTeaUrlPattern
			action: patternActionAssoc value
			transformer: TeaOutput none)
]

{ #category : #'url mapping' }
Teapot >> exception: anExceptionSetActionAssoc [    
	compositeRouter 
		addErrorHandler: anExceptionSetActionAssoc value 
		exceptions: anExceptionSetActionAssoc key   
    
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

{ #category : #'url mapping' }
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
	staticRouter urlPrefix: urlPrefixString path: pathString
]

{ #category : #accessing }
Teapot >> server [
	^ server
]

{ #category : #controlling }
Teapot >> start [
	^ server start
]

{ #category : #controlling }
Teapot >> stop [
	server stop
]
