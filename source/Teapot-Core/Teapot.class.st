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
Teapot >> CONNECT: patternString do: handlerBlock [
	self 
		newRouteMethod: #CONNECT 
		pattern: patternString 
		handler: handlerBlock
]

{ #category : #'url mapping' }
Teapot >> DELETE: patternString do: handlerBlock [
	self 
		newRouteMethod: #DELETE
		pattern: patternString 
		handler: handlerBlock
]

{ #category : #'url mapping' }
Teapot >> GET: patternString do: handlerBlock [
	self 
		newRouteMethod: #GET
		pattern: patternString 
		handler: handlerBlock
]

{ #category : #'url mapping' }
Teapot >> HEAD: patternString do: handlerBlock [
	self 
		newRouteMethod: #HEAD
		pattern: patternString 
		handler: handlerBlock
]

{ #category : #'url mapping' }
Teapot >> OPTIONS: patternString do: handlerBlock [
	self 
		newRouteMethod: #OPTIONS
		pattern: patternString 
		handler: handlerBlock

]

{ #category : #'url mapping' }
Teapot >> PATCH: patternString do: handlerBlock [
	self 
		newRouteMethod: #PATCH
		pattern: patternString 
		handler: handlerBlock
]

{ #category : #'url mapping' }
Teapot >> POST: patternString do: handlerBlock [
	self 
		newRouteMethod: #POST
		pattern: patternString 
		handler: handlerBlock
]

{ #category : #'url mapping' }
Teapot >> PUT: patternString do: handlerBlock [
	self 
		newRouteMethod: #PUT
		pattern: patternString 
		handler: handlerBlock

]

{ #category : #'url mapping' }
Teapot >> TRACE: patternString do: handlerBlock [
	self 
		newRouteMethod: #TRACE
		pattern: patternString 
		handler: handlerBlock
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
