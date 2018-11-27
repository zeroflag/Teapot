Class {
	#name : #TeapotRegexpTest,
	#superclass : #TestCase,
	#instVars : [
		'server'
	],
	#category : #'Teapot-Tests'
}

{ #category : #running }
TeapotRegexpTest >> setUp [
	server := Teapot on
		GET: '/./' asRegex -> [ 'regexp' ];
		GET: '\w+(\d)/\d/xxx' asRegex -> [ :req | req at: 1 ];
		GET: '/(\d)/([abc]+)/\d/(.*)' asRegex -> [ :req | (req at: 1), (req at: 2), (req at: 3) ];		
		start
]

{ #category : #running }
TeapotRegexpTest >> tearDown [
	server stop
]

{ #category : #tests }
TeapotRegexpTest >> testCollectingSubexpressions [
	self assert: (TeaTestClient httpGetString: '/abc3/4/xxx') equals: '3'.	
	self assert: (TeaTestClient httpGetString: '/1/aabbcc/2/foobar') equals: '1aabbccfoobar'.
]

{ #category : #tests }
TeapotRegexpTest >> testIgnoresQueryParam [
	self assert: (TeaTestClient httpGetString: '/k/?param=value') equals: 'regexp'.	
]

{ #category : #tests }
TeapotRegexpTest >> testRegexpMatch [
	self assert: (TeaTestClient httpGetString: '/k/') equals: 'regexp'.	
]
