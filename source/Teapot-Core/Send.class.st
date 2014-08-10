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
	^ [ :arg1 :arg2 | 
		anObject perform: aSymbol withEnoughArguments: { arg1 . arg2 } ]
]
