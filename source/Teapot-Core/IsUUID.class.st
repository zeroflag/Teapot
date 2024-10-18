"
I'm a type constraint that matches to an UUID.

"
Class {
	#name : 'IsUUID',
	#superclass : 'IsObject',
	#category : 'Teapot-Core',
	#package : 'Teapot-Core'
}

{ #category : 'type constraint' }
IsUUID class >> matchesTo: aString [
	^ '[0-9a-f]{8}\-[0-9a-f]{4}\-[0-9a-f]{4}\-[0-9a-f]{4}\-[0-9a-f]{12}' asRegex matches: aString
]

{ #category : 'type constraint' }
IsUUID class >> parseString: aString [
	^ UUID fromString: aString
]
