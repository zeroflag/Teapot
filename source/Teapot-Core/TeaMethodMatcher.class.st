"
I can be matched against an HTTP method. I will return either true or false.
"
Class {
	#name : #TeaMethodMatcher,
	#superclass : #Object,
	#instVars : [
		'matcherBlock'
	],
	#category : #'Teapot-Core'
}

{ #category : #'instance creation' }
TeaMethodMatcher class >> any [
	^ self new setMatcherBlock: [ :anyMethod | true ]
]

{ #category : #'instance creation' }
TeaMethodMatcher class >> exactly: aSymbol [
	^ self new setMatcherBlock: [ :actual | actual = aSymbol ]
]

{ #category : #'http method matcher' }
TeaMethodMatcher >> matchesHttpMethod: aSymbol [
	^ matcherBlock value: aSymbol	
]

{ #category : #initialization }
TeaMethodMatcher >> setMatcherBlock: aBlockClosure [ 
	matcherBlock := aBlockClosure.
	^ self
]
