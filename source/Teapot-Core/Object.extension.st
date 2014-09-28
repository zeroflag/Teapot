Extension { #name : #Object }

{ #category : #'*Teapot-Core' }
Object >> teaEvalActionOnException: anException request: aTeaRequest [
	^ self
]

{ #category : #'*Teapot-Core' }
Object >> teaEvalActionOnRequest: aTeaRequest [
	^ self
]

{ #category : #'*Teapot-Core' }
Object >> teaTransform: aResponseTransformer request: aTeaRequest [
	^ aResponseTransformer cull: (TeaResponse code: 200 body: self	) cull: aTeaRequest
]
