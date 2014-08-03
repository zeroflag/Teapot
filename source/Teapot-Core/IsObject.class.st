"
I'm the base class of the type constraints. I match to any object. My subclasses can restict the type of placeholders.

Example:

Teapot on
	GET: '/user/<id:IsInteger>' -> [:req | users findById: (req at: #id)];
	start.

This route matches to the '/users/12' but does not match to '/users/foobar'. In case of matching, the the path paramter ""id"" will be converted to an integer.

You can extend the built in type constraints with your own constraints, by implementing the ""placeholder type constraint"" protocol.
"
Class {
	#name : #IsObject,
	#superclass : #Object,
	#category : #'Teapot-Core'
}

{ #category : #'placeholder type constraint' }
IsObject class >> matchesTo: aString [
	^ true
]

{ #category : #'placeholder type constraint' }
IsObject class >> parseString: aString [
	^ aString
]
