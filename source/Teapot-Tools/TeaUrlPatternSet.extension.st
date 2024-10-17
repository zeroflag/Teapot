Extension { #name : 'TeaUrlPatternSet' }

{ #category : '*Teapot-Tools' }
TeaUrlPatternSet >> asRequestBuilderPath [
	^ patterns 
		ifEmpty: [ '/' ]
		ifNotEmpty: [ patterns first asTeaspoonPath ]
]

{ #category : '*Teapot-Tools' }
TeaUrlPatternSet >> asTeaspoonPath [
	^ patterns 
		ifEmpty: [ '/' ]
		ifNotEmpty: [ patterns first asTeaspoonPath ]
]
