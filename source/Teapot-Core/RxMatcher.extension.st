Extension { #name : 'RxMatcher' }

{ #category : '*Teapot-Core' }
RxMatcher >> asTeaUrlPattern [
	^ TeaRxUrlPattern fromRxMatcher: self
]
