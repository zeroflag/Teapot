Class {
	#name : #TeapotBeforeTest,
	#superclass : #TestCase,
	#instVars : [
		'server',
		'log'
	],
	#category : #'Teapot-Tests'
}

{ #category : #private }
TeapotBeforeTest >> logRequest: aTeaRequest [
	log add: (aTeaRequest at: #user)
]

{ #category : #running }
TeapotBeforeTest >> setUp [
	log := OrderedCollection new.
	server := Teapot on
		before: [ :req | ((req at: 'user') = 'admin' and: [ (req at: 'pass') = '****' ]) ifFalse: [ req abort: 403 ] ];
		before: (Send message: #logRequest: to: self);
		before: 'any';
		GET: 'secure' -> 'protected';
		GET: 'secure2' -> 'protected';		
		start		
]

{ #category : #running }
TeapotBeforeTest >> tearDown [
	server stop
]

{ #category : #tests }
TeapotBeforeTest >> testAcceptsAuthenticatedUser [
	self assert: (TeaClient httpGetString: '/secure?user=admin&pass=****') equals: 'protected'.
]

{ #category : #tests }
TeapotBeforeTest >> testMultipleBeforeHandlers [
	TeaClient httpGet: '/secure?user=admin&pass=****'.
	TeaClient httpGet: '/secure2?user=admin&pass=****'.	
	TeaClient httpGet: '/secure?user=user01&pass=user01'. "403 before second filter"
		
	self assert: log asArray equals: #(admin admin).
]

{ #category : #tests }
TeapotBeforeTest >> testRejectUnauthenticatedUser [
	self assert: (TeaClient httpGet: '/secure?user=user01&pass=user01') code equals: 403.
]
