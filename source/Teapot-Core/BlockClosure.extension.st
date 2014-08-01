Extension { #name : #BlockClosure }

{ #category : #'*Teapot-Core' }
BlockClosure >> handleTeaRequest: request response: response [
	^ self cull: request cull: response
]
