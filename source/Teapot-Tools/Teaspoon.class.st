"
I provide a graphical interface for quickly testing and excesising routes. Right click on a route in the inspector to open me.
"
Class {
	#name : #Teaspoon,
	#superclass : #ComposableModel,
	#instVars : [
		'urlInput',
		'contentTypeDropList',
		'contentTypeLabel',
		'methodDropList',
		'execButton',
		'requestBody'
	],
	#category : #'Teapot-Tools-UI'
}

{ #category : #specs }
Teaspoon class >> defaultSpec [
	^ SpecLayout composed
		newColumn: [ :col | 									
			col 
				newRow: [ :row | 
					row 
						add: #methodDropList width: 90;
						add: #urlInput ]
				height: self inputTextHeight.
			col
				add: #requestBody;
				add: #contentTypeLabel height: self inputTextHeight;
				add: #contentTypeDropList height: self inputTextHeight.
			col 
				newRow: 
					[ :row | row add: #execButton ] 
				height: self buttonHeight				
		]
]

{ #category : #specs }
Teaspoon class >> title [
	^ 'Teaspoon client'
]

{ #category : #private }
Teaspoon >> client [
	^ ZnClient new
		url: self urlInput text;
		method: self methodDropList selectedItem;
		entity: (ZnStreamingEntity 
			readFrom: (ReadStream on: requestBody urlEncoded)
			usingType: self contentTypeDropList selectedItem
			andLength: requestBody urlEncoded size)
		yourself
]

{ #category : #accessing }
Teaspoon >> contentTypeDropList [
	^ contentTypeDropList
]

{ #category : #accessing }
Teaspoon >> contentTypeLabel [
	^ contentTypeLabel
]

{ #category : #accessing }
Teaspoon >> execButton [
	^ execButton
]

{ #category : #api }
Teaspoon >> initialExtent [
	^  580@420
]

{ #category : #initialization }
Teaspoon >> initializePresenter [
	execButton whenActionPerformedDo: [ self client execute inspect ].
]

{ #category : #initialization }
Teaspoon >> initializeWidgets [
	methodDropList := self newMethodDropList.
	urlInput := self newTextInput autoAccept: true; yourself.
	requestBody := TeaRequestBodyTabs new.
	contentTypeLabel := self newLabel label: 'Content Type'; yourself.
	contentTypeDropList := self newContentTypeDropList.
	execButton := self newButton label: 'Execute request'; yourself.
]

{ #category : #accessing }
Teaspoon >> methodDropList [
	^ methodDropList
]

{ #category : #initialization }
Teaspoon >> newContentTypeDropList [
	| dropList |
	dropList := self newDropList.
	#(
		applicationJson 
		applicationXml 
		applicationSton 
		applicationFormUrlEncoded 
		applicationOctetStream 
		text 
		textHtml 
		textPlain
	) do: [ :each | dropList addItemLabeled: (each value: ZnMimeType) do: [] ].	
	^ dropList
]

{ #category : #initialization }
Teaspoon >> newMethodDropList [
	| dropList |
	dropList := self newDropList.
	ZnConstants knownHTTPMethods do: [ :each | 
		dropList addItemLabeled: each do: [] ].
	^ dropList
]

{ #category : #private }
Teaspoon >> populateMethod: aTeaRoute [
	| selected |
	selected := methodDropList listItems
		detect: [ :each | each = aTeaRoute methodMatcher asString ]
		ifNone: [ methodDropList listItems first ].
	methodDropList setSelectedItem: selected
]

{ #category : #private }
Teaspoon >> populateUrl: aTeaRoute port: portNumber [
	| pathSegment |
	pathSegment := aTeaRoute urlPattern asRequestBuilderPath.
	(pathSegment beginsWith: '/') 
		ifFalse: [ pathSegment := '/', pathSegment ].	
	urlInput text: ('http://localhost:', portNumber asString, pathSegment)
]

{ #category : #accessing }
Teaspoon >> requestBody [
	^ requestBody
]

{ #category : #'tea spoon' }
Teaspoon >> route: aTeaRoute port: portNumber [
	self populateMethod: aTeaRoute.
	self populateUrl: aTeaRoute port: portNumber.
]

{ #category : #accessing }
Teaspoon >> urlInput [
	^ urlInput
]
