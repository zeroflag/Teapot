Class {
	#name : #TeaBeforeFilter,
	#superclass : #TeaFilter,
	#category : #'Teapot-Core'
}

{ #category : #'request handling' }
TeaBeforeFilter >> handleRequest: aZnRequest [
	^ requestMatcher 
		matchRequest: aZnRequest 
		ifMatch: [ :aTeaRequest | action handleTeaRequest: aTeaRequest ]
		ifNoMatch: [ ZnResponse notFound: aZnRequest uri ]
]
