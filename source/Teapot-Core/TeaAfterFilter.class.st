Class {
	#name : #TeaAfterFilter,
	#superclass : #TeaFilter,
	#category : #'Teapot-Core'
}

{ #category : #'response handling' }
TeaAfterFilter >> handleRequest: aZnRequest response: aZnResponse [
	^ requestMatcher 
		matchRequest: aZnRequest 
		ifMatch: [ :aTeaRequest | action handleTeaRequest: aTeaRequest response: aZnResponse ]
		ifNoMatch: [ ZnResponse notFound: aZnRequest uri ]
]
