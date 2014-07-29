Class {
	#name : #TeapotRoutingTest,
	#superclass : #TestCase,
	#instVars : [
		'server'
	],
	#category : #'Teapot-Tests'
}

{ #category : #running }
TeapotRoutingTest >> setUp [
	server := Teapot on
		GET: '/' do: [ '1' ];
		GET: '/a' do: [ '2' ];		
		GET: '/a/*/b' do: [ '3' ];
		GET: '/*/c' do: [ '4' ];	
		GET: '/x/y/*' do: [ '5' ];
		GET: '/x/*/*/z/*' do: [ '6' ];
		start.		
]

{ #category : #running }
TeapotRoutingTest >> tearDown [
	server stop
]

{ #category : #tests }
TeapotRoutingTest >> test404 [
 	self assert: (TestClient httpGet: '1/2/3/4') code equals: 404
]

{ #category : #tests }
TeapotRoutingTest >> testMultipleWildcard [
	self assert: (TestClient httpGetString: 'x/foo/bar/z/baz') equals: '6'.
	self assert: (TestClient httpGetString: 'x/foo/bar/z/baz/123') equals: '6'.
	
]

{ #category : #tests }
TeapotRoutingTest >> testNoWildcard [
	self assert: (TestClient httpGetString: '') equals: '1'.
	self assert: (TestClient httpGetString: '/a') equals: '2'.	
	
]

{ #category : #tests }
TeapotRoutingTest >> testWildcardEnd [
	self assert: (TestClient httpGetString: '/x/y/foo') equals: '5'.	
	
]

{ #category : #tests }
TeapotRoutingTest >> testWildcardFirst [
	self assert: (TestClient httpGetString: 'foo/c') equals: '4'
	
]

{ #category : #tests }
TeapotRoutingTest >> testWildcardInside [
	self assert: (TestClient httpGetString: 'a/bar/b') equals: '3'
	
]
