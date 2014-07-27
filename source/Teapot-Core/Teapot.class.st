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
		(Route
			method: #DELETE
			urlPattern: patternString
			handler: handlerBlock
			transformer: #asString)
]

{ #category : #'url mapping' }
Teapot >> GET: patternString do: aBlock [
	self addRoute:
		(Route
			method: #GET
			urlPattern: patternString
			handler: aBlock
			transformer: #asString)
]

{ #category : #'url mapping' }
Teapot >> OPTIONS: patternString do: handlerBlock [
	self addRoute:
		(Route
			method: #OPTIONS
			urlPattern: patternString
			handler: handlerBlock
			transformer: #asString)
]

{ #category : #'url mapping' }
Teapot >> POST: patternString do: handlerBlock [
	self addRoute:
		(Route
			method: #POST
			urlPattern: patternString
			handler: handlerBlock
			transformer: #asString)
]

{ #category : #'url mapping' }
Teapot >> PUT: patternString do: handlerBlock [
	self addRoute:
		(Route
			method: #PUT
			urlPattern: patternString
			handler: handlerBlock
			transformer: #asString)
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

{ #category : #private }
Teapot >> newResponse [
	^ ZnResponse new 
		statusLine: ZnStatusLine ok;
		headers: ZnHeaders defaultResponseHeaders;
		yourself
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
	currentRoute transformer: transformerBlock
]
