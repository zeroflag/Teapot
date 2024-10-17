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

For more configuration option see the Teapot class>>configure method.
"
Class {
	#name : 'Teapot',
	#superclass : 'Object',
	#instVars : [
		'server',
		'dynamicRouter',
		'staticRouter',
		'compositeRouter',
		'defaultOutput',
		'current'
	],
	#category : 'Teapot-Core',
	#package : 'Teapot-Core'
}

{ #category : 'instance creation' }
Teapot class >> configure: optionsAssociations [
	"Create a new Teapot instance with optional properties.
 	 - Teapot properties: #defaultOutput, #znServer
	 - ZnServer properties: See options protocol of ZnServer for specific usages.	
	Example: Teapot configure: { 
		#defaultOutput -> #json. 
		#bindAddress -> #[192 168 0 3].
		#port -> 8080. 
		#debugMode -> true.
		#notFoundHandlerClass -> Tea405AwareNotFoundHandler.
	}."
	
	^ self new initializeOptions: optionsAssociations asDictionary
]

{ #category : 'instance creation' }
Teapot class >> on [
	"Create Teapot with default properties."
	
	^ self configure: { }
]

{ #category : 'controlling' }
Teapot class >> stopAll [
	self allInstancesDo: #stop
]

{ #category : 'url mapping' }
Teapot >> CONNECT: patternActionAssoc [
	self
		addRouteMethod: (TeaMethodMatcher exactly: #CONNECT)
		pattern: patternActionAssoc key
		action: patternActionAssoc value
]

{ #category : 'url mapping' }
Teapot >> DELETE: patternActionAssoc [
	self
		addRouteMethod: (TeaMethodMatcher exactly: #DELETE)
		pattern: patternActionAssoc key
		action: patternActionAssoc value
]

{ #category : 'url mapping' }
Teapot >> GET: patternActionAssoc [
	self 
		addRouteMethod: (TeaMethodMatcher exactly: #GET) 
		pattern: patternActionAssoc key 
		action: patternActionAssoc value
]

{ #category : 'url mapping' }
Teapot >> HEAD: patternActionAssoc [
	self 
		addRouteMethod: (TeaMethodMatcher exactly: #HEAD) 
		pattern: patternActionAssoc key 
		action: patternActionAssoc value
]

{ #category : 'url mapping' }
Teapot >> OPTIONS: patternActionAssoc [
	self
		addRouteMethod: (TeaMethodMatcher exactly: #OPTIONS)
		pattern: patternActionAssoc key
		action: patternActionAssoc value
]

{ #category : 'url mapping' }
Teapot >> PATCH: patternActionAssoc [
	self
		addRouteMethod: (TeaMethodMatcher exactly: #PATCH)
		pattern: patternActionAssoc key
		action: patternActionAssoc value
]

{ #category : 'url mapping' }
Teapot >> POST: patternActionAssoc [
	self 
		addRouteMethod: (TeaMethodMatcher exactly: #POST) 
		pattern: patternActionAssoc key 
		action: patternActionAssoc value
]

{ #category : 'url mapping' }
Teapot >> PUT: patternActionAssoc [
	self 
		addRouteMethod: (TeaMethodMatcher exactly: #PUT) 
		pattern: patternActionAssoc key 
		action: patternActionAssoc value
]

{ #category : 'url mapping' }
Teapot >> TRACE: patternActionAssoc [
	self
		addRouteMethod: (TeaMethodMatcher exactly: #TRACE)
		pattern: patternActionAssoc key
		action: patternActionAssoc value
]

{ #category : 'private' }
Teapot >> addRouteMethod: aTeaMethodMatcher pattern: pattern action: aTeaAction [
	current := dynamicRouter addRoute:
		(TeaRoute
			matcher: (TeaRequestMatcher method: aTeaMethodMatcher url: pattern asTeaUrlPattern)
			action: aTeaAction
			transformer: defaultOutput
			port: server port)
]

{ #category : 'filters' }
Teapot >> after: patternActionAssoc [
	current := compositeRouter addAfterFilter:		
		(TeaAfterFilter 
			urlPattern: patternActionAssoc key asTeaUrlPattern 
			action: patternActionAssoc value)
]

{ #category : 'url mapping' }
Teapot >> any: patternActionAssoc [
	self
		addRouteMethod: TeaMethodMatcher any
		pattern: patternActionAssoc key
		action: patternActionAssoc value
]

{ #category : 'filters' }
Teapot >> before: patternActionAssoc [
	current := compositeRouter addBeforeFilter:		
		(TeaBeforeFilter 
			urlPattern: patternActionAssoc key asTeaUrlPattern 
			action: patternActionAssoc value)
]

{ #category : 'url mapping' }
Teapot >> exception: anExceptionSetActionAssoc [
	current := compositeRouter addErrorHandler:
		(TeaErrorHandler
			for: anExceptionSetActionAssoc key
			action: anExceptionSetActionAssoc value
			responseTransformer: defaultOutput)
]

{ #category : 'initialization' }
Teapot >> initializeOptions: optionsDictionary [
	dynamicRouter := TeaDynamicRouter new.
	staticRouter := TeaStaticRouter new.
	compositeRouter := TeaCompositeRouter routers: {dynamicRouter. staticRouter}.	
	defaultOutput := self responseTransformer: (optionsDictionary at: #defaultOutput ifAbsent: #html).									
	self exception: TeaAbort -> [ :abort :req | abort response teaTransform: [ :same | same ] request: req].
	server := optionsDictionary 
		at: #znServer
		ifAbsent: [ ZnServer defaultServerClass new ].
	optionsDictionary 
		at: #notFoundHandlerClass 
		ifPresent: [:class | compositeRouter notFoundHandler: (class new initializeRoutes: dynamicRouter routes)].
	server delegate: compositeRouter.	
	optionsDictionary keysAndValuesDo: [ :key :value | server optionAt: key put: value ].
	^ self
]

{ #category : 'url mapping' }
Teapot >> output: transformerBlockOrSymbol [
	current responseTransformer: (self responseTransformer: transformerBlockOrSymbol)
	
]

{ #category : 'private' }
Teapot >> responseTransformer: transformerBlockOrSymbol [
	^ transformerBlockOrSymbol isSymbol
		ifTrue: [ TeaOutput perform: transformerBlockOrSymbol ]
		ifFalse: [ transformerBlockOrSymbol ]
]

{ #category : 'url mapping' }
Teapot >> serveStatic: urlPrefixString from: pathString [	
	staticRouter urlPrefix: urlPrefixString path: pathString
]

{ #category : 'accessing' }
Teapot >> server [
	^ server
]

{ #category : 'controlling' }
Teapot >> start [
	server start
]

{ #category : 'controlling' }
Teapot >> stop [
	server stop
]

{ #category : 'filters' }
Teapot >> when: aBlockClosure [ 
	current whenClause: aBlockClosure
	
]
