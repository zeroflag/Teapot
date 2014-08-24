Extension { #name : #Object }

{ #category : #'*Teapot-Core' }
Object >> asTeaResponse: aResponseTransformer request: aTeaRequest [
	^ aResponseTransformer cull: self cull: aTeaRequest
	
	

]

{ #category : #'*Teapot-Core' }
Object >> handleTeaException: anException request: aTeaRequest [
	^ self
]

{ #category : #'*Teapot-Core' }
Object >> handleTeaRequest: aTeaRequest [
	^ self
]
