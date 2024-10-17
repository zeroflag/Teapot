Extension { #name : 'TeaGlobUrlPattern' }

{ #category : '*Teapot-Tools' }
TeaGlobUrlPattern >> asTeaspoonPath [
	^ String streamContents: [ :aStream |
			segments 
				do: [ :each | each printOn: aStream ]
				separatedBy: [ aStream nextPut: $/ ] ]
]
