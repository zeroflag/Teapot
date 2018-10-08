Class {
	#name : #TeapotWithTypeConstraintTest,
	#superclass : #TestCase,
	#instVars : [
		'server'
	],
	#category : #'Teapot-Tests'
}

{ #category : #running }
TeapotWithTypeConstraintTest >> setUp [
	server := Teapot on
		GET: '/u/<identifier:IsUUID>/more' -> [ :req | (req at: #identifier) asString ];
		GET: '/u' -> 'no uuid';
		GET: '/u/<identifier:IsUUID>' -> [ :req | (req at: #identifier) asString36  ];		
		start
]

{ #category : #running }
TeapotWithTypeConstraintTest >> tearDown [
	server stop
]

{ #category : #tests }
TeapotWithTypeConstraintTest >> testNoParams [
	self 
		assert: (TeaTestClient httpGetString: '/u') 
		equals: 'no uuid'.	

]

{ #category : #tests }
TeapotWithTypeConstraintTest >> testParseTypeConstraint [
	self 
		assert: (TeaTestClient httpGetString: '/u/964d5d07-1834-0d00-a106-47ae08909eb2') 
		equals: (UUID fromString: '964d5d07-1834-0d00-a106-47ae08909eb2') asString36.	

]

{ #category : #tests }
TeapotWithTypeConstraintTest >> testParseTypeConstraint2 [
	self 
		assert: (TeaTestClient httpGetString: '/u/964d5d07-1834-0d00-a106-47ae08909eb2/more') 
		equals: '964d5d07-1834-0d00-a106-47ae08909eb2'.	

]
