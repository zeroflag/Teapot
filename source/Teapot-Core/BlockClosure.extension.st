Extension { #name : 'BlockClosure' }

{ #category : '*Teapot-Core' }
BlockClosure >> teaEvalActionOnException: anException request: aTeaRequest [
	^ self cull: anException cull: aTeaRequest
]

{ #category : '*Teapot-Core' }
BlockClosure >> teaEvalActionOnRequest: aTeaRequest [
	^ self cull: aTeaRequest
]

{ #category : '*Teapot-Core' }
BlockClosure >> teaEvalActionOnRequest: aTeaRequest response: aZnResponse [
	^ self cull: aTeaRequest cull: aZnResponse
]
