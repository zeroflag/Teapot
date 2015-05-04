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
		any: '/when' -> 'put'; when: [:req | req method = 'PUT'];		
		any: '/when' -> 'unfiltered';
		any: '/never' -> 'never match'; when: [ false ];
		start
]

{ #category : #running }
TeapotWhenClauseTest >> tearDown [
	server stop
]

{ #category : #tests }
TeapotWhenClauseTest >> testDispatchesOnMethodInWhenFilter [
	self 
		assert: (TeaClient httpGetString: '/when') 
		equals: 'get'.	
	self 
		assert: (TeaClient httpPutString: '/when') 
		equals: 'put'.
	self 
		assert: (TeaClient httpPostString: '/when') 
		equals: 'post'.
	self 
		assert: (TeaClient httpDeleteString: '/when') 
		equals: 'unfiltered'.
		
	self assert: (TeaClient httpGet: '/never') isNotFound.
]
