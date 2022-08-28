Extension { #name : #Teapot }

{ #category : #'*Teapot-Tools' }
Teapot >> browse [
	WebBrowser openOn: 'http://localhost:', self server port asString
]

{ #category : #'*Teapot-Tools' }
Teapot >> inspectAfterFilter: aBuilder [
	<inspectorPresentationOrder: 0 title: 'After Filters'>
	| list |
	^ (list := SpListPresenter new)
		items: compositeRouter afterFilters;
		display: [ :filter | filter requestMatcher ];
		contextMenu: (SpMenuPresenter new 
			addItem: [ :item | 
				item
					name: 'Remove filter';
					action: [ 
						self removeAfterFilter: list selectedItem.
						list refresh ] ]);		
		yourself

]

{ #category : #'*Teapot-Tools' }
Teapot >> inspectBeforeFilter: aBuilder [
	<inspectorPresentationOrder: 0 title: 'Before Filters'>
	| list |
	^ (list := SpListPresenter new)
		items: compositeRouter beforeFilters;
		display: [ :filter | filter requestMatcher ];
		contextMenu: (SpMenuPresenter new 
			addItem: [ :item | 
				item
					name: 'Remove filter';
					action: [ 
						self removeBeforeFilter: list selectedItem.
						list refresh ] ];
			yourself);  
		yourself
]

{ #category : #'*Teapot-Tools' }
Teapot >> inspectDynamicRoutes: aBuilder [
	<inspectorPresentationOrder: 0 title: 'Dynamic routes'>      
	| list |
	^ (list := SpListPresenter new)
		items: dynamicRouter routes;
		display: [ :route | route printString ];
		contextMenu: (SpMenuPresenter new 
			addItem: [ :item | 
				item
					name: 'Remove route';
					action: [ 
						self removeDynamicRoute: list selectedItem.
						list refresh ] ];
			yourself);   		
		yourself.
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
