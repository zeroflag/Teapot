"
I'm a type constraint that matches to positive or negative integers.

"
Class {
	#name : 'IsInteger',
	#superclass : 'IsObject',
	#category : 'Teapot-Core',
	#package : 'Teapot-Core'
}

{ #category : 'type constraint' }
IsInteger class >> matchesTo: aString [
	^ '-?\d+' asRegex matches: aString
]

{ #category : 'type constraint' }
IsInteger class >> parseString: aString [
	^ aString asInteger
]
