"
I'm a smarter not found handler that returns 405 instead of 404 when the url part of some routes matched but the HTTP method didn't.
"
Class {
	#name : #Tea405AwareNotFoundHandler,
	#superclass : #TeaNotFoundHandler,
	#category : #'Teapot-Core'
}

{ #category : #private }
Tea405AwareNotFoundHandler >> populateAllowedHeaderOf: response withAllowedRoutes: allowedRoutes [
	allowedRoutes do: [ :route | 
		response headers 
			at: 'Allow' 
			put: route methodMatcher asString
			ifPresentMerge: [ :old :new | old, ', ', new ] ].
	^ response
]

{ #category : #'not found handler' }
Tea405AwareNotFoundHandler >> requestNotFound: aZnRequest [
	| allowedRoutes |
	allowedRoutes := routes
		select: [ :each | each canHandleUrl: aZnRequest url ].
	^ allowedRoutes
		ifEmpty: [ ZnResponse notFound: aZnRequest url ]
		ifNotEmpty: [
			self
				populateAllowedHeaderOf: (ZnResponse methodNotAllowed: aZnRequest)
				withAllowedRoutes: allowedRoutes ]
]
