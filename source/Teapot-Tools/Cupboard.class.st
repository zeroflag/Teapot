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

{ #category : #private }
Cupboard >> iconForTeapot: aTeapot [
	^aTeapot server isRunning 
			ifTrue: [ self iconProvider teapotServerStartIcon ] 
			ifFalse: [ self iconProvider teapotServerStopIcon ]
]

{ #category : #accessing }
Cupboard >> iconProvider [
	^ self class iconProvider
]

{ #category : #accessing }
Cupboard >> inspectTeapot: aBuilder [
	<inspectorPresentationOrder: 0 title: 'Teapots'>      
	| list |
	list := aBuilder newList.
	list
		items: self teapots;
		displayIcon: [:each | self iconForTeapot: each ];
		display: [ :each | self nameForTeapot: each  ];
		contextMenu: (SpMenuPresenter new
			addItem: [ :item | 
				item 
					name: 'Start';
					icon: self iconProvider teapotServerStartIcon;
					action: [ list selectedItem start. list refresh ] ];
			addItem: [ :item | 
				item 
					name: 'Stop';
					icon: self iconProvider teapotServerStopIcon;
					action: [ list selectedItem stop. list refresh ] ];
			addItem: [ :item | 
				item 
					name: 'Browse';
					icon: self iconProvider teapotServerIcon;
					action: [ list selectedItem browse. list refresh ] ];
"			TODO: this doesn't work properly:
				1. After adding a new Teapot the list is not refreshed
				2. It shouldn't be a context menu. If there is no existing Teapot in the list, the context menu cannot be shown.	
			addItem: [ :item | 
				item 
					name: 'New Teapot';
					icon: self iconProvider teapotServerIcon;
					action: [ self onNewServer. list refresh ] ];
			addItem: [ :item | 
				item 
					name: 'New Teapot (serving static)';
					icon: self iconProvider teapotServerStaticIcon;
					action: [ self onNewStaticServer. list refresh ] ];	"							
			yourself).
	^ list
]

{ #category : #private }
Cupboard >> nameForTeapot: aTeapot [
	^ String streamContents: [:stream |
		stream nextPutAll: aTeapot server port asString.
		stream nextPutAll: ' - '.
		stream nextPutAll: (aTeapot server isRunning ifTrue: [ 'running' ] ifFalse: [ 'stopped' ]) ].

]

{ #category : #actions }
Cupboard >> onNewServer [
	| port pot |
	port := UIManager default request: 'New server' initialAnswer: '80'.
	port ifNil: [ ^ self ].
	pot := Teapot configure: { 
		#port -> port asNumber
	}.
	pot start.
	
		

]

{ #category : #actions }
Cupboard >> onNewStaticServer [
	| port directory pot |
	port := UIManager default request: 'New server' initialAnswer: '80'.
	port ifNil: [ ^self ].
	directory := UIManager default chooseDirectory: 'Serve directory'.
	directory ifNil: [ ^ self ].
	pot := Teapot configure: { 
		#port -> port asNumber
	}.
	pot serveStatic: '/' from: directory.
	pot start.
	
		

]

{ #category : #printing }
Cupboard >> printOn: aStream [
	aStream nextPutAll: 'Cupboard'
]

{ #category : #accessing }
Cupboard >> teapots [
	^ Teapot allInstances
]
