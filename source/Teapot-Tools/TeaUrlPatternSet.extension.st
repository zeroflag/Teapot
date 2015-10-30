Extension { #name : #TeaUrlPatternSet }

{ #category : #'*Teapot-Tools' }
TeaUrlPatternSet >> asRequestBuilderPath [
	^ patterns 
		ifEmpty: [ '/' ]
		ifNotEmpty: [ patterns first asRequestBuilderPath ]
]
