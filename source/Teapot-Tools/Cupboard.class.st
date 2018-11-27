"
A cupboad for teapots
"
Class {
	#name : #Cupboard,
	#superclass : #Object,
	#classInstVars : [
		'soleInstance',
		'icons'
	],
	#category : #'Teapot-Tools-UI'
}

{ #category : #accessing }
Cupboard class >> iconProvider [

	^TeaIconProvider
]

{ #category : #'world menu' }
Cupboard class >> menuCommandOn: aBuilder [ 
	<worldMenu> 
	
	(aBuilder item: #'Teapot')	 
		help: 'Teatime'; 
		parent: #'Tools' translated;
		icon: self iconProvider teapotIcon;
		action: [ self soleInstance inspect ].
	 aBuilder withSeparatorAfter 
]

{ #category : #'instance creation' }
Cupboard class >> new [

	self error: 'Do not create new instances - access using #soleInstance'
]

{ #category : #private }
Cupboard class >> reset [
	<script>
	
	soleInstance := nil.
	 
]

{ #category : #accessing }
Cupboard class >> soleInstance [
	<script: 'self soleInstance inspect'>
	
	^ soleInstance ifNil: [ soleInstance := self basicNew initialize ]
]

{ #category : #inspecting }
Cupboard >> gtInspectorTeapotsIn: composite [
	<gtInspectorPresentationOrder: 0>  
	
	^(composite list)
		title: 'Teapots';
		icon: [:each | self iconForTeapot: each ];
		display: [ self teapots ]; 
		format: [:each | self nameForTeapot: each ];
		selectionAct:  [:each | each selection ifNotNil: [ each selection start ]. each update ] icon: self iconProvider teapotServerStartIcon entitled: 'Start';
		selectionAct: [:each | each selection ifNotNil: [ each selection stop ]. each update ] icon: self iconProvider teapotServerStopIcon entitled: 'Stop';
		selectionAct: [:each | each selection ifNotNil: [ each selection browse ]. each update ] icon: self iconProvider teapotServerIcon entitled: 'Browse';
		act: [:each | self onNewServer. each update ] icon: self iconProvider teapotServerIcon entitled: 'New Teapot';
		act: [:each | self onNewStaticServer. each update ] icon: self iconProvider teapotServerStaticIcon entitled: 'New Teapot (serving static)'
		
]

{ #category : #private }
Cupboard >> iconForTeapot: aTeapot [
	^aTeapot server isRunning 
			ifTrue: [ self iconProvider teapotServerStartIcon ] 
			ifFalse: [ self iconProvider teapotServerStopIcon ]
]

{ #category : #accessing }
Cupboard >> iconProvider [

	^self class iconProvider
]

{ #category : #private }
Cupboard >> nameForTeapot: aTeapot [
	^String streamContents: [:stream |
		stream nextPutAll: aTeapot server port asString.
		stream nextPutAll: ' - '.
		stream nextPutAll: (aTeapot server isRunning ifTrue: [ 'running' ] ifFalse: [ 'stopped' ]) ].

]

{ #category : #actions }
Cupboard >> onNewServer [
	|port pot |
	port := UIManager default request: 'New server' initialAnswer: '80'.
	port ifNil: [ ^self ].
	pot := Teapot configure: { 
		#port -> port asNumber
	}.
	pot start
	
		

]

{ #category : #actions }
Cupboard >> onNewStaticServer [
	|port directory pot |
	port := UIManager default request: 'New server' initialAnswer: '80'.
	port ifNil: [ ^self ].
	directory := UIManager default chooseDirectory: 'Serve directory'.
	directory ifNil: [ ^self ].
	pot := Teapot configure: { 
		#port -> port asNumber
	}.
	pot serveStatic: '/' from: directory.
	pot start
	
		

]

{ #category : #printing }
Cupboard >> printOn: aStream [

	aStream nextPutAll: 'Cupboard'
]

{ #category : #accessing }
Cupboard >> teapots [

	^Teapot allInstances
]
