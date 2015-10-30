Extension { #name : #TeaRoute }

{ #category : #'*Teapot-Tools' }
TeaRoute >> methodMatcher [
	^ requestMatcher methodMatcher
]

{ #category : #'*Teapot-Tools' }
TeaRoute >> urlPattern [
	^ requestMatcher urlPattern
]
