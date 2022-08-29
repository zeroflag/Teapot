"
I'm built up from a dynamically extensible key value pair list (TeaKeyValueInput). I can represent POST parameters or HTTP headers for example.
"
Class {
	#name : #TeaFormTab,
	#superclass : #SpPresenter,
	#instVars : [
		'form',
		'addButton'
	],
	#category : #'Teapot-Tools-UI-Components'
}

{ #category : #specs }
TeaFormTab class >> defaultLayout [
	^ SpBoxLayout newVertical 
		add: #form expand: false fill: false;
      add: (SpBoxLayout newHorizontal 
		   add: #addButton expand: false fill: false;
         hAlignCenter;
         yourself) expand: false fill: false;		
		yourself
]

{ #category : #accessing }
TeaFormTab >> addButton [
	^ addButton 
]

{ #category : #initialization }
TeaFormTab >> connectPresenters [ 
	addButton whenActionPerformedDo: [ form addKey: 'key' value: 'value' ]
]

{ #category : #accessing }
TeaFormTab >> form [
	^ form
]

{ #category : #initialization }
TeaFormTab >> initializePresenters [
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
