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
		GET: 'badrequest' -> [ :req :resp | resp code: 400 ];
		GET: 'forbidden' -> [ :req :resp | resp code: 403 reason: 'go away' ];
		start		
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
