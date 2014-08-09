"
I'm an exception that immediately stops a request within a filter or route.
"
Class {
	#name : #TeaAbort,
	#superclass : #Error,
	#instVars : [
		'code',
		'reason'
	],
	#category : #'Teapot-Core'
}

{ #category : #'instance creation' }
TeaAbort class >> code: anInteger reason: aString [
	^ self new
		setCode: anInteger
		reason: aString	
]

{ #category : #converting }
TeaAbort >> asStatusLine [
	^ (ZnStatusLine code: code)
		reason: reason;
		yourself
]

{ #category : #initialization }
TeaAbort >> setCode: anInteger reason: aString [
	code := anInteger.
	reason := aString.
	^ self
]
