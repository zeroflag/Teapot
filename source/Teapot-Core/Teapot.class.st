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
	currentRoute := dispatcher addRoute:
		(TeaRoute
			method: #CONNECT
			urlPattern: patternString
			handler: handlerBlock
			transformer: TeaFormat text)
]

{ #category : #'url mapping' }
Teapot >> DELETE: patternString do: handlerBlock [
	currentRoute := dispatcher addRoute:
		(TeaRoute
			method: #DELETE
			urlPattern: patternString
			handler: handlerBlock
			transformer: TeaFormat text)
]

{ #category : #'url mapping' }
Teapot >> GET: patternString do: aBlock [
	currentRoute := dispatcher addRoute:
		(TeaRoute
			method: #GET
			urlPattern: patternString
			handler: aBlock
			transformer: TeaFormat text)
]

{ #category : #'url mapping' }
Teapot >> HEAD: patternString do: aBlock [
	currentRoute := dispatcher addRoute:
		(TeaRoute
			method: #HEAD
			urlPattern: patternString
			handler: aBlock
			transformer: TeaFormat text)
]

{ #category : #'url mapping' }
Teapot >> OPTIONS: patternString do: handlerBlock [
	currentRoute := dispatcher addRoute:
		(TeaRoute
			method: #OPTIONS
			urlPattern: patternString
			handler: handlerBlock
			transformer: TeaFormat text)
]

{ #category : #'url mapping' }
Teapot >> PATCH: patternString do: handlerBlock [
	currentRoute := dispatcher addRoute:
		(TeaRoute
			method: #PATCH
			urlPattern: patternString
			handler: handlerBlock
			transformer: TeaFormat text)
]

{ #category : #'url mapping' }
Teapot >> POST: patternString do: handlerBlock [
	currentRoute := dispatcher addRoute:
		(TeaRoute
			method: #POST
			urlPattern: patternString
			handler: handlerBlock
			transformer: TeaFormat text)
]

{ #category : #'url mapping' }
Teapot >> PUT: patternString do: handlerBlock [
	currentRoute := dispatcher addRoute:
		(TeaRoute
			method: #PUT
			urlPattern: patternString
			handler: handlerBlock
			transformer: TeaFormat text)
]

{ #category : #'url mapping' }
Teapot >> TRACE: patternString do: handlerBlock [
	currentRoute := dispatcher addRoute:
		(TeaRoute
			method: #TRACE
			urlPattern: patternString
			handler: handlerBlock
			transformer: TeaFormat text)
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
