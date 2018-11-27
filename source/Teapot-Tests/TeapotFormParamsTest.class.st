Class {
	#name : #TeapotFormParamsTest,
	#superclass : #TestCase,
	#instVars : [
		'server'
	],
	#category : #'Teapot-Tests'
}

{ #category : #running }
TeapotFormParamsTest >> setUp [
	server := Teapot on
		POST: '/form' -> [ :req | (req at: #foo), '-', (req at: #bar) ];
		exception: TeaNoSuchParam -> 'no such param';
		start.
]

{ #category : #running }
TeapotFormParamsTest >> tearDown [
	server stop
]

{ #category : #tests }
TeapotFormParamsTest >> testFormParams [
	| result |
	result := ZnEasy post: 'http://localhost:1701/form' data: (ZnApplicationFormUrlEncodedEntity new 
		at: 'foo' put: 'abc'; 
		at: 'bar' put: '123'; 
		yourself).

	self assert: result entity string equals: 'abc-123'.
]

{ #category : #tests }
TeapotFormParamsTest >> testFormParamsNotFound [
	| result |
	result := ZnEasy post: 'http://localhost:1701/form' data: (ZnApplicationFormUrlEncodedEntity new 
		at: 'invalid1' put: 'abc'; 
		at: 'invalid2' put: '123'; 
		yourself).

	self assert: result entity string equals: 'no such param'
]
