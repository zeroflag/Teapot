Class {
	#name : #TeapotResponseTest,
	#superclass : #TestCase,
	#instVars : [
		'server'
	],
	#category : #'Teapot-Tests'
}

{ #category : #running }
TeapotResponseTest >> setUp [
	server := Teapot on
		GET: '/test400' -> [ 
			TeaResponse badRequest
				body: 'malformed input';
				headers: { 'my-header' -> 'my-value' } ];
		start
]

{ #category : #running }
TeapotResponseTest >> tearDown [
	server stop
]

{ #category : #tests }
TeapotResponseTest >> testReturnsCustomCodeBodyAndHeaders [
	| response |
	response := TeaClient httpGet: '/test400'.
	self assert: response entity string equals: 'malformed input'.
	self assert: response code equals: 400.
	self assert: (response headers at: 'my-header') equals: 'my-value'.
]
