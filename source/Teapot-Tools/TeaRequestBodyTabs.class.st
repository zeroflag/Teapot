"
I graphically represent a request body that can be viewed in multiple ways.
"
Class {
	#name : #TeaRequestBodyTabs,
	#superclass : #SpPresenter,
	#instVars : [
		'requestBody',
		'label',
		'raw',
		'form'
	],
	#category : #'Teapot-Tools-UI-Components'
}

{ #category : #layout }
TeaRequestBodyTabs class >> defaultLayout [
	^ SpBoxLayout newVertical 
		add: #label expand: false fill: false;
		spacing: 5;
		add: #requestBody expand: true fill: true;
		yourself
]

{ #category : #private }
TeaRequestBodyTabs >> formTabTitle [
	^ 'Form'
]

{ #category : #initialization }
TeaRequestBodyTabs >> initializePresenters [
	label := self newLabel label: 'Request body'; yourself.
	requestBody := self newRequestBody.
]

{ #category : #accessing }
TeaRequestBodyTabs >> label [
	^ label
]

{ #category : #initialization }
TeaRequestBodyTabs >> newRequestBody [
	raw := self newText.
	form := TeaFormTab new.
	^ self newNotebook 
		addPageTitle: self rawTabTitle provider: raw; 
		addPageTitle: self formTabTitle provider: form;
		whenSelectedPageChangedDo: [ :selected | 
			selected title = self formTabTitle
				ifTrue: [ form updateKeyValus: ('?' , raw text) asUrl query ]
				ifFalse: [ form writeUrlEncodedTo: raw ] ];
		yourself
]

{ #category : #private }
TeaRequestBodyTabs >> rawTabTitle [
	^ 'Raw'
]

{ #category : #accessing }
TeaRequestBodyTabs >> requestBody [
	^ requestBody
]

{ #category : #protocol }
TeaRequestBodyTabs >> urlEncoded [
	requestBody selectedPage title = self formTabTitle
		ifTrue: [ raw text: form urlEncoded ].
	^ raw text
]
