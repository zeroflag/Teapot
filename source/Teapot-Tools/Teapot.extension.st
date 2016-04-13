Extension { #name : #Teapot }

{ #category : #'*Teapot-Tools' }
Teapot >> browse [
	|url port|
	self server isRunning ifFalse: [ ^self inform: 'Server does not run' ].
	url := 'http://localhost'.
	port := self server port.
	port = 80 ifFalse: [ url := url,':', port asString ].
	WebBrowser openOn: url
]

{ #category : #'*Teapot-Tools' }
Teapot >> gtInspectorDynamicRoutesIn: composite [
	<gtInspectorPresentationOrder: 0>  
	
	^(composite list)
		title: 'Dynamic routes';		 
		display: [ dynamicRouter routes ]; 
		format: [:each | each printString ] 
]
