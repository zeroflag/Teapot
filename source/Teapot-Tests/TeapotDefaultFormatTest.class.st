Class {
	#name : #TeapotDefaultFormatTest,
	#superclass : #TestCase,
	#instVars : [
		'server'
	],
	#category : #'Teapot-Tests'
}

{ #category : #running }
TeapotDefaultFormatTest >> setUp [
	server := (Teapot configure: { #defaultOutput -> #text })
		GET: 'default' -> 'any';
		GET: 'html' -> 'any'; output: #html;
		start		
]

{ #category : #running }
TeapotDefaultFormatTest >> tearDown [
	server stop
]

{ #category : #tests }
TeapotDefaultFormatTest >> testDefault [
	self 
		assert: (TeaTestClient httpGet: '/default') contentType 
		equals: ZnMimeType textPlain
]

{ #category : #tests }
TeapotDefaultFormatTest >> testOverride [
	self 
		assert: (TeaTestClient httpGet: '/html') contentType 
		equals: ZnMimeType textHtml
]
