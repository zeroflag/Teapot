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
		GET: '/' -> '1';
		GET: '/a' -> '2';
		GET: '/a/*/b' -> [ '3' ];
		GET: '/*/c' -> [ '4' ];	
		GET: '/x/y/*' -> [ '5' ];
		GET: '/x/*/*/z/*' -> [ '6' ];
		start.		
]

{ #category : #running }
TeapotRoutingTest >> tearDown [
	server stop
]

{ #category : #tests }
TeapotRoutingTest >> test404 [
 	self assert: (TeaClient httpGet: '1/2/3/4') code equals: 404
]

{ #category : #tests }
TeapotRoutingTest >> testMultipleWildcard [
	self assert: (TeaClient httpGetString: 'x/foo/bar/z/baz') equals: '6'.
	self assert: (TeaClient httpGetString: 'x/foo/bar/z/baz/123') equals: '6'.
	
]

{ #category : #tests }
TeapotRoutingTest >> testNoWildcard [
	self assert: (TeaClient httpGetString: '') equals: '1'.
	self assert: (TeaClient httpGetString: '/a') equals: '2'.	
	
]

{ #category : #tests }
TeapotRoutingTest >> testWildcardEnd [
	self assert: (TeaClient httpGetString: '/x/y/foo') equals: '5'.	
	
]

{ #category : #tests }
TeapotRoutingTest >> testWildcardFirst [
	self assert: (TeaClient httpGetString: 'foo/c') equals: '4'
	
]

{ #category : #tests }
TeapotRoutingTest >> testWildcardInside [
	self assert: (TeaClient httpGetString: 'a/bar/b') equals: '3'
	
]
