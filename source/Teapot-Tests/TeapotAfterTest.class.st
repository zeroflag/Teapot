Class {
	#name : #TeapotAfterTest,
	#superclass : #TestCase,
	#instVars : [
		'server',
		'log'
	],
	#category : #'Teapot-Tests'
}

{ #category : #running }
TeapotAfterTest >> setUp [
	log := OrderedCollection new.
	server := Teapot on
		after: '/cleanup/<param>' -> [ :req | log add: (req at: #param) ]; 
		GET: '/cleanup/error' -> [ self error: 'abort request' ];
		GET: '/cleanup/*' -> 'result';
		start		
]

{ #category : #running }
TeapotAfterTest >> tearDown [
	server stop
]

{ #category : #tests }
TeapotAfterTest >> testAfterHandlerIsAlwaysEvaluated [
	TeaClient httpGet: '/cleanup/error'.		
	self assert: log asArray equals: #(error).
]

{ #category : #tests }
TeapotAfterTest >> testMultipleAfterHandlers [
	self assert: (TeaClient httpGetString: '/cleanup/a') equals: 'result'.
	TeaClient httpPost: '/cleanup/b'.		
	TeaClient httpGet: 'c'.
		
	self assert: log asArray equals: #(a b).
]
