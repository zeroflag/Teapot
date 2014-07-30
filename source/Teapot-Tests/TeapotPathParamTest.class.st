Class {
	#name : #TeapotPathParamTest,
	#superclass : #TestCase,
	#instVars : [
		'server'
	],
	#category : #'Teapot-Tests'
}

{ #category : #running }
TeapotPathParamTest >> setUp [
	server := Teapot on
		GET: '/user/<id>' do: [ :req :resp | '1-', (req at: #id) ];
		GET: '/user/<id>/create' do: [ :req :resp | '2-', (req at: #id) ];
		GET: '/<id>/<user>' do: [ :req :resp | '3-', (req at: #id) ];				
		POST: '/user/<id>/create' do: [ :req :resp | '4-', (req at: #id) ];
		start.		
]

{ #category : #running }
TeapotPathParamTest >> tearDown [
	server stop
]

{ #category : #tests }
TeapotPathParamTest >> testPlaceholderAtLast [
	self assert: (TeaClient httpGetString: 'user/12') equals: '1-12'
	
]

{ #category : #tests }
TeapotPathParamTest >> testPlaceholderFirst [
	self assert: (TeaClient httpGetString: '54/user') equals: '3-54'.

	
]

{ #category : #tests }
TeapotPathParamTest >> testPlaceholderInside [
	self assert: (TeaClient httpGetString: 'user/34/create') equals: '2-34'.	
	
]

{ #category : #tests }
TeapotPathParamTest >> testPlaceholderPost [
	self assert: (TeaClient httpPostString: '/user/789/create') equals: '4-789'.	

	
]
