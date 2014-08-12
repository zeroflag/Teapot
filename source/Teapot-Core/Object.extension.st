Extension { #name : #Object }

{ #category : #'*Teapot-Core' }
Object >> asTeaResponse [
	^ ZnResponse ok: (ZnStringEntity html: self asString)
	
	

]

{ #category : #'*Teapot-Core' }
Object >> handleTeaException: anException request: aTeaRequest [
	^ self
]

{ #category : #'*Teapot-Core' }
Object >> handleTeaRequest: aTeaRequest [
	^ self
]
