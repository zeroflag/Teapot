"
A route handles http requests if it matches to the route. I have four major parts.

- A handler that can be a block, a value or a message send.
- An url pattern that can be matched against actual urls.
- An http method that can be matched against the actual http method.
- A response transformer for creating ZnResponse from the object returned by the handler.
"
Class {
	#name : #TeaRoute,
	#superclass : #Object,
	#instVars : [
		'handler',
		'urlPattern',
		'responseTransformer',
		'methodMatcher'
	],
	#category : #'Teapot-Core'
}

{ #category : #'instance creation' }
TeaRoute class >> method: aMethodMatcher urlPattern: anUrlPattern handler: handlerBlock transformer: transformerBlock [
	^ self new 
		setPattern: anUrlPattern
		method: aMethodMatcher
		handler: handlerBlock
		transformer: transformerBlock
]

{ #category : #route }
TeaRoute >> handleRequest: aZnRequest [
	| matches placeholders |
	placeholders := Dictionary new.
	matches := self matchesRequest: aZnRequest placeholders: placeholders.
	^ matches
		ifTrue: 
			[ | request object |
			request := TeaRequest fromZnRequest: aZnRequest pathParams: placeholders.
			object := handler handleTeaRequest: request.
			responseTransformer cull: object cull: request ]
		ifFalse: 
			[ ZnResponse notFound: aZnRequest uri ]
]

{ #category : #private }
TeaRoute >> matchesRequest: aZnRequest placeholders: placeholders [
	^  (methodMatcher matchesHttpMethod: aZnRequest method)
		and: [ urlPattern matchesUrl: aZnRequest url placeholders: placeholders ]
]

{ #category : #route }
TeaRoute >> responseTransformer: aBlock [
	responseTransformer := aBlock
]

{ #category : #initialization }
TeaRoute >> setPattern: anUrlPattern method: aMethodMatcher handler: handlerBlock transformer: transformerBlock [
	urlPattern := anUrlPattern.
	methodMatcher := aMethodMatcher.
	handler := handlerBlock.
	responseTransformer := transformerBlock.
	^ self
]
