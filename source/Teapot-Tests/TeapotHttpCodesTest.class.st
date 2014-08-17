Class {
	#name : #TeapotHttpCodesTest,
	#superclass : #TestCase,
	#instVars : [
		'server'
	],
	#category : #'Teapot-Tests'
}

{ #category : #running }
TeapotHttpCodesTest >> setUp [
	server := Teapot on
		GET: 'badrequest' -> [ :req | req abort: (ZnResponse badRequest: req) ];
		GET: 'unauthorized' -> [ :req | req abort: (ZnResponse unauthorized) ];
		start.
]

{ #category : #running }
TeapotHttpCodesTest >> tearDown [
	server stop
]

{ #category : #tests }
TeapotHttpCodesTest >> testErrorCodes [
	self assert: (TeaClient httpGet: '/badrequest') code equals: 400.
	self assert: (TeaClient httpGet: '/unauthorized') code equals: 401.
]
