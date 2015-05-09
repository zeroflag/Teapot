"
A TeaResponse represents an HTTP response returned by a Route. The ZnResponse is generated from the TeaResponse by the given response transformer.
"
Class {
	#name : #TeaResponse,
	#superclass : #Object,
	#instVars : [
		'code',
		'body',
		'headers',
		'charSet'
	],
	#category : #'Teapot-Core'
}

{ #category : #'instance creation' }
TeaResponse class >> badRequest [
	^ self code: ZnStatusLine badRequest code
]

{ #category : #'instance creation' }
TeaResponse class >> code: anInteger [
	^ self new code: anInteger
]

{ #category : #'instance creation' }
TeaResponse class >> created [
	^ self code: ZnStatusLine created code
]

{ #category : #'instance creation' }
TeaResponse class >> methodNotAllowed [
	^ self code: ZnStatusLine methodNotAllowed code 

]

{ #category : #'instance creation' }
TeaResponse class >> notFound [
	^ self code: ZnStatusLine notFound code 
]

{ #category : #'instance creation' }
TeaResponse class >> notModified [
	^ self code: ZnStatusLine notModified code

]

{ #category : #'instance creation' }
TeaResponse class >> ok [
	^ self code: ZnStatusLine ok code
]

{ #category : #'instance creation' }
TeaResponse class >> redirect [
	^ self code: ZnStatusLine redirect code
]

{ #category : #'instance creation' }
TeaResponse class >> serverError [
	^ self code: ZnStatusLine internalServerError code
]

{ #category : #'instance creation' }
TeaResponse class >> unauthorized [
	^ self code: ZnStatusLine unauthorized code
]

{ #category : #accessing }
TeaResponse >> body [
	^ body
]

{ #category : #accessing }
TeaResponse >> body: anObject [
	body := anObject.
	^ self
]

{ #category : #accessing }
TeaResponse >> charSet [
	^ charSet
]

{ #category : #accessing }
TeaResponse >> charSet: aString [
	charSet := aString
]

{ #category : #accessing }
TeaResponse >> code [
	^ code
]

{ #category : #accessing }
TeaResponse >> code: anInteger [
	code := anInteger.
	^ self
]

{ #category : #accessing }
TeaResponse >> headerName: nameString value: valueString [
	headers at: nameString put: valueString.
	^ self
]

{ #category : #accessing }
TeaResponse >> headers [
	^ headers
]

{ #category : #accessing }
TeaResponse >> headers: aDictionary [
	headers := aDictionary asDictionary.
	^ self
]

{ #category : #initialization }
TeaResponse >> initialize [
	super initialize.
	headers := Dictionary new.
	body := String crlf.
	code := ZnStatusLine ok code.
	charSet := 'utf-8'.
]

{ #category : #accessing }
TeaResponse >> location: url [
	self headerName: 'Location' value: url asString.
	^ self
]

{ #category : #'response transforming' }
TeaResponse >> teaTransform: aResponseTransformer request: aTeaRequest [
	^ aResponseTransformer cull: self cull: aTeaRequest
]
