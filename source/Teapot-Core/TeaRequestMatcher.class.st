"
I can be matched against a ZnRequest. I check the http method and url of the request. 
"
Class {
	#name : 'TeaRequestMatcher',
	#superclass : 'Object',
	#instVars : [
		'urlPattern',
		'methodMatcher',
		'whenClause'
	],
	#category : 'Teapot-Core',
	#package : 'Teapot-Core'
}

{ #category : 'instance creation' }
TeaRequestMatcher class >> method: aMethodMatcher url: anUrlPattern [
	^ self new setPattern: anUrlPattern method: aMethodMatcher

]

{ #category : 'request matcher' }
TeaRequestMatcher >> matchRequest: aZnRequest ifMatch: matchBlock ifNoMatch: noMatchBlock [
	| placeholders matches |
	(methodMatcher matchesHttpMethod: aZnRequest method) ifFalse: [ ^ noMatchBlock value ].
	placeholders := Dictionary new.
	matches := (urlPattern matchesUrl: aZnRequest url placeholders: placeholders) 
		and: [ whenClause cull: (TeaRequest fromZnRequest: aZnRequest pathParams: placeholders) ].
	^ matches 
		ifTrue: [ matchBlock value: (TeaRequest fromZnRequest: aZnRequest pathParams: placeholders) ]
		ifFalse: noMatchBlock
]

{ #category : 'request matcher' }
TeaRequestMatcher >> matchesUrl: aZnUrl [
	^ urlPattern matchesUrl: aZnUrl placeholders: Dictionary new
]

{ #category : 'accessing' }
TeaRequestMatcher >> methodMatcher [
	^ methodMatcher
]

{ #category : 'printing' }
TeaRequestMatcher >> printOn: aStream [
	methodMatcher printOn: aStream.
	aStream space.
	urlPattern printOn: aStream.
]

{ #category : 'initialization' }
TeaRequestMatcher >> setPattern: anUrlPattern method: aMethodMatcher [
	urlPattern := anUrlPattern.
	methodMatcher := aMethodMatcher.
	whenClause := [ :anyRequest | true ].
	^ self
]

{ #category : 'accessing' }
TeaRequestMatcher >> whenClause: aBlockClosure [ 
	whenClause := aBlockClosure
]
