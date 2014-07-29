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
		POST: '/form' do: [ :req :resp | (req form: #foo), '-', (req form: #bar) ];
		start.
]

{ #category : #running }
TeapotFormParamsTest >> tearDown [
	server stop
]

{ #category : #tests }
TeapotFormParamsTest >> testFormParams [
	| result |
	result := ZnEasy post: 'http://localhost:8080/form' data: (ZnApplicationFormUrlEncodedEntity new 
		at: 'foo' put: 'abc'; 
		at: 'bar' put: '123'; 
		yourself).

	self assert: result entity string equals: 'abc-123'.
]
