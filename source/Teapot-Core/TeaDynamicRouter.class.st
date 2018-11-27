"
I'm a ZnDelegate. I serve dynamically generated contents. The request is handled by the first route object, that returns other than 404 as response.
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
	^ routes add: aRoute
]

{ #category : #'zn delegate' }
TeaDynamicRouter >> handleRequest: aZnRequest ifUnhandled: aBlock [
	routes do: [ :each | | response |
		response := each handleRequest: aZnRequest ifUnhandled: nil.
		response ifNotNil: [ ^ response ] ].
	^ aBlock value
]

{ #category : #initialization }
TeaDynamicRouter >> initialize [
	super initialize.
	routes := OrderedCollection new.
]

{ #category : #accessing }
TeaDynamicRouter >> routes [

	^routes
]
