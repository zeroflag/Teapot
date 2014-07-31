"
A route handles http requests if the url pattern matches to the request url. The handle is an arbitrary block that will be evaluated in case of an url match.
"
Class {
	#name : #TeaRoute,
	#superclass : #Object,
	#instVars : [
		'handler',
		'urlPattern',
		'method',
		'responseTransformer'
	],
	#category : #'Teapot-Core'
}

{ #category : #'instance creation' }
TeaRoute class >> method: aSymbol urlPattern: patternString handler: handlerBlock transformer: transformerBlock [
	^ self new 
		setPattern: (TeaUrlPattern parseString: patternString)
		method: aSymbol
		handler: handlerBlock
		transformer: transformerBlock
]

{ #category : #route }
TeaRoute >> handleRequest: aZnRequest response: aZnResponse [
	| matches placeholders |
	placeholders := Dictionary new.
	matches := self matchesRequest: aZnRequest placeholders: placeholders.
	matches
		ifTrue: [ 
			| result request response |
			request := TeaRequest fromZnRequest: aZnRequest pathParams: placeholders.
			response := TeaResponse fromZnResponse: aZnResponse.
			result := handler cull: request cull: response.
			result := responseTransformer cull: result cull: request cull: response.			
			aZnResponse entity: (ZnStringEntity with: result type: response contentType) ].
	^ matches
]

{ #category : #private }
TeaRoute >> matchesRequest: aZnRequest placeholders: placeholders [
	^ aZnRequest method = method 
		and: [ urlPattern matchesUrl: aZnRequest url placeholders: placeholders ]
]

{ #category : #route }
TeaRoute >> responseTransformer: aBlock [
	responseTransformer := aBlock
]

{ #category : #initialization }
TeaRoute >> setPattern: anUrlPattern method: aSymbol handler: handlerBlock transformer: transformerBlock [
	urlPattern := anUrlPattern.
	method := aSymbol.
	handler := handlerBlock.
	responseTransformer := transformerBlock.
	^ self
]
