Class {
	#name : #TeapotTest,
	#superclass : #TestCase,
	#instVars : [
		'server'
	],
	#category : #'Teapot-Tests'
}

{ #category : #private }
TeapotTest >> httpGet: aString [
	^ ZnEasy get: 'http://localhost:8080/', aString

	
]

{ #category : #private }
TeapotTest >> httpGetString: aString [
	^ (self httpGet: aString) entity string

	
]

{ #category : #private }
TeapotTest >> httpPost: aString [
	^ ZnEasy post: 'http://localhost:8080/', aString data: (ZnEntity text: 'any')

	
]

{ #category : #private }
TeapotTest >> httpPostString: aString [
	^ (self httpPost: aString) entity string

	
]

{ #category : #running }
TeapotTest >> setUp [
	server := Teapot on
		GET: '/' do: [ 'root' ];
		GET: '/a/*/b' do: [ '1' ];
		GET: '/*/c' do: [ '2' ];	
		GET: '/x/y/*' do: [ '3' ];			
		GET: '/z' do: [ 4 ]; to: #printStringRoman;
		GET: '/user/<id>' do: [ :req :resp :params | 'user', (params at: #id) ];
		GET: '/user/<id>/create' do: [ :req :resp :params | 'user create', (params at: #id) ];		
		POST: '/user/<id>/create' do: [ 'post' ];
		start.
		

	
]

{ #category : #running }
TeapotTest >> tearDown [
	server stop
]

{ #category : #tests }
TeapotTest >> testPlaceholder [
	self assert: (self httpGetString: 'user/12') equals: 'user12'.
	self assert: (self httpGetString: 'user/34/create') equals: 'user create34'.	

	
]

{ #category : #tests }
TeapotTest >> testRoutingGet [
	self assert: (self httpGetString: '') equals: 'root'.
	self assert: (self httpGetString: 'a/x/b') equals: '1'.
	self assert: (self httpGetString: 'x/c') equals: '2'.
	self assert: (self httpGetString: '/x/y/a') equals: '3'.
	self assert: (self httpGetString: 'z') equals: 'IV'.	
 	self assert: (self httpGet: '1/2/3/4') code equals: 404.
	
	
]

{ #category : #tests }
TeapotTest >> testRoutingPost [
	self assert: (self httpPostString: '/user/12/create') equals: 'post'.
	
]
