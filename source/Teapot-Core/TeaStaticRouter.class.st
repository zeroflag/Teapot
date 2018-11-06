"
I'm a ZnDelegate based on ZnStaticFileServerDelegate. I serve static content from a file system directory.
"
Class {
	#name : #TeaStaticRouter,
	#superclass : #TeaRouter,
	#instVars : [
		'delegate'
	],
	#category : #'Teapot-Core'
}

{ #category : #'zn delegate' }
TeaStaticRouter >> handleRequest: aZnRequest ifUnhandled: aBlock [
	| response |
	delegate ifNil: [ ^ aBlock value ].
	response := delegate handleRequest: aZnRequest.
	^ response isNotFound ifTrue: aBlock ifFalse: [ response ]
]

{ #category : #acccessing }
TeaStaticRouter >> urlPrefix: urlPrefixString path: pathString [
	delegate ifNil: [ delegate := ZnStaticFileServerDelegate new ].
	delegate
		prefixFromString: urlPrefixString;
		directory: pathString asFileReference.
]
