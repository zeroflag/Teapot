Extension { #name : #BlockClosure }

{ #category : #'*Teapot-Core' }
BlockClosure >> teaActionOnException: anException request: aTeaRequest [
	^ self cull: anException cull: aTeaRequest
]

{ #category : #'*Teapot-Core' }
BlockClosure >> teaActionOnRequest: aTeaRequest [
	^ self cull: aTeaRequest
]

{ #category : #'*Teapot-Core' }
BlockClosure >> teaActionOnRequest: aTeaRequest response: aZnResponse [
	^ self cull: aTeaRequest cull: aZnResponse
]
