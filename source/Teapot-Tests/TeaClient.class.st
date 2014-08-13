"
Http client for testing.
"
Class {
	#name : #TeaClient,
	#superclass : #Object,
	#category : #'Teapot-Tests'
}

{ #category : #private }
TeaClient class >> httpGet: aString [
	^ ZnEasy get: 'http://localhost:1701/', aString

	
]

{ #category : #private }
TeaClient class >> httpGetString: aString [
	^ (self httpGet: aString) entity string

	
]

{ #category : #private }
TeaClient class >> httpPost: aString [
	^ ZnEasy post: 'http://localhost:1701/', aString data: (ZnEntity text: 'any')

	
]

{ #category : #private }
TeaClient class >> httpPostString: aString [
	^ (self httpPost: aString) entity string

	
]
