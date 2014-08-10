Extension { #name : #BlockClosure }

{ #category : #'*Teapot-Core' }
BlockClosure >> handleTeaException: anException request: aZnRequest [
	^ self cull: anException cull: aZnRequest
]

{ #category : #'*Teapot-Core' }
BlockClosure >> handleTeaRequest: request response: response [
	^ self cull: request cull: response
]
