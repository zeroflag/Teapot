"
I can be matched against an HTTP method. I will return either true or false.
"
Class {
	#name : 'TeaMethodMatcher',
	#superclass : 'Object',
	#instVars : [
		'matcherBlock',
		'name'
	],
	#category : 'Teapot-Core',
	#package : 'Teapot-Core'
}

{ #category : 'instance creation' }
TeaMethodMatcher class >> any [
	^ self new 
		setMatcherBlock: [ :anyMethod | true ] 
		name: 'ANY'
]

{ #category : 'instance creation' }
TeaMethodMatcher class >> exactly: aSymbol [
	^ self new 
		setMatcherBlock: [ :actual | actual = aSymbol ] 
		name: aSymbol asString
]

{ #category : 'converting' }
TeaMethodMatcher >> asString [
	^ name
]

{ #category : 'http method matcher' }
TeaMethodMatcher >> matchesHttpMethod: aSymbol [
	^ matcherBlock value: aSymbol
]

{ #category : 'printing' }
TeaMethodMatcher >> printOn: aStream [
	aStream 
		nextPutAll: name;
		nextPut: $:
]

{ #category : 'initialization' }
TeaMethodMatcher >> setMatcherBlock: aBlockClosure name: aString [
	matcherBlock := aBlockClosure.
	name := aString.
	^ self
]
