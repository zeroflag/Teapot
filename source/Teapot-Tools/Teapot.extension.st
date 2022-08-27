Extension { #name : #Teapot }

{ #category : #'*Teapot-Tools' }
Teapot >> browse [
	WebBrowser openOn: 'http://localhost:', self server port asString
]

{ #category : #'*Teapot-Tools' }
Teapot >> inspectAfterFilter: aBuilder [
	<inspectorPresentationOrder: 0 title: 'After Filters'>
	^ aBuilder newTable
		addColumn: (SpStringTableColumn new  
			title: 'Request matcher'; 
			evaluated: [ :filter | StObjectPrinter asTruncatedTextFrom: filter requestMatcher ];
			sortFunction: #printString ascending;
			yourself);
		items: compositeRouter afterFilters 
		yourself

]

{ #category : #'*Teapot-Tools' }
Teapot >> inspectBeforeFilter: aBuilder [
	<inspectorPresentationOrder: 0 title: 'Before Filters'>
	^ aBuilder newTable
		addColumn: (SpStringTableColumn new  
			title: 'Request matcher'; 
			evaluated: [ :filter | StObjectPrinter asTruncatedTextFrom: filter requestMatcher ];
			sortFunction: #printString ascending;
			yourself);
		items: compositeRouter beforeFilters
		yourself
]

{ #category : #'*Teapot-Tools' }
Teapot >> inspectDynamicRoutes: aBuilder [
	<inspectorPresentationOrder: 0 title: 'Dynamic routes'>
	^ aBuilder newTable
		addColumn: (SpStringTableColumn new  
			title: 'Route'; 
			evaluated: [ :each | StObjectPrinter asTruncatedTextFrom: each printString ];
			sortFunction: #printString ascending;
			yourself);
		items: dynamicRouter routes;
		yourself    
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
