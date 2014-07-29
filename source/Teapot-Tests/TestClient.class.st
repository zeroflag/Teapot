"
Http client for testing.
"
Class {
	#name : #TestClient,
	#superclass : #Object,
	#category : #'Teapot-Tests'
}

{ #category : #private }
TestClient class >> httpGet: aString [
	^ ZnEasy get: 'http://localhost:8080/', aString

	
]

{ #category : #private }
TestClient class >> httpGetString: aString [
	^ (self httpGet: aString) entity string

	
]

{ #category : #private }
TestClient class >> httpPost: aString [
	^ ZnEasy post: 'http://localhost:8080/', aString data: (ZnEntity text: 'any')

	
]

{ #category : #private }
TestClient class >> httpPostString: aString [
	^ (self httpPost: aString) entity string

	
]
