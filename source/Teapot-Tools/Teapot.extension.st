Extension { #name : #Teapot }

{ #category : #'*Teapot-Tools' }
Teapot >> browse [
	WebBrowser openOn: 'http://localhost:', self server port asString
]

{ #category : #'*Teapot-Tools' }
Teapot >> gtInspectorAfterFilterIn: composite [
	<gtInspectorPresentationOrder: 2>  
	
	^(composite table)
		title: ['After Filter' translated];		 
		display: [ compositeRouter afterFilters ]; 
		column: 'Request matcher' evaluated: [:filter| filter requestMatcher ];
		column: 'Action' evaluated: [:filter| filter action ];
		selectionAct: [:p | p entity removeAfterFilter: p selection. 
			p pane browser update ] entitled: 'Remove filter' translated;
		selectionAct: [:p | p entity removeAllAfterFilters. 
			p pane browser update ] entitled: 'Remove all' translated
]

{ #category : #'*Teapot-Tools' }
Teapot >> gtInspectorBeforeFilterIn: composite [
	<gtInspectorPresentationOrder: 1>  
	
	^(composite table)
		title: ['Before Filter' translated];		 
		display: [ compositeRouter beforeFilters ];
		column: 'Request matcher' evaluated: [:filter| filter requestMatcher ];
		column: 'Action' evaluated: [:filter| filter action ];
		selectionAct: [:p | p entity removeBeforeFilter: p selection. 
			p pane browser update ] entitled: 'Remove filter' translated;
		selectionAct: [:p | p entity removeAllBeforeFilters. 
			p pane browser update ] entitled: 'Remove all' translated
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
Teapot >> removeAfterFilter: aFilter [

	compositeRouter afterFilters remove: aFilter
]

{ #category : #'*Teapot-Tools' }
Teapot >> removeAllAfterFilters [ 
	compositeRouter afterFilters removeAll
]

{ #category : #'*Teapot-Tools' }
Teapot >> removeAllBeforeFilters [ 
	compositeRouter beforeFilters removeAll
]

{ #category : #'*Teapot-Tools' }
Teapot >> removeAllDynamicRoutes [ 
	dynamicRouter routes removeAll
]

{ #category : #'*Teapot-Tools' }
Teapot >> removeBeforeFilter: aFilter [

	compositeRouter beforeFilters remove: aFilter
]

{ #category : #'*Teapot-Tools' }
Teapot >> removeDynamicRoute: aRoute [

	dynamicRouter routes remove: aRoute
]
