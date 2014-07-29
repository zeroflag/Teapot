"
A route handles http requests if the url pattern matches to the request url. The handle is an arbitrary block that will be evaluated in case of an url match.
"
Class {
	#name : #Route,
	#superclass : #Object,
	#instVars : [
		'handler',
		'urlPattern',
		'transformer',
		'method'
	],
	#category : #'Teapot-Core'
}

{ #category : #'instance creation' }
Route class >> method: aSymbol urlPattern: patternString handler: handlerBlock transformer: transformerBlock [
	^ self new 
		setPattern: (UrlPattern parseString: patternString)
		method: aSymbol
		handler: handlerBlock
		transformer: transformerBlock
]

{ #category : #route }
Route >> handleRequest: aZnRequest response: aZnResponse [
	| matches placeholders |
	placeholders := Dictionary new.
	matches := self matchesRequest: aZnRequest placeholders: placeholders.
	matches
		ifTrue: [ 
			| result request |
			request := Request fromZnRequest: aZnRequest pathParams: placeholders.
			result := handler cull: request cull: aZnResponse.
			result := transformer cull: result cull: request cull: aZnResponse.			
			aZnResponse entity: (ZnStringEntity with: result type: aZnResponse headers contentType) ].
	^ matches
]

{ #category : #private }
Route >> matchesRequest: aZnRequest placeholders: placeholders [
	^ aZnRequest method = method 
		and: [ urlPattern matchesUrl: aZnRequest url placeholders: placeholders ]
]

{ #category : #initialization }
Route >> setPattern: anUrlPattern method: aSymbol handler: handlerBlock transformer: transformerBlock [
	urlPattern := anUrlPattern.
	method := aSymbol.
	handler := handlerBlock.
	transformer := transformerBlock.
	^ self
]

{ #category : #route }
Route >> transformer: aBlock [
	transformer := aBlock
]
