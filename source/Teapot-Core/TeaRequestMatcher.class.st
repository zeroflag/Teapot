"
I can be matched against a ZnRequest. I check the http method and url of the request. 
"
Class {
	#name : #TeaRequestMatcher,
	#superclass : #Object,
	#instVars : [
		'urlPattern',
		'methodMatcher'
	],
	#category : #'Teapot-Core'
}

{ #category : #'instance creation' }
TeaRequestMatcher class >> method: aMethodMatcher url: anUrlPattern [
	^ self new setPattern: anUrlPattern method: aMethodMatcher

]

{ #category : #'request matcher' }
TeaRequestMatcher >> matchRequest: aZnRequest ifMatch: matchBlock ifNoMatch: noMatchBlock [
	| matches placeholders |
	placeholders := Dictionary new.
	matches := self matchesRequest: aZnRequest placeholders: placeholders.
	^ matches
		ifTrue: [ matchBlock value: (TeaRequest fromZnRequest: aZnRequest pathParams: placeholders) ]
		ifFalse: [ noMatchBlock value ]
]

{ #category : #private }
TeaRequestMatcher >> matchesRequest: aZnRequest placeholders: placeholders [
	^  (methodMatcher matchesHttpMethod: aZnRequest method)
		and: [ urlPattern matchesUrl: aZnRequest url placeholders: placeholders ]
]

{ #category : #printing }
TeaRequestMatcher >> printOn: aStream [
	methodMatcher printOn: aStream.
	aStream space.
	urlPattern printOn: aStream.
]

{ #category : #initialization }
TeaRequestMatcher >> setPattern: anUrlPattern method: aMethodMatcher [
	urlPattern := anUrlPattern.
	methodMatcher := aMethodMatcher.
	^ self
]
