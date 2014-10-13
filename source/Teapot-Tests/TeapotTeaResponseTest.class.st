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
		GET: '/ok' -> (TeaResponse ok: 'tested ok');
		GET: '/badrequest' -> [:req | TeaResponse badRequest: req];
		GET: '/created' -> [:req | TeaResponse created: req url];
		GET: '/notallowed' -> [:req | TeaResponse methodNotAllowed: req ];
		GET: '/notfound' -> [:req | TeaResponse notFound: req url ];
		GET: '/notmodified' -> [:req | TeaResponse notModified ];
		GET: '/redirect' -> (TeaResponse redirect: '/target');
		GET: '/servererror' -> (TeaResponse serverError: 'tested server error');
		GET: '/unauthorized' -> (TeaResponse unauthorized: 'tested unauthorized');
		start
]

{ #category : #running }
TeapotTeaResponseTest >> tearDown [
	server stop.
]

{ #category : #tests }
TeapotTeaResponseTest >> testBadRequest [
	| response |
	response := TeaClient httpGet: '/badrequest'.
	self assert: response code equals: 400.
	self assert: response entity string equals: 'Bad Request GET /badrequest', String crlf.
]

{ #category : #tests }
TeapotTeaResponseTest >> testCreated [
	| response |
	response := TeaClient httpGet: '/created'.
	self assert: response code equals: 201.
	self assert: response entity string equals: 'Created /created', String crlf.
	self assert: (response headers at: 'Location') equals: '/created'.
]

{ #category : #tests }
TeapotTeaResponseTest >> testMethodNotAllowed [
	| response |
	response := TeaClient httpGet: '/notallowed'.
	self assert: response code equals: 405.
	self assert: response entity string equals: 'Method Not Allowed GET /notallowed', String crlf.
]

{ #category : #tests }
TeapotTeaResponseTest >> testNotFound [
	| response |
	response := TeaClient httpGet: '/notfound'.
	self assert: response code equals: 404.
	self assert: response entity string equals: 'Not Found /notfound', String crlf.
]

{ #category : #tests }
TeapotTeaResponseTest >> testNotModified [
	| response |
	response := TeaClient httpGet: '/notmodified'.
	self assert: response code equals: 304.
]

{ #category : #tests }
TeapotTeaResponseTest >> testOk [
	| response |
	response := TeaClient httpGet: '/ok'.
	self assert: response code equals: 200.
	self assert: response entity string equals: 'tested ok'.
]

{ #category : #tests }
TeapotTeaResponseTest >> testRedirect [
	| response |
	response := TeaClient httpGetNoRedirect: '/redirect'.
	self assert: response code equals: 302.
	self assert: response entity string equals: 'Redirect /target', String crlf.
	self assert: (response headers at: 'Location') equals: '/target'.
]

{ #category : #tests }
TeapotTeaResponseTest >> testServerError [
	| response |
	response := TeaClient httpGet: '/servererror'.
	self assert: response code equals: 500.
	self assert: response entity string equals: 'tested server error', String crlf.
]

{ #category : #tests }
TeapotTeaResponseTest >> testUnauthorized [
	| response |
	response := TeaClient httpGet: '/unauthorized'.
	self assert: response code equals: 401.
	self assert: response entity string equals: 'Unauthorized', String crlf.
	self assert: (response headers at: 'WWW-Authenticate') equals: 'tested unauthorized'.
]
