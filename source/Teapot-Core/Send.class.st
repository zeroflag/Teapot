"
I can send messages to objects on a http requests. The selector of the message can take maximum 2 arguments ( TeaRequest and TeaResponse).

Example:

Teapot on
	GET: '/hi' -> (Send message: #greet to: controller);
	start.
	
"
Class {
	#name : #Send,
	#superclass : #Object,
	#instVars : [
		'selector',
		'receiver'
	],
	#category : #'Teapot-Core'
}

{ #category : #'instance creation' }
Send class >> message: aSymbol to: anObject [
	^ self new 
		setSelector: aSymbol 
		receiver: anObject
]

{ #category : #'tea action' }
Send >> handleTeaException: anException request: aTeaRequest [
	^ receiver 
		perform: selector 
		withEnoughArguments: { anException. aTeaRequest }
	

]

{ #category : #'tea action' }
Send >> handleTeaRequest: aTeaRequest [
	^ receiver 
		perform: selector 
		withEnoughArguments: { aTeaRequest }
	

]

{ #category : #printing }
Send >> printOn: aStream [
	aStream 
		nextPutAll: '(Send message: ';
		nextPutAll: selector printString;
		nextPutAll: ' to: '.
	receiver printOn: aStream.
	aStream nextPut: $)
]

{ #category : #initialization }
Send >> setSelector: aSymbol receiver: anObject [
	selector := aSymbol.
	receiver := anObject.
	^ self	
]
