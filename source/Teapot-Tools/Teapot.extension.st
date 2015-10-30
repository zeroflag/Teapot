Extension { #name : #Teapot }

{ #category : #'*Teapot-Tools' }
Teapot >> gtInspectorDynamicRoutesIn: composite [
	<gtInspectorPresentationOrder: 0>
		
	^(composite list)
		title: 'Dynamic routes';		 
		display: [ dynamicRouter routes ]; 
		format: [:each | each printString ];
		selectionAct:  
			[:each | 
				each selection ifNotNil: 
					[ Teaspoon new
						openWithSpec;
						route: each selection port: server port ] ] 
			entitled: 'Build request'
		
]
