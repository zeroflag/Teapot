Class {
	#name : #TeapotRouteSetTest,
	#superclass : #TestCase,
	#instVars : [
		'server'
	],
	#category : #'Teapot-Tests'
}

{ #category : #running }
TeapotRouteSetTest >> setUp [
	server := Teapot on
		before: { '/secure/*' . '/protected/*' } -> [ :req | req abort: TeaResponse unauthorized ];	
		GET: {'/a'. '/b'. '/c'} -> 'abc';
		POST: { '/x/<param>'. '/y/<param>' } -> [ :req | req at: #param ];
		after: { '/a'. '/b' } -> [ :req :resp | resp headers at: 'test' put: 'ab' ];
		start.
]

{ #category : #running }
TeapotRouteSetTest >> tearDown [
	server stop
]

{ #category : #tests }
TeapotRouteSetTest >> testMatchesAnyRouteInAfterFilter [
	| response |
	response := TeaClient httpGet: '/a'.
	self assert: (response headers at: 'test') equals: 'ab'.
	
	response := TeaClient httpGet: '/b'.
	self assert: (response headers at: 'test') equals: 'ab'.
		
	response := TeaClient httpGet: '/c'.
	self assert: (response headers at: 'test' ifAbsent: nil) equals: nil.

]

{ #category : #tests }
TeapotRouteSetTest >> testMatchesAnyRouteInBeforeFilter [
	| response |
	response := TeaClient httpGet: '/secure/123'.
	self assert: response code equals: 401.
	
	response := TeaClient httpGet: '/protected/123'.
	self assert: response code equals: 401.

]

{ #category : #tests }
TeapotRouteSetTest >> testMatchesAnyRouteInSet [
	self assert: (TeaClient httpGetString: '/a') equals: 'abc'.
	self assert: (TeaClient httpGetString: '/b') equals: 'abc'.
	self assert: (TeaClient httpGetString: '/c') equals: 'abc'.
]

{ #category : #tests }
TeapotRouteSetTest >> testMatchesAnyRouteInSetWithParams [
	self assert: (TeaClient httpPostString: '/x/value1') equals: 'value1'.
	self assert: (TeaClient httpPostString: '/y/value2') equals: 'value2'.	
]
