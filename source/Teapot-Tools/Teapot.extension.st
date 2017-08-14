Extension { #name : #Teapot }

{ #category : #'*Teapot-Tools' }
Teapot >> browse [
	WebBrowser openOn: 'http://localhost:', self server port asString
]

{ #category : #'*Teapot-Tools' }
Teapot >> gtInspectorDynamicRoutesIn: composite [
	<gtInspectorPresentationOrder: 0>  
	
	^(composite list)
		title: ['Dynamic routes' translated];		 
		display: [ dynamicRouter routes ]; 
		format: [:each | each printString ];
		selectionAct: [:p | p entity removeDynamicRoute: p selection. 
			p pane browser update ] entitled: 'Remove route' translated;
		selectionAct: [:p | p entity removeAllDynamicRoutes. 
			p pane browser update ] entitled: 'Remove all' translated
]

{ #category : #'*Teapot-Tools' }
Teapot >> removeAllDynamicRoutes [ 
	dynamicRouter routes removeAll
]

{ #category : #'*Teapot-Tools' }
Teapot >> removeDynamicRoute: aRoute [

	dynamicRouter routes remove: aRoute
]
