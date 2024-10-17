Class {
	#name : 'TeapotRoutingTest',
	#superclass : 'TestCase',
	#instVars : [
		'server'
	],
	#category : 'Teapot-Tests',
	#package : 'Teapot-Tests'
}

{ #category : 'running' }
TeapotRoutingTest >> setUp [
	| teapot |
	teapot := Teapot configure: { #notFoundHandlerClass -> Tea405AwareNotFoundHandler }.
	server := teapot
		GET: '/' -> '1';
		GET: '/a' -> '2';
		POST: '/a' -> 'post';
		GET: '/a/*/b' -> [ '3' ];
		GET: '/*/c' -> [ '4' ];	
		GET: '/x/y/*' -> [ '5' ];
		GET: '/x/*/*/z/*' -> [ '6' ];
		GET: '/404' -> (ZnResponse notFound: '/custom');
		any: 'any' -> 'any';
		start.		
]

{ #category : 'running' }
TeapotRoutingTest >> tearDown [
	server stop
]

{ #category : 'tests' }
TeapotRoutingTest >> test404 [
 	self assert: (TeaTestClient httpGet: '/1/2/3/4') code equals: 404
]

{ #category : 'tests' }
TeapotRoutingTest >> test405 [
	| response |
	response := TeaTestClient httpDelete: '/a'.
	self assert: response code equals: 405.
	self 
		assert: (', ' split: (response headers at: 'Allow')) asSet
		equals: #(GET POST) asSet.
]

{ #category : 'tests' }
TeapotRoutingTest >> testAnyMatchesToAnyHttpMethod [
 	self assert: (TeaTestClient httpGetString: '/any') equals: 'any'.
 	self assert: (TeaTestClient httpPostString: '/any') equals: 'any'.
 	self assert: (TeaTestClient httpPutString: '/any') equals: 'any'.	
 	self assert: (TeaTestClient httpDeleteString: '/any') equals: 'any'.
]

{ #category : 'tests' }
TeapotRoutingTest >> testCustom404 [
 	self assert: (TeaTestClient httpGetString: '/404') equals: 'Not Found /custom', String crlf
]

{ #category : 'tests' }
TeapotRoutingTest >> testMultipleWildcard [
	self assert: (TeaTestClient httpGetString: '/x/foo/bar/z/baz') equals: '6'.
	self assert: (TeaTestClient httpGetString: '/x/foo/bar/z/baz/123') equals: '6'.
	
]

{ #category : 'tests' }
TeapotRoutingTest >> testNoWildcard [
	self assert: (TeaTestClient httpGetString: '') equals: '1'.
	self assert: (TeaTestClient httpGetString: '/a') equals: '2'.	
	
]

{ #category : 'tests' }
TeapotRoutingTest >> testWildcardEnd [
	self assert: (TeaTestClient httpGetString: '/x/y/foo') equals: '5'.	
	
]

{ #category : 'tests' }
TeapotRoutingTest >> testWildcardFirst [
	self assert: (TeaTestClient httpGetString: '/foo/c') equals: '4'
	
]

{ #category : 'tests' }
TeapotRoutingTest >> testWildcardInside [
	self assert: (TeaTestClient httpGetString: '/a/bar/b') equals: '3'
	
]
