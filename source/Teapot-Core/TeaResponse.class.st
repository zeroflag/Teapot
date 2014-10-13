"
A TeaResponse represents an HTTP response returned by a Route. The ZnResponse is generated from the TeaResponse by the given response transformer.
"
Class {
	#name : #TeaResponse,
	#superclass : #Object,
	#instVars : [
		'code',
		'body',
		'headers'
	],
	#category : #'Teapot-Core'
}

{ #category : #'instance creation' }
TeaResponse class >> badRequest: request [
	^ self 
		code: ZnStatusLine badRequest code 
		body: 'Bad Request ' , request method , ' ' , request uri pathQueryFragmentPrintString, String crlf 
]

{ #category : #'instance creation' }
TeaResponse class >> code: anInteger body: anObject [
	^ self code: anInteger body: anObject headers: Dictionary new
]

{ #category : #'instance creation' }
TeaResponse class >> code: anInteger body: anObject headers: aDictionary [
	^ self new setCode: anInteger body: anObject header: aDictionary asDictionary
]

{ #category : #'instance creation' }
TeaResponse class >> created: url [
	| location |
	location := url asString.
	^ self 
		code: ZnStatusLine created code 
		body: 'Created ', location, String crlf
		headers: { 'Location' -> location}
]

{ #category : #'instance creation' }
TeaResponse class >> methodNotAllowed: request [
	^ self 
		code: ZnStatusLine methodNotAllowed code 
		body: 'Method Not Allowed ', request method, ' ' , request uri pathQueryFragmentPrintString, String crlf 
]

{ #category : #'instance creation' }
TeaResponse class >> notFound: url [
	^ self 
		code: ZnStatusLine notFound code 
		body: 'Not Found ', url asZnUrl pathQueryFragmentPrintString, String crlf
]

{ #category : #'instance creation' }
TeaResponse class >> notModified [
	^ self code: ZnStatusLine notModified code body: ''

]

{ #category : #'instance creation' }
TeaResponse class >> ok: anObject [
	^ self code: ZnStatusLine ok code body: anObject
]

{ #category : #'instance creation' }
TeaResponse class >> redirect: url [
	| location |
	location := url asString.
	^ self 
		code: ZnStatusLine redirect code 
		body: 'Redirect ', location, String crlf
		headers: { 'Location' -> location}
]

{ #category : #'instance creation' }
TeaResponse class >> serverError: aString [
	^ self 
		code: ZnStatusLine internalServerError code 
		body: aString, String crlf 
]

{ #category : #'instance creation' }
TeaResponse class >> unauthorized [
	^ self unauthorized: 'Basic realm=ZincHTTPComponents'
]

{ #category : #'instance creation' }
TeaResponse class >> unauthorized: authString [
	^ self 
		code: ZnStatusLine unauthorized code 
		body: 'Unauthorized', String crlf
		headers: { 'WWW-Authenticate' -> authString}
]

{ #category : #accessing }
TeaResponse >> body [
	^ body
]

{ #category : #accessing }
TeaResponse >> code [
	^ code
]

{ #category : #accessing }
TeaResponse >> headers [
	^ headers
]

{ #category : #initialization }
TeaResponse >> setCode: anInteger body: anObject header: aDictionary [
	code := anInteger.
	body := anObject.
	headers := aDictionary.
	^ self
]

{ #category : #'response transforming' }
TeaResponse >> teaTransform: aResponseTransformer request: aTeaRequest [
	^ aResponseTransformer cull: self cull: aTeaRequest
]
