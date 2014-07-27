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
		'routes'
	],
	#category : #'Teapot-Core-Teapot-Core'
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
Teapot >> GET: patternString do: aBlock [
	self GET: patternString do: aBlock as: #asString
]

{ #category : #'url mapping' }
Teapot >> GET: patternString do: handlerBlock as: transformerBlock [
	self addRoute:
		(Route
			method: #GET
			urlPattern: patternString
			handler: handlerBlock
			transformer: transformerBlock)
]

{ #category : #private }
Teapot >> addRoute: aRoute [
	routes add: aRoute
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
