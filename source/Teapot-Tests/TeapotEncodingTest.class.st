Class {
	#name : #TeapotEncodingTest,
	#superclass : #TestCase,
	#instVars : [
		'server'
	],
	#category : #'Teapot-Tests'
}

{ #category : #running }
TeapotEncodingTest >> setUp [
	server := Teapot on
		GET: 'enc' -> (TeaResponse ok 
								body: 'árvíztűrő tükörfúrógép'; 
								charSet: 'iso-8859-2');
		start
]

{ #category : #running }
TeapotEncodingTest >> tearDown [
	server stop
]

{ #category : #tests }
TeapotEncodingTest >> testUserSpecifiedEncoding [
	| response |
	response := TeaClient httpGet: '/enc'.
	self 
		assert: response entity string
		equals: 'árvíztűrő tükörfúrógép'.		
	self 
		assert: response contentType charSet
		equals: 'iso-8859-2'
]
