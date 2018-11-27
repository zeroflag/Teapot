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
TeapotBeforeTest >> forbidden [
	^ ZnResponse new
		statusLine: ZnStatusLine forbidden;
		headers: ZnHeaders defaultResponseHeaders;
		yourself
]

{ #category : #private }
TeapotBeforeTest >> logRequest: aTeaRequest [
	log add: (aTeaRequest at: #user)
]

{ #category : #running }
TeapotBeforeTest >> setUp [
	log := OrderedCollection new.
	server := Teapot on
		before: '/secure/*' -> [ :req | ((req at: #user) = 'admin' and: [ (req at: #pass) = '****' ]) 
			ifFalse: [ req abort: self forbidden ] ];
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
	self assert: (TeaTestClient httpGetString: '/secure?user=admin&pass=****') equals: 'protected'.
	self assert: (TeaTestClient httpGetString: '/secure/1/2/3?user=admin&pass=****') equals: 'protected'.
		
	self assert: (TeaTestClient httpGet: '/secure?user=user01&pass=****') code equals: 403.
	self assert: (TeaTestClient httpGet: '/secure/1/2/3?user=user02&pass=****') code equals: 403.	
	
	self assert: (TeaTestClient httpPostString: '/public?user=any') equals: 'public'.
]

{ #category : #tests }
TeapotBeforeTest >> testMultipleBeforeHandlers [
	TeaTestClient httpGet: '/secure?user=admin&pass=****'.
	TeaTestClient httpGet: '/secure/1/2/3?user=admin&pass=****'.	
	TeaTestClient httpGet: '/secure?user=user01&pass=****'. "403 before second filter"
	TeaTestClient httpPost: '/public?user=pubuser'.		
		
	self assert: log asArray equals: #(admin admin pubuser).
]
