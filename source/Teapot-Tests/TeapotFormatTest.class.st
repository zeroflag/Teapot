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
		GET: '/a' -> [ 4 ]; output: [:n | ZnStringEntity text: n printStringRoman ];
		GET: 'default' -> 'any';
		GET: '/plain' -> 'any'; output: #text;
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

{ #category : #tests }
TeapotFormatTest >> testDefaultContentTypeIsHtml [
	self 
		assert: (TeaClient httpGet: '/default') contentType 
		equals: ZnMimeType textHtml
]

{ #category : #tests }
TeapotFormatTest >> testSetsContentType [
	self 
		assert: (TeaClient httpGet: '/plain') contentType 
		equals: ZnMimeType textPlain
]
