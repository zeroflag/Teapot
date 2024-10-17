"
Http client for testing.
"
Class {
	#name : 'TeaTestClient',
	#superclass : 'Object',
	#category : 'Teapot-Tests',
	#package : 'Teapot-Tests'
}

{ #category : 'private' }
TeaTestClient class >> httpDelete: aString [
	^ ZnEasy delete: 'http://localhost:1701', aString

	
]

{ #category : 'private' }
TeaTestClient class >> httpDeleteString: aString [
	^ ZnClient new
		url: 'http://localhost:1701', aString;
		delete

	
]

{ #category : 'private' }
TeaTestClient class >> httpGet: aString [
	^ ZnEasy get: 'http://localhost:1701', aString

	
]

{ #category : 'private' }
TeaTestClient class >> httpGetNoRedirect: aString [
	^ ZnClient new
		followRedirects: false;
		get: 'http://localhost:1701', aString;		
		response

	
]

{ #category : 'private' }
TeaTestClient class >> httpGetString: aString [
	^ (self httpGet: aString) entity string

	
]

{ #category : 'private' }
TeaTestClient class >> httpPost: aString [
	^ ZnEasy post: 'http://localhost:1701', aString data: (ZnEntity text: 'any')

	
]

{ #category : 'private' }
TeaTestClient class >> httpPostString: aString [
	^ (self httpPost: aString) entity string

	
]

{ #category : 'private' }
TeaTestClient class >> httpPut: aString [
	^ ZnEasy put: 'http://localhost:1701', aString data: (ZnEntity text: 'any')

	
]

{ #category : 'private' }
TeaTestClient class >> httpPutString: aString [
	^ (self httpPut: aString) entity string

	
]
