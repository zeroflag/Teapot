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
	#category : #'Teapot-Core'
}

{ #category : #'instance creation' }
Send class >> message: aSymbol to: anObject [
	^ [ :req :resp | 
		self
			sendMessage: aSymbol
			to: anObject
			request: req
			response: resp ]
]

{ #category : #private }
Send class >> sendMessage: aSymbol to: anObject request: req response: resp [
	aSymbol numArgs = 0 ifTrue: [ ^ anObject perform: aSymbol ].
	aSymbol numArgs = 1 ifTrue: [ ^ anObject perform: aSymbol with: req ].
	aSymbol numArgs = 2 ifTrue: [ ^ anObject perform: aSymbol with: req with: resp ].
	self error: 'Expected a selector with at most 2 arguments, got ', aSymbol printString.
]
