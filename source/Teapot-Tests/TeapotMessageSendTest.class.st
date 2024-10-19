Class {
	#name : 'TeapotMessageSendTest',
	#superclass : 'TestCase',
	#instVars : [
		'server'
	],
	#category : 'Teapot-Tests',
	#package : 'Teapot-Tests'
}

{ #category : 'web controller' }
TeapotMessageSendTest >> msg1 [
	^ 'msg1 result'
]

{ #category : 'web controller' }
TeapotMessageSendTest >> msg2Req: req nil: resp [
	self assert: resp isNil.
	^ 'msg2 ', (req at: #param)
]

{ #category : 'web controller' }
TeapotMessageSendTest >> msg3Req: req [
	^ 'msg3 ', (req at: #param)
]

{ #category : 'running' }
TeapotMessageSendTest >> setUp [
	server := Teapot on
		GET: '/msg1' -> (Send message: #msg1 to: self);
		GET: '/msg2/<param>' -> (Send message: #msg2Req:nil: to: self);		
		GET: '/msg3/<param>' -> (Send message: #msg3Req: to: self);					
		start.		
]

{ #category : 'running' }
TeapotMessageSendTest >> tearDown [
	server stop
]

{ #category : 'tests' }
TeapotMessageSendTest >> testReceivingOneArgKeywordMessage [
	self assert: (TeaTestClient httpGetString: '/msg3/bar') equals: 'msg3 bar'.
]

{ #category : 'tests' }
TeapotMessageSendTest >> testReceivingTwoArgsKeywordMessage [
	self assert: (TeaTestClient httpGetString: '/msg2/foo') equals: 'msg2 foo'.
]

{ #category : 'tests' }
TeapotMessageSendTest >> testReceivingUnaryMessage [
	self assert: (TeaTestClient httpGetString: '/msg1') equals: 'msg1 result'.
]
