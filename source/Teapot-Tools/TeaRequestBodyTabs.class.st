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
	#category : #'Teapot-Tools-UI'
}

{ #category : #specs }
TeaRequestBodyTabs class >> defaultSpec [
	^ SpecLayout composed
		newColumn: [ :col |
			col 
				add: #label height: self inputTextHeight;
				add: #requestBody ]
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
	raw := self newText autoAccept: true; yourself.
	form := TeaFormTab new.
	^ self newTabManager
			addTab: (self newTab
				label: 'Raw';
				closeable: false;
				model: raw);
			addTab: (self newTab
				label: 'Form';
				closeable: false;				
				model: form);
			whenTabSelected: [:selected |
				selected label = 'Form'
					ifTrue: [ form updateKeyValus: ('?', raw text) asUrl query associations ] 
					ifFalse: [ raw text: form urlEncoded ] ]
]

{ #category : #accessing }
TeaRequestBodyTabs >> requestBody [
	^ requestBody
]

{ #category : #protocol }
TeaRequestBodyTabs >> urlEncoded [
	^ raw text
]
