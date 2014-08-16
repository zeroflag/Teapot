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
		'urlPattern',
		'responseTransformer',
		'methodMatcher',
		'action'
	],
	#category : #'Teapot-Core'
}

{ #category : #'instance creation' }
TeaRoute class >> method: aMethodMatcher urlPattern: anUrlPattern action: aTeaAction transformer: aResponseTransformer [
	^ self new 
		setPattern: anUrlPattern
		method: aMethodMatcher
		action: aTeaAction
		transformer: aResponseTransformer
]

{ #category : #route }
TeaRoute >> handleRequest: aZnRequest [
	| matches placeholders |
	placeholders := Dictionary new.
	matches := self matchesRequest: aZnRequest placeholders: placeholders.
	^ matches
		ifTrue: 
			[ | request result |
			request := TeaRequest fromZnRequest: aZnRequest pathParams: placeholders.
			result := action handleTeaRequest: request.
			result asTeaResponse: responseTransformer request: request ]
		ifFalse: 
			[ ZnResponse notFound: aZnRequest uri ]
]

{ #category : #private }
TeaRoute >> matchesRequest: aZnRequest placeholders: placeholders [
	^  (methodMatcher matchesHttpMethod: aZnRequest method)
		and: [ urlPattern matchesUrl: aZnRequest url placeholders: placeholders ]
]

{ #category : #printing }
TeaRoute >> printOn: aStream [
	methodMatcher printOn: aStream.
	aStream space.
	urlPattern printOn: aStream.
	aStream nextPutAll: ' -> '.
	action printOn: aStream.
]

{ #category : #route }
TeaRoute >> responseTransformer: aBlock [
	responseTransformer := aBlock
]

{ #category : #initialization }
TeaRoute >> setPattern: anUrlPattern method: aMethodMatcher action: aTeaAction transformer: aResponseTransformer [
	urlPattern := anUrlPattern.
	methodMatcher := aMethodMatcher.
	action := aTeaAction.
	responseTransformer := aResponseTransformer.
	^ self
]
