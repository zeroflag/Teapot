Extension { #name : #BlockClosure }

{ #category : #'*Teapot-Core' }
BlockClosure >> teaActionOnRequest: aTeaRequest response: aZnResponse [
	^ self cull: aTeaRequest cull: aZnResponse
]

{ #category : #'*Teapot-Core' }
BlockClosure >> teaEvalActionOnException: anException request: aTeaRequest [
	^ self cull: anException cull: aTeaRequest
]

{ #category : #'*Teapot-Core' }
BlockClosure >> teaEvalActionOnRequest: aTeaRequest [
	^ self cull: aTeaRequest
]
