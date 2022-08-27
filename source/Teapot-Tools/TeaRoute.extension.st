Extension { #name : #TeaRoute }

{ #category : #'*Teapot-Tools' }
TeaRoute >> inspectRoute: aBuilder [
	<inspectorPresentationOrder: 0 title: 'Teaspoon'>
	| teaspoon |
	teaspoon := Teaspoon new
		            method: requestMatcher methodMatcher asString
		            url: requestMatcher urlPattern asTeaspoonPath
		            port: port.
	"	teaspoon onHttpResultDo: [ :result | presentation selection: result ]."
	^ teaspoon
]
