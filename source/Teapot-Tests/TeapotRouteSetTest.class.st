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
	response := TeaTestClient httpGet: '/a'.
	self assert: (response headers at: 'test') equals: 'ab'.
	
	response := TeaTestClient httpGet: '/b'.
	self assert: (response headers at: 'test') equals: 'ab'.
		
	response := TeaTestClient httpGet: '/c'.
	self assert: (response headers at: 'test' ifAbsent: nil) equals: nil.

]

{ #category : #tests }
TeapotRouteSetTest >> testMatchesAnyRouteInBeforeFilter [
	| response |
	response := TeaTestClient httpGet: '/secure/123'.
	self assert: response code equals: 401.
	
	response := TeaTestClient httpGet: '/protected/123'.
	self assert: response code equals: 401.

]

{ #category : #tests }
TeapotRouteSetTest >> testMatchesAnyRouteInSet [
	self assert: (TeaTestClient httpGetString: '/a') equals: 'abc'.
	self assert: (TeaTestClient httpGetString: '/b') equals: 'abc'.
	self assert: (TeaTestClient httpGetString: '/c') equals: 'abc'.
]

{ #category : #tests }
TeapotRouteSetTest >> testMatchesAnyRouteInSetWithParams [
	self assert: (TeaTestClient httpPostString: '/x/value1') equals: 'value1'.
	self assert: (TeaTestClient httpPostString: '/y/value2') equals: 'value2'.	
]
