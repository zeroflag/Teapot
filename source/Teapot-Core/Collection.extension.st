Extension { #name : #Collection }

{ #category : #'*Teapot-Core' }
Collection >> asTeaUrlPattern [
	^ TeaUrlPatternSet fromCollection: self
]
