Class {
	#name : 'TeapotQueryParamsTest',
	#superclass : 'TestCase',
	#instVars : [
		'server'
	],
	#category : 'Teapot-Tests',
	#package : 'Teapot-Tests'
}

{ #category : 'running' }
TeapotQueryParamsTest >> setUp [
	server := Teapot on
		GET: '/query' -> [ :req | req at: #foo ];
		GET: '/queryopt' -> [ :req | req at: #foo ifAbsent: [ 'default' ] ];		
		start
]

{ #category : 'running' }
TeapotQueryParamsTest >> tearDown [
	server stop
]

{ #category : 'tests' }
TeapotQueryParamsTest >> testDefaultQueryParam [
	self assert: (TeaTestClient httpGetString: '/queryopt') equals: 'default'.	
]

{ #category : 'tests' }
TeapotQueryParamsTest >> testQueryParam [
	self assert: (TeaTestClient httpGetString: '/query?foo=bar') equals: 'bar'.
	self assert: (TeaTestClient httpGetString: '/queryopt?foo=baz') equals: 'baz'.
]
