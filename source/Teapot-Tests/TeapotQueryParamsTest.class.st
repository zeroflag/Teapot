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
		GET: '/query' do: [ :req :resp | req param: #foo ];
		GET: '/queryopt' do: [ :req :resp | req param: #foo ifAbsent: [ 'default' ] ];		
		start		
]

{ #category : #running }
TeapotQueryParamsTest >> tearDown [
	server stop
]

{ #category : #tests }
TeapotQueryParamsTest >> testDefaultQueryParam [
	self assert: (TestClient httpGetString: '/queryopt') equals: 'default'.	
]

{ #category : #tests }
TeapotQueryParamsTest >> testQueryParam [
	self assert: (TestClient httpGetString: '/query?foo=bar') equals: 'bar'.
	self assert: (TestClient httpGetString: '/queryopt?foo=baz') equals: 'baz'.
]
