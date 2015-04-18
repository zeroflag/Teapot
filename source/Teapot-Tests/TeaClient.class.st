"
Http client for testing.
"
Class {
	#name : #TeaClient,
	#superclass : #Object,
	#category : #'Teapot-Tests'
}

{ #category : #private }
TeaClient class >> httpDeleteString: aString [
	^ ZnClient new
		url: 'http://localhost:1701/', aString;
		delete

	
]

{ #category : #private }
TeaClient class >> httpGet: aString [
	^ ZnEasy get: 'http://localhost:1701/', aString

	
]

{ #category : #private }
TeaClient class >> httpGetNoRedirect: aString [
	^ ZnClient new
		followRedirects: false;
		get: 'http://localhost:1701/', aString;		
		response

	
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

{ #category : #private }
TeaClient class >> httpPut: aString [
	^ ZnEasy put: 'http://localhost:1701/', aString data: (ZnEntity text: 'any')

	
]

{ #category : #private }
TeaClient class >> httpPutString: aString [
	^ (self httpPut: aString) entity string

	
]
