"
A route handles http requests if the url pattern matches to the request url. The handle is an arbitrary block that will be evaluated in case of an url match.
"
Class {
	#name : #Route,
	#superclass : #Object,
	#instVars : [
		'handler',
		'urlPattern'
	],
	#category : #'Teapot-Core-Teapot-Core'
}

{ #category : #'instance creation' }
Route class >> method: aSymbol urlPattern: patternString handler: aBlock [
	^ self new 
		setPattern: (UrlPattern parseString: patternString)
		handler: aBlock
]

{ #category : #route }
Route >> handleRequest: aZnRequest response: aZnResponse [
	| matches result placeholders |
	placeholders := Dictionary new.
	matches := urlPattern matchesUrl: aZnRequest url placeholders: placeholders.
	matches
		ifTrue: [ 
			result := handler cull: aZnRequest cull: aZnResponse cull: placeholders.
			aZnResponse entity: (ZnStringEntity text: result) ].
	^ matches
]

{ #category : #initialization }
Route >> setPattern: anUrlPattern handler: aBlock [
	urlPattern := anUrlPattern.
	handler := aBlock.
	^ self
]
