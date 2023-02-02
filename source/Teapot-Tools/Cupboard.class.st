"
A cupboard for teapots.
I'm the main User Interface to manage teapots instances.

You can open me with:
	
	self soleInstance open
"
Class {
	#name : #Cupboard,
	#superclass : #SpPresenter,
	#instVars : [
		'teapots',
		'toolbar'
	],
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
		action: [ self soleInstance open ].
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

{ #category : #initialization }
Cupboard >> buildBrowseToolBarItem [

	^ SpToolbarButtonPresenter new
		label: 'Browse';
		icon: self iconProvider teapotServerIcon;
		action: [ self selectedTeapot browse ];
		help: 'Browse the selected Teapot';
		yourself
]

{ #category : #initialization }
Cupboard >> buildContextMenu [

	^ SpMenuPresenter new
			addItem: [ :item | 
				item 
					name: 'Start';
					icon: self iconProvider teapotServerStartIcon;
					action: [ teapots selectedItem start. self refreshTeapots ] ];
			addItem: [ :item | 
				item 
					name: 'Stop';
					icon: self iconProvider teapotServerStopIcon;
					action: [ teapots selectedItem stop. self refreshTeapots ] ];
			addItem: [ :item | 
				item 
					name: 'Browse';
					icon: self iconProvider teapotServerIcon;
					action: [ teapots selectedItem browse. self refreshTeapots ] ];
		yourself
]

{ #category : #initialization }
Cupboard >> buildInspectToolBarItem [

	^ SpToolbarButtonPresenter new
		label: 'Inspect';
		icon: self iconProvider teapotInspectIcon;
		action: [ self selectedTeapot inspect ];
		help: 'Inspect the selected Teapot';
		yourself
]

{ #category : #initialization }
Cupboard >> buildNewStaticToolBarItem [
	
	^ SpToolbarButtonPresenter new
		label: 'New Teapot (serving static)';
		icon: self iconProvider teapotServerStaticIcon;
		action: [ self onNewStaticServer. self refreshTeapots ];
		help: 'Create a new Teapot serving static files';
		yourself
]

{ #category : #initialization }
Cupboard >> buildNewToolBarItem [
	
	^ SpToolbarButtonPresenter new
		label: 'New Teapot';
		icon: self iconProvider teapotServerIcon;
		action: [ self onNewServer. self refreshTeapots ];
		help: 'Create a new Teapot';
		yourself
		
]

{ #category : #initialization }
Cupboard >> buildStartToolBarItem [
	
	^ SpToolbarButtonPresenter new
		label: 'Start';
		icon: self iconProvider teapotServerStartIcon;
		action: [ self selectedTeapot start. self refreshTeapots ];
		help: 'Start the selected Teapot';
		yourself
]

{ #category : #initialization }
Cupboard >> buildStopToolBarItem [
	
	^ SpToolbarButtonPresenter new
		label: 'Stop';
		icon: self iconProvider teapotServerStopIcon;
		action: [ self selectedTeapot stop. self refreshTeapots ];
		help: 'Stop the selected Teapot';
		yourself
]

{ #category : #initialization }
Cupboard >> buildToolbar [
	
	^ self newToolbar 
		addItem: self buildNewToolBarItem;
		addItem: self buildNewStaticToolBarItem;
		addItem: self buildStartToolBarItem;
		addItem: self buildStopToolBarItem;
		addItem: self buildBrowseToolBarItem;
		addItem: self buildInspectToolBarItem;
		yourself
]

{ #category : #layout }
Cupboard >> defaultLayout [ 

	^ SpBoxLayout newTopToBottom 
		add: teapots;
		yourself
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

{ #category : #initialization }
Cupboard >> initializePresenters [
	
	teapots := self newList.
	teapots
		items: self teapots;
		displayIcon: [:each | self iconForTeapot: each ];
		display: [ :each | self nameForTeapot: each  ];
		whenActivatedDo: [ self selectedTeapot inspect ];
		bindKeyCombination: Character cr asShortcut toAction: [ self selectedTeapot inspect ];
		contextMenu: self buildContextMenu
]

{ #category : #initialization }
Cupboard >> initializeWindow: aWindowPresenter [

	super initializeWindow: aWindowPresenter.
	aWindowPresenter 
		title: 'Teapots';
		toolbar: (toolbar := self buildToolbar).
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

{ #category : #actions }
Cupboard >> refreshTeapots [

	teapots items: self teapots
]

{ #category : #accessing }
Cupboard >> selectedTeapot [

	^ teapots selectedItem
]

{ #category : #accessing }
Cupboard >> teapots [
	^ Teapot allInstances
]
