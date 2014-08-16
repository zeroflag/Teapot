Extension { #name : #ZnResponse }

{ #category : #'*Teapot-Core' }
ZnResponse >> asTeaResponse: aResponseTransformer request: aTeaRequest [
	^ self
]

{ #category : #'*Teapot-Core' }
ZnResponse >> handleTeaException: anException request: aTeaRequest [
	^ self
]
