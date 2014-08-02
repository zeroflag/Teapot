Class {
	#name : #TeapotMessageSendTest,
	#superclass : #TestCase,
	#instVars : [
		'server'
	],
	#category : #'Teapot-Tests'
}

{ #category : #'web controller' }
TeapotMessageSendTest >> msg1 [
	^ 'msg1 result'
]

{ #category : #'web controller' }
TeapotMessageSendTest >> msg2Req: req resp: resp [
	^ 'msg2 ', (req at: #param)
]

{ #category : #'web controller' }
TeapotMessageSendTest >> msg3Req: req [
	^ 'msg3 ', (req at: #param)
]

{ #category : #running }
TeapotMessageSendTest >> setUp [
	server := Teapot on
		GET: '/msg1' -> (Send message: #msg1 to: self);
		GET: '/msg2/<param>' -> (Send message: #msg2Req:resp: to: self);		
		GET: '/msg3/<param>' -> (Send message: #msg3Req: to: self);					
		start.		
]

{ #category : #running }
TeapotMessageSendTest >> tearDown [
	server stop
]

{ #category : #tests }
TeapotMessageSendTest >> testReceivingOneArgKeywordMessage [
	self assert: (TeaClient httpGetString: '/msg3/bar') equals: 'msg3 bar'.
]

{ #category : #tests }
TeapotMessageSendTest >> testReceivingTwoArgsKeywordMessage [
	self assert: (TeaClient httpGetString: '/msg2/foo') equals: 'msg2 foo'.
]

{ #category : #tests }
TeapotMessageSendTest >> testReceivingUnaryMessage [
	self assert: (TeaClient httpGetString: '/msg1') equals: 'msg1 result'.
]
