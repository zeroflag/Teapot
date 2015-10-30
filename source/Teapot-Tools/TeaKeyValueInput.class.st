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
	#category : #'Teapot-Tools-UI'
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

{ #category : #api }
TeaKeyValueInput >> initialExtent [
	^ 520 @ (self class height + 1)
]

{ #category : #initialization }
TeaKeyValueInput >> initializeWidgets [	
	keyInput := self newTextInput autoAccept: true; yourself.
	valueInput := self newTextInput autoAccept: true; yourself.
	removeButton := self newButton label: 'Remove'; yourself.
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
