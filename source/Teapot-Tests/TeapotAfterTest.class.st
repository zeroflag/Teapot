Class {
	#name : #TeapotAfterTest,
	#superclass : #TestCase,
	#instVars : [
		'server'
	],
	#category : #'Teapot-Tests'
}

{ #category : #running }
TeapotAfterTest >> setUp [
	server := Teapot on
		after: '/after/<param>' -> [ :req :resp | resp headers at: 'header-key' put: (req at: #param) ];
		GET: '/after/*' -> 'after-return';		
		start		
]

{ #category : #running }
TeapotAfterTest >> tearDown [
	server stop
]

{ #category : #tests }
TeapotAfterTest >> testAfterFilterCanModifyResponse [
	| response |
	
	response := TeaClient httpGet: '/after/header-value'.
	self assert: response entity string equals: 'after-return'.
	self assert: (response headers at: 'header-key') equals: 'header-value'.
	
	response := TeaClient httpPost: '/after/notfound'.
	self assert: response code equals: 404.
	self assert: (response headers at: 'header-key') equals: 'notfound'.
]
