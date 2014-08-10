"
I'm a ZnDelegate. I serve dynamically generated content.
"
Class {
	#name : #TeaDynamicRouter,
	#superclass : #TeaRouter,
	#instVars : [
		'routes'
	],
	#category : #'Teapot-Core'
}

{ #category : #'route dispatcher' }
TeaDynamicRouter >> addRoute: aRoute [
	^ routes add: aRoute.
	
]

{ #category : #'zn delegate' }
TeaDynamicRouter >> handleRequest: aZnRequest [
	routes do: [ :each | | aZnResponse |
		aZnResponse := each handleRequest: aZnRequest.
		aZnResponse isNotFound ifFalse: [ ^ aZnResponse ] ].
	
	^ ZnResponse notFound: aZnRequest uri
]

{ #category : #initialization }
TeaDynamicRouter >> initialize [
	super initialize.
	routes := OrderedCollection new.
]
