"
I'm an URL pattern that uses a regular expression internally. I collect subexpressions in case of matching.
"
Class {
	#name : #TeaRxUrlPattern,
	#superclass : #TeaUrlPattern,
	#instVars : [
		'regexp',
		'lock'
	],
	#category : #'Teapot-Core'
}

{ #category : #'instance creation' }
TeaRxUrlPattern class >> fromRxMatcher: aRxMatcher [ 
	^ self new initializeRxMatcher: aRxMatcher 
]

{ #category : #private }
TeaRxUrlPattern >> hasMatched: aZnUrl [
	| match | "XXX RxMatcher has state. Consider something better"
	lock critical: [ match := (regexp matches: aZnUrl path) or: [ regexp matches: '/', aZnUrl path ] ].
	^ match
]

{ #category : #initialization }
TeaRxUrlPattern >> initializeRxMatcher: aRxMatcher [ 
	regexp := aRxMatcher.
	lock := Mutex new.
	^ self
]

{ #category : #'url matcher' }
TeaRxUrlPattern >> matchesUrl: aZnUrl placeholders: aDictionary [ 
	| match |
	match := self hasMatched: aZnUrl.
	match ifTrue:
		[ 2 to: regexp subexpressionCount do: [ :i | 
			aDictionary at: i - 1put: (regexp subexpression: i) ] ].
	^ match

]
