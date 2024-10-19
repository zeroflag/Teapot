Extension { #name : 'Object' }

{ #category : '*Teapot-Core' }
Object >> teaEvalActionOnException: anException request: aTeaRequest [
	^ self
]

{ #category : '*Teapot-Core' }
Object >> teaEvalActionOnRequest: aTeaRequest [
	^ self
]

{ #category : '*Teapot-Core' }
Object >> teaTransform: aResponseTransformer request: aTeaRequest [
	^ aResponseTransformer cull: (TeaResponse ok body: self) cull: aTeaRequest
]
