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
		'routes',
		'currentRoute'
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
Teapot >> DELETE: patternString do: handlerBlock [
	self addRoute:
		(TeaRoute
			method: #DELETE
			urlPattern: patternString
			handler: handlerBlock
			transformer: TeaFormat text)
]

{ #category : #'url mapping' }
Teapot >> GET: patternString do: aBlock [
	self addRoute:
		(TeaRoute
			method: #GET
			urlPattern: patternString
			handler: aBlock
			transformer: TeaFormat text)
]

{ #category : #'url mapping' }
Teapot >> OPTIONS: patternString do: handlerBlock [
	self addRoute:
		(TeaRoute
			method: #OPTIONS
			urlPattern: patternString
			handler: handlerBlock
			transformer: TeaFormat text)
]

{ #category : #'url mapping' }
Teapot >> POST: patternString do: handlerBlock [
	self addRoute:
		(TeaRoute
			method: #POST
			urlPattern: patternString
			handler: handlerBlock
			transformer: TeaFormat text)
]

{ #category : #'url mapping' }
Teapot >> PUT: patternString do: handlerBlock [
	self addRoute:
		(TeaRoute
			method: #PUT
			urlPattern: patternString
			handler: handlerBlock
			transformer: TeaFormat text)
]

{ #category : #private }
Teapot >> addRoute: aRoute [
	currentRoute := routes add: aRoute.
	
]

{ #category : #'zn delegate' }
Teapot >> handleRequest: aZnRequest [
	^ self 
		routeRequest: aZnRequest
		response: self newResponse

]

{ #category : #initialization }
Teapot >> initialize [
	super initialize.
	routes := OrderedCollection new.	
]

{ #category : #controlling }
Teapot >> logToTranscript [
	^ server logToTranscript
]

{ #category : #private }
Teapot >> newResponse [
	| response |
	response := ZnResponse new 
		statusLine: ZnStatusLine ok;
		headers: ZnHeaders defaultResponseHeaders;
		yourself.
	response headers contentType: 'text/plain'. "TODO, van default transformer, de ha a user to:-nal megad vmit es nem allit be semmit akkor elszall"
	^ response
]

{ #category : #private }
Teapot >> routeRequest: aZnRequest response: aZnResponse [
	routes 
		detect: [ :each | each handleRequest: aZnRequest response: aZnResponse ]
		ifNone: [ ^ ZnResponse notFound: aZnRequest uri ].
	^ aZnResponse
]

{ #category : #controlling }
Teapot >> start [
	server := (ZnServer startOn: 8080) 
		delegate: self;
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
