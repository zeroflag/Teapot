Extension { #name : #TeaRoute }

{ #category : #'*Teapot-Tools' }
TeaRoute >> gtInspectorRouteIn: composite [
	<gtInspectorPresentationOrder: 80>  
	composite morph
		title: 'Teaspoon';
		display: 
			[ (Teaspoon new 
					method: requestMatcher methodMatcher asString
					url: requestMatcher urlPattern asTeaspoonPath
					port: port) 
				buildWithSpec ]
]
