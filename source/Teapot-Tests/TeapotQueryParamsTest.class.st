Class {
	#name : #TeapotQueryParamsTest,
	#superclass : #TestCase,
	#instVars : [
		'server'
	],
	#category : #'Teapot-Tests'
}

{ #category : #running }
TeapotQueryParamsTest >> setUp [
	server := Teapot on
		GET: '/query' -> [ :req :resp | req at: #foo ];
		GET: '/queryopt' -> [ :req :resp | req at: #foo ifAbsent: [ 'default' ] ];		
		start
]

{ #category : #running }
TeapotQueryParamsTest >> tearDown [
	server stop
]

{ #category : #tests }
TeapotQueryParamsTest >> testDefaultQueryParam [
	self assert: (TeaClient httpGetString: '/queryopt') equals: 'default'.	
]

{ #category : #tests }
TeapotQueryParamsTest >> testQueryParam [
	self assert: (TeaClient httpGetString: '/query?foo=bar') equals: 'bar'.
	self assert: (TeaClient httpGetString: '/queryopt?foo=baz') equals: 'baz'.
]
