"
I'm built up from a dynamically extensible key value pair list (TeaKeyValueInput). I can represent POST parameters or HTTP headers for example.
"
Class {
	#name : #TeaFormTab,
	#superclass : #ComposableModel,
	#instVars : [
		'form',
		'addButton'
	],
	#category : #'Teapot-Tools-UI'
}

{ #category : #specs }
TeaFormTab class >> defaultSpec [
	^ SpecLayout composed
		newColumn: [ :col |
			col 
				add: #form;
				add: #addButton height: self buttonHeight ]
]

{ #category : #accessing }
TeaFormTab >> addButton [
	^ addButton 
]

{ #category : #accessing }
TeaFormTab >> form [
	^ form
]

{ #category : #initialization }
TeaFormTab >> initializePresenter [
	addButton whenActionPerformedDo: [ 
		form items: (form listItems copyWith: (self newKey: 'key' value: 'value')) ]
]

{ #category : #initialization }
TeaFormTab >> initializeWidgets [
	addButton := self newButton label: 'Add parameter'; yourself.
	form := self newList
		displayBlock: [ :item | item ];
		allowToSelect: false;
		yourself.
]

{ #category : #private }
TeaFormTab >> newKey: keyString value: valueString [
	^ TeaKeyValueInput 
		key: keyString 
		value: valueString
		removeAction: [ :me | form items: (form listItems copyWithout: me) ]
]

{ #category : #protocol }
TeaFormTab >> updateKeyValus: keyValueCollection [
	| newItems |
	newItems := keyValueCollection collect: 
		[ :each | 
		self newKey: each key value: each value ].
	form items: newItems
]

{ #category : #protocol }
TeaFormTab >> urlEncoded [
	| url |
	form listItems ifEmpty: [ ^ '' ].
	url := '/' asZnUrl.
	(form listItems collect: #asAssociation) asSet do: 
		[ :association | 
		url := url withQuery: association ].
	^ url asString allButFirst: 2
	
]
