Class {
	#name : #TeapotAbortTest,
	#superclass : #TestCase,
	#instVars : [
		'server'
	],
	#category : #'Teapot-Tests'
}

{ #category : #running }
TeapotAbortTest >> setUp [
	server := Teapot on
		GET: 'badrequest' -> [ :req | req abort: (ZnResponse badRequest: req) ];
		GET: 'unauthorized' -> [ :req | req abort: TeaResponse unauthorized ];
		GET: 'abortstring' -> [ :req | req abort: 'abort test' ];		
		start.
]

{ #category : #running }
TeapotAbortTest >> tearDown [
	server stop
]

{ #category : #tests }
TeapotAbortTest >> testAbortSupportsAnyObject [
	self assert: (TeaClient httpGetString: '/abortstring') equals: 'abort test'.
]

{ #category : #tests }
TeapotAbortTest >> testErrorCodes [
	self assert: (TeaClient httpGet: '/badrequest') code equals: 400.
	self assert: (TeaClient httpGet: '/unauthorized') code equals: 401.
]
