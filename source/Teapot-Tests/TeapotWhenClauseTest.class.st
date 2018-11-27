Class {
	#name : #TeapotWhenClauseTest,
	#superclass : #TestCase,
	#instVars : [
		'server'
	],
	#category : #'Teapot-Tests'
}

{ #category : #running }
TeapotWhenClauseTest >> setUp [
	server := Teapot on
		any: '/when' -> 'get'; when: [:req | req method = 'GET'];
		any: '/when' -> 'post'; when: [:req | req method = 'POST'];
		any: '/when/<p>' -> 'param-dispatch'; when: [:req | (req at: #p) = 'pval'];
		any: '/when' -> 'unfiltered';
		any: '/never' -> 'never match'; when: [ false ];
		before: '/*' -> [:req | 
			req abort: (TeaResponse ok body: 'before') ]; 
			when: [:req | req relativeUrl path = 'beforeurl' ];
		after: '/*' -> [:req :resp | 
			resp statusLine: ZnStatusLine ok. 
			resp entity: (ZnStringEntity text: 'after') ]; 
			when: [:req | req relativeUrl path = 'afterurl' ];
		start
]

{ #category : #running }
TeapotWhenClauseTest >> tearDown [
	server stop
]

{ #category : #tests }
TeapotWhenClauseTest >> testDispatchesOnMethodInWhenFilter [
	self 
		assert: (TeaTestClient httpGetString: '/when') 
		equals: 'get'.	
	self 
		assert: (TeaTestClient httpPutString: '/when/pval') 
		equals: 'param-dispatch'.
	self 
		assert: (TeaTestClient httpPostString: '/when') 
		equals: 'post'.
	self 
		assert: (TeaTestClient httpDeleteString: '/when') 
		equals: 'unfiltered'.
		
	self assert: (TeaTestClient httpGet: '/never') isNotFound.
]

{ #category : #tests }
TeapotWhenClauseTest >> testWhenClauseWithBeforeAfterFilter [
	self 
		assert: (TeaTestClient httpGetString: '/beforeurl') 
		equals: 'before'.
	self 
		assert: (TeaTestClient httpGetString: '/afterurl') 
		equals: 'after'.
]
