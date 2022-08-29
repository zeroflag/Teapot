"
I provide a graphical interface for quickly testing and excesising routes. Right click on a route in the inspector to open me.
"
Class {
	#name : #Teaspoon,
	#superclass : #SpPresenter,
	#instVars : [
		'urlInput',
		'contentTypeDropList',
		'contentTypeLabel',
		'methodDropList',
		'execButton',
		'requestBody',
		'resultText',
		'resultLabel'
	],
	#category : #'Teapot-Tools-UI'
}

{ #category : #layout }
Teaspoon class >> defaultLayout [
    ^ SpBoxLayout newVertical 
        add: (SpBoxLayout newHorizontal
                    vAlignCenter;
                    add: #methodDropList expand: false fill: false;
                    spacing: 5;
                    add: #urlInput expand: true fill: true;
                    yourself) 
            expand: false fill: false padding: 10;
        add: #requestBody expand: true fill: true;
        add: (SpBoxLayout newHorizontal
                vAlignCenter;
                add: #contentTypeLabel expand: false fill: false;
                spacing: 5;
                add: #contentTypeDropList expand: true fill: true;
                yourself)
            expand: false fill: false;
        spacing: 10;		
		  add: #resultLabel expand: false fill: false;
        add: #resultText expand: true fill: true;
        add: (SpBoxLayout newHorizontal 
                add: #execButton expand: false fill: false;
                hAlignCenter;
                yourself)
            expand: false fill: false;
        yourself
]

{ #category : #'private - accessing' }
Teaspoon class >> iconProvider [

	^TeaIconProvider 
]

{ #category : #'world menu' }
Teaspoon class >> menuCommandOn: aBuilder [ 
	<worldMenu> 
	
	(aBuilder item: #'Teaspoon')	 
		help: 'Teaspoon'; 
		parent: #'Tools' translated;
		icon: self iconProvider teaspoonIcon;
		action: [ self open ].
]

{ #category : #interface }
Teaspoon class >> open [
	<script>
	^ (SpWindowPresenter presenter: self new)
		initialExtent: 600@600;
		open;
		yourself
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

{ #category : #initialization }
Teaspoon >> connectPresenters [ 
	execButton
		whenActionPerformedDo: [ 
			self urlInput text notEmpty
				ifTrue: [ 
					self resultText text: ''.
					self resultText text: self client execute.
				] 
		]
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

{ #category : #initialization }
Teaspoon >> initializePresenters [
	super initializePresenters.
	methodDropList := self newMethodDropList.
	urlInput := self newTextInput autoAccept: true; text: 'http://localhost:1701/'; yourself.
	requestBody := TeaRequestBodyTabs new.
	contentTypeLabel := self newLabel label: 'Content Type'; yourself.
	contentTypeDropList := self newContentTypeDropList.
	execButton := self newButton label: 'Execute request'; yourself.
	resultText := self newText.
	resultLabel := self newLabel label: 'Result'; yourself.
]

{ #category : #'tea spoon' }
Teaspoon >> method: methodString url: urlString port: portNumber [
	self populateMethod: methodString.
	self populateUrl: urlString port: portNumber.
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
		applicationFormUrlEncoded 
		applicationJson 
		applicationXml 
		applicationSton 
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
Teaspoon >> populateMethod: methodString [
	| selected |
	selected := methodDropList listItems
		detect: [ :each | each = methodString ]
		ifNone: [ methodDropList listItems first ].
	methodDropList selectItem: selected.
]

{ #category : #private }
Teaspoon >> populateUrl: urlString port: portNumber [
	| pathSegment |
	pathSegment := urlString.
	(pathSegment beginsWith: '/') 
		ifFalse: [ pathSegment := '/', pathSegment ].	
	urlInput text: ('http://localhost:', portNumber asString, pathSegment)
]

{ #category : #accessing }
Teaspoon >> requestBody [
	^ requestBody
]

{ #category : #accessing }
Teaspoon >> resultLabel [
	^ resultLabel
]

{ #category : #accessing }
Teaspoon >> resultText [
	^ resultText
]

{ #category : #accessing }
Teaspoon >> urlInput [
	^ urlInput
]
