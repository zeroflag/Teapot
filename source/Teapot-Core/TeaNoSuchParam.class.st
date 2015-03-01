"
This exception indicates that the given parameter was not found in the TeaRequest.

"
Class {
	#name : #TeaNoSuchParam,
	#superclass : #KeyNotFound,
	#instVars : [
		'param'
	],
	#category : #'Teapot-Core'
}

{ #category : #signaling }
TeaNoSuchParam class >> signalWithParam: aSymbol [
	(self new setParam: aSymbol) signal: 'Param ', aSymbol printString, ' not found'
]

{ #category : #accessing }
TeaNoSuchParam >> param [
	^ param
]

{ #category : #initialization }
TeaNoSuchParam >> setParam: aSymbol [
	param := aSymbol.
	^ self
]
