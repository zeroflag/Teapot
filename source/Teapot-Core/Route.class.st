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
	matches := (aZnRequest method = method) and: 
				[ urlPattern matchesUrl: aZnRequest url placeholders: placeholders ].
	matches
		ifTrue:
			[ | result  |			
			result := handler cull: aZnRequest cull: aZnResponse cull: placeholders.
			result := transformer value: result.
			aZnResponse entity: (ZnStringEntity text: result) ].
	^ matches
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
