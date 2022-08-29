"
Two inputs and a remove button.
"
Class {
	#name : #TeaKeyValueInput,
	#superclass : #SpPresenter,
	#instVars : [
		'keyInput',
		'valueInput',
		'removeButton'
	],
	#category : #'Teapot-Tools-UI-Components'
}

{ #category : #specs }
TeaKeyValueInput class >> defaultLayout [
	^ SpBoxLayout newHorizontal  
		add: #keyInput expand: true fill: true padding: 5;
		add: #valueInput expand: true fill: true padding: 5;
		add: #removeButton expand: false fill: false padding: 5;
		vAlignStart;
		yourself
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
TeaKeyValueInput >> initializePresenters [
	keyInput := self newTextInput placeholder: 'key'; yourself.
	valueInput := self newTextInput placeholder: 'value'; yourself.
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
