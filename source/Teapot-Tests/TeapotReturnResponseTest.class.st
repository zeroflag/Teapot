Class {
	#name : 'TeapotReturnResponseTest',
	#superclass : 'TestCase',
	#instVars : [
		'server'
	],
	#category : 'Teapot-Tests',
	#package : 'Teapot-Tests'
}

{ #category : 'running' }
TeapotReturnResponseTest >> setUp [
	| stream |
	stream := ZnStreamingEntity
		readFrom: 'direct stream' readStream
		usingType: ZnMimeType textHtml
		andLength: 'direct stream' size.
		
	server := Teapot on
		GET: '/resp1' -> [ :req | ZnResponse ok: (ZnStringEntity text: 'direct response') ];
		GET: '/resp2' -> (ZnResponse ok: stream);
		GET: '/redirect' -> (ZnResponse redirect: '/redirect_location');
		GET: '/redirect_location' -> 'redirected here';
		start
]

{ #category : 'running' }
TeapotReturnResponseTest >> tearDown [
	server stop
]

{ #category : 'tests' }
TeapotReturnResponseTest >> testDirectStreamResponse [
	self assert: (TeaTestClient httpGetString: '/resp2') equals: 'direct stream'.	
]

{ #category : 'tests' }
TeapotReturnResponseTest >> testDirectStringResponse [
	self assert: (TeaTestClient httpGetString: '/resp1') equals: 'direct response'.	
]

{ #category : 'tests' }
TeapotReturnResponseTest >> testRedirect [
	self assert: (TeaTestClient httpGetString: '/redirect') equals: 'redirected here'.
	
]
