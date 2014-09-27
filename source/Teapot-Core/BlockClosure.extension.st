Extension { #name : #BlockClosure }

{ #category : #'*Teapot-Core' }
BlockClosure >> handleTeaException: anException request: aTeaRequest [
	^ self cull: anException cull: aTeaRequest
]

{ #category : #'*Teapot-Core' }
BlockClosure >> handleTeaRequest: aTeaRequest [
	^ self cull: aTeaRequest
]

{ #category : #'*Teapot-Core' }
BlockClosure >> handleTeaRequest: aTeaRequest response: aZnResponse [
	^ self cull: aTeaRequest cull: aZnResponse
]
