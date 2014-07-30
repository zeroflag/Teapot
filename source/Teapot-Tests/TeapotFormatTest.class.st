Class {
	#name : #TeapotFormatTest,
	#superclass : #TestCase,
	#instVars : [
		'server'
	],
	#category : #'Teapot-Tests'
}

{ #category : #running }
TeapotFormatTest >> setUp [
	server := Teapot on
		GET: '/a' do: [ 4 ]; to: [:n | n printStringRoman ];
		start		
]

{ #category : #running }
TeapotFormatTest >> tearDown [
	server stop
]

{ #category : #tests }
TeapotFormatTest >> testConverting [
	self assert: (TeaClient httpGetString: '/a') equals: 'IV'.	
]
