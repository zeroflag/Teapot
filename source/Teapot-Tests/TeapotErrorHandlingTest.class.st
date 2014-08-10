Class {
	#name : #TeapotErrorHandlingTest,
	#superclass : #TestCase,
	#instVars : [
		'server'
	],
	#category : #'Teapot-Tests'
}

{ #category : #private }
TeapotErrorHandlingTest >> handleError: ex request: req [
	self assert: (ex isKindOf: Exception).
	self assert: (req isKindOf: ZnRequest).
	^ ZnResponse ok: (ZnStringEntity text: 'outofbounds/domainerror handled')
]

{ #category : #running }
TeapotErrorHandlingTest >> setUp [
	server := Teapot on
		GET: '/zerodiv' -> [ 1 / 0 ];
		GET: '/sub' -> [ #() at: 123 ];			
		GET: '/domain' -> [ -2 sqrt ];
		GET: '/nonbool' -> [ 1 ifTrue: [  ] ];
		exception: ZeroDivide -> [ :ex :req | ZnResponse ok: (ZnStringEntity text: 'zerodiv handled') ];
		exception: SubscriptOutOfBounds, DomainError -> (Send message: #handleError:request: to: self);
		exception: NonBooleanReceiver -> (ZnResponse ok: (ZnStringEntity text: 'nonbool handled'));
		start		
]

{ #category : #running }
TeapotErrorHandlingTest >> tearDown [
	server stop
]

{ #category : #tests }
TeapotErrorHandlingTest >> testHandlesExceptionSet [
	self assert: (TeaClient httpGetString: '/sub') equals: 'outofbounds/domainerror handled'.	
	self assert: (TeaClient httpGetString: '/domain') equals: 'outofbounds/domainerror handled'.		
]

{ #category : #tests }
TeapotErrorHandlingTest >> testHandlesOneException [
	self assert: (TeaClient httpGetString: '/zerodiv') equals: 'zerodiv handled'.	
]

{ #category : #tests }
TeapotErrorHandlingTest >> testValueAsExceptionHandler [
	self assert: (TeaClient httpGetString: '/nonbool') equals: 'nonbool handled'.	
]
