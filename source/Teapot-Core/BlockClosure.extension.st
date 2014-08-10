Extension { #name : #BlockClosure }

{ #category : #'*Teapot-Core' }
BlockClosure >> handleTeaException: anException request: aZnRequest [
	^ self cull: anException cull: aZnRequest
]

{ #category : #'*Teapot-Core' }
BlockClosure >> handleTeaRequest: aTeaRequest [
	^ self cull: aTeaRequest
]
