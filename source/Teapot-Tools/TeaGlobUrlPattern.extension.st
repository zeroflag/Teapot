Extension { #name : #TeaGlobUrlPattern }

{ #category : #'*Teapot-Tools' }
TeaGlobUrlPattern >> asRequestBuilderPath [
	^ String streamContents: [ :aStream |
			segments 
				do: [ :each | each printOn: aStream ]
				separatedBy: [ aStream nextPut: $/ ] ]
]
