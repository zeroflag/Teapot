"
I graphically represent a request body that can be viewed in multiple ways.
"
Class {
	#name : #TeaRequestBodyTabs,
	#superclass : #ComposableModel,
	#instVars : [
		'requestBody',
		'label',
		'raw',
		'form'
	],
	#category : #'Teapot-Tools-UI-Components'
}

{ #category : #specs }
TeaRequestBodyTabs class >> defaultSpec [
	^ SpecLayout composed
		newColumn: [ :col |
			col 
				add: #label height: self inputTextHeight;
				add: #requestBody ]
]

{ #category : #private }
TeaRequestBodyTabs >> formTabTitle [
	^ 'Form'
]

{ #category : #initialization }
TeaRequestBodyTabs >> initializeWidgets [
	label := self newLabel label: 'Request body'; yourself.
	requestBody := self newRequestBody.
]

{ #category : #accessing }
TeaRequestBodyTabs >> label [
	^ label
]

{ #category : #initialization }
TeaRequestBodyTabs >> newRequestBody [

	raw := self newText
		autoAccept: true;
		yourself.
	form := TeaFormTab new.
	^ self newTabManager
		addTab:
			(self newTab
				label: self rawTabTitle;
				closeable: false;
				presenter: raw);
		addTab:
			(self newTab
				label: self formTabTitle;
				closeable: false;
				presenter: form);
		whenTabSelected: [ :selected | 
			selected label = self formTabTitle
				ifTrue: [ form updateKeyValus: ('?' , raw text) asUrl query ]
				ifFalse: [ form writeUrlEncodedTo: raw ] ]
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
	requestBody selectedTab label = self formTabTitle
		ifTrue: [ raw text: form urlEncoded ].
	^ raw text
]
