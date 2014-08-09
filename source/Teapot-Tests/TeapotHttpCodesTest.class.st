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
		GET: 'badrequest' -> [ :req | req abort: 400 ];
		GET: 'forbidden' -> [ :req | req abort: 403 reason: 'go away' ];
		start.
]

{ #category : #running }
TeapotHttpCodesTest >> tearDown [
	server stop
]

{ #category : #tests }
TeapotHttpCodesTest >> testErrorCodes [
	self assert: (TeaClient httpGet: '/badrequest') code equals: 400.
	self assert: (TeaClient httpGet: '/forbidden') code equals: 403.
]
