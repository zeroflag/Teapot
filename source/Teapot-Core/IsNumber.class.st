"
I'm a type constraint that matches to positive or negative floats or integers.

"
Class {
	#name : #IsNumber,
	#superclass : #IsObject,
	#category : #'Teapot-Core'
}

{ #category : #'placeholder type constraint' }
IsNumber class >> matchesTo: aString [
	Number 
		readFrom: aString 
		ifFail: [ ^false ].
	^ true
]

{ #category : #'placeholder type constraint' }
IsNumber class >> parseString: aString [
	^ aString asNumber
]
