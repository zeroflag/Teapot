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
		before: '/secure/*' -> [ :req | ((req at: #user) = 'admin' and: [ (req at: #pass) = '****' ]) ifFalse: [ req abort: 403 ] ];
		before: '*' -> (Send message: #logRequest: to: self);
		before: '*' -> 'any';
		GET: '/secure' -> 'protected';
		GET: '/secure/1/2/3' -> 'protected';
		POST: '/public' -> 'public';
		start		
]

{ #category : #running }
TeapotBeforeTest >> tearDown [
	server stop
]

{ #category : #tests }
TeapotBeforeTest >> testAuthentication [
	self assert: (TeaClient httpGetString: '/secure?user=admin&pass=****') equals: 'protected'.
	self assert: (TeaClient httpGetString: '/secure/1/2/3?user=admin&pass=****') equals: 'protected'.
		
	self assert: (TeaClient httpGet: '/secure?user=user01&pass=****') code equals: 403.
	self assert: (TeaClient httpGet: '/secure/1/2/3?user=user02&pass=****') code equals: 403.	
	
	self assert: (TeaClient httpPostString: '/public?user=any') equals: 'public'.
]

{ #category : #tests }
TeapotBeforeTest >> testMultipleBeforeHandlers [
	TeaClient httpGet: '/secure?user=admin&pass=****'.
	TeaClient httpGet: '/secure/1/2/3?user=admin&pass=****'.	
	TeaClient httpGet: '/secure?user=user01&pass=****'. "403 before second filter"
	TeaClient httpPost: '/public?user=pubuser'.		
		
	self assert: log asArray equals: #(admin admin pubuser).
]
