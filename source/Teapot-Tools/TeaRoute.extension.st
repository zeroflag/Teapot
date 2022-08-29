Extension { #name : #TeaRoute }

{ #category : #'*Teapot-Tools' }
TeaRoute >> inspectRoute: aBuilder [
	<inspectorPresentationOrder: 0 title: 'Teaspoon'>
	^ Teaspoon new
		method: requestMatcher methodMatcher asString
		url: requestMatcher urlPattern asTeaspoonPath
		port: port.
]
