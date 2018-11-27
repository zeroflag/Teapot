"
Two inputs and a remove button.
"
Class {
	#name : #TeaKeyValueInput,
	#superclass : #ComposableModel,
	#instVars : [
		'keyInput',
		'valueInput',
		'removeButton'
	],
	#category : #'Teapot-Tools-UI-Components'
}

{ #category : #specs }
TeaKeyValueInput class >> defaultSpec [
	^ SpecLayout composed
		newRow: [ :row |
			row
				add: #keyInput;
				add: #valueInput;
				add: #removeButton ]
		 height: self height
]

{ #category : #accessing }
TeaKeyValueInput class >> height [
	^ self inputTextHeight max: self buttonHeight
]

{ #category : #'instance creation' }
TeaKeyValueInput class >> key: keyString value: valueString removeAction: aBlock [
	^ self new
		setKey: keyString 
		value: valueString
		removeAction: aBlock
]

{ #category : #converting }
TeaKeyValueInput >> asAssociation [
	^ keyInput text -> valueInput text
]

{ #category : #initialization }
TeaKeyValueInput >> initializeWidgets [	
	keyInput := self newTextInput autoAccept: true; ghostText: 'key'; yourself.
	valueInput := self newTextInput autoAccept: true; ghostText: 'value'; yourself.
	removeButton := self newButton label: 'Remove'; yourself.
	self focusOrder
		add: keyInput;
		add: valueInput;
		add: removeButton.
		

]

{ #category : #accessing }
TeaKeyValueInput >> keyInput [
	^ keyInput
]

{ #category : #accessing }
TeaKeyValueInput >> removeButton [
	^ removeButton
]

{ #category : #initialization }
TeaKeyValueInput >> setKey: keyString value: valueString removeAction: aBlock [
	keyInput text: keyString.
	valueInput text: valueString.
	removeButton whenActionPerformedDo: [ aBlock value: self ].
	^ self
]

{ #category : #accessing }
TeaKeyValueInput >> valueInput [
	^ valueInput
]
