"
A before filter is evaluated before (matching) each request. This filter has access to the request object. For example, a before filter can be used to validate session attributes for authentication.
"
Class {
	#name : #TeaBeforeFilter,
	#superclass : #TeaFilter,
	#category : #'Teapot-Core'
}

{ #category : #'request handling' }
TeaBeforeFilter >> handleRequest: aZnRequest [
	^ requestMatcher 
		matchRequest: aZnRequest 
		ifMatch: [ :aTeaRequest | action teaEvalActionOnRequest: aTeaRequest ]
		ifNoMatch: [ ZnResponse notFound: aZnRequest uri ]
]
