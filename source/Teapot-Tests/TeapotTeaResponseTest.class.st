Class {
	#name : #TeapotTeaResponseTest,
	#superclass : #TestCase,
	#instVars : [
		'server'
	],
	#category : #'Teapot-Tests'
}

{ #category : #running }
TeapotTeaResponseTest >> setUp [
	server := Teapot on
		GET: '/ok' -> (TeaResponse ok body: 'tested ok');
		GET: '/badrequest' -> [:req | TeaResponse badRequest body: 'Bad Request'];
		GET: '/created' -> [:req | TeaResponse created body: 'Created'; location: req url];
		GET: '/notallowed' -> [:req | TeaResponse methodNotAllowed ];
		GET: '/notfound' -> [:req | TeaResponse notFound ];
		GET: '/notmodified' -> [:req | TeaResponse notModified ];
		GET: '/redirect' -> (TeaResponse redirect location: '/target');
		GET: '/servererror' -> (TeaResponse serverError body: 'tested server error');
		GET: '/unauthorized' -> (TeaResponse unauthorized body: 'Unauthorized'; headerName: 'WWW-Authenticate' value: 'tested unauthorized');
		start
]

{ #category : #running }
TeapotTeaResponseTest >> tearDown [
	server stop.
]

{ #category : #tests }
TeapotTeaResponseTest >> testBadRequest [
	| response |
	response := TeaTestClient httpGet: '/badrequest'.
	self assert: response code equals: 400.
	self assert: response entity string equals: 'Bad Request'
]

{ #category : #tests }
TeapotTeaResponseTest >> testCreated [
	| response |
	response := TeaTestClient httpGet: '/created'.
	self assert: response code equals: 201.
	self assert: response entity string equals: 'Created'.
	self assert: (response headers at: 'Location') equals: '/created'.
]

{ #category : #tests }
TeapotTeaResponseTest >> testMethodNotAllowed [
	| response |
	response := TeaTestClient httpGet: '/notallowed'.
	self assert: response code equals: 405.
]

{ #category : #tests }
TeapotTeaResponseTest >> testNotFound [
	| response |
	response := TeaTestClient httpGet: '/notfound'.
	self assert: response code equals: 404.
]

{ #category : #tests }
TeapotTeaResponseTest >> testNotModified [
	| response |
	response := TeaTestClient httpGet: '/notmodified'.
	self assert: response code equals: 304.
]

{ #category : #tests }
TeapotTeaResponseTest >> testOk [
	| response |
	response := TeaTestClient httpGet: '/ok'.
	self assert: response code equals: 200.
	self assert: response entity string equals: 'tested ok'.
]

{ #category : #tests }
TeapotTeaResponseTest >> testRedirect [
	| response |
	response := TeaTestClient httpGetNoRedirect: '/redirect'.
	self assert: response code equals: 302.
	self assert: (response headers at: 'Location') equals: '/target'.
]

{ #category : #tests }
TeapotTeaResponseTest >> testServerError [
	| response |
	response := TeaTestClient httpGet: '/servererror'.
	self assert: response code equals: 500.
	self assert: response entity string equals: 'tested server error'
]

{ #category : #tests }
TeapotTeaResponseTest >> testUnauthorized [
	| response |
	response := TeaTestClient httpGet: '/unauthorized'.
	self assert: response code equals: 401.
	self assert: response entity string equals: 'Unauthorized'.
	self assert: (response headers at: 'WWW-Authenticate') equals: 'tested unauthorized'.
]
