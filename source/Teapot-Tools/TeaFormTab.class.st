"
I'm built up from a dynamically extensible key value pair list (TeaKeyValueInput). I can represent POST parameters or HTTP headers for example.
"
Class {
	#name : #TeaFormTab,
	#superclass : #ComposablePresenter,
	#instVars : [
		'form',
		'addButton'
	],
	#category : #'Teapot-Tools-UI-Components'
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
	addButton whenActionPerformedDo: [ form addKey: '' value: '' ]
]

{ #category : #initialization }
TeaFormTab >> initializeWidgets [
	addButton := self newButton label: 'Add parameter'; yourself.
	form := self instantiate: TeaKeyValueList.
	self focusOrder 
		add: form;
		add: addButton.
]

{ #category : #protocol }
TeaFormTab >> updateKeyValus: keyValueCollection [
	form items: keyValueCollection
]

{ #category : #private }
TeaFormTab >> urlEncoded [
	| url formParams |
	url := '/' asZnUrl.
	formParams := form items.
	formParams ifEmpty: [ ^ '' ].
	formParams do: [ :association | url := url withQuery: association ].
	^ url asString allButFirst: 2
	
]

{ #category : #protocol }
TeaFormTab >> writeUrlEncodedTo: aTextModel [
	self urlEncoded 
		ifNotEmpty: [ aTextModel text: self urlEncoded ]
]
