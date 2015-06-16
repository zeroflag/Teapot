"
I match to the given url if any of my elements match.

E.g.

Teapot on
	GET: {'/a'. '/b'} -> 'ab';
	start.		

Both ZnEasy get: '/a' and ZnEasy get: '/b' returns 'ab'
"
Class {
	#name : #TeaUrlPatternSet,
	#superclass : #TeaUrlPattern,
	#instVars : [
		'patterns'
	],
	#category : #'Teapot-Core'
}

{ #category : #'instance creation' }
TeaUrlPatternSet class >> fromCollection: aCollection [ 
	^ self new setPatterns: (aCollection collect: #asTeaUrlPattern)
]

{ #category : #'url matcher' }
TeaUrlPatternSet >> matchesUrl: anUrl placeholders: aDictionary [
	^ patterns anySatisfy: [ :each | each matchesUrl: anUrl placeholders: aDictionary ]
]

{ #category : #initialization }
TeaUrlPatternSet >> setPatterns: aCollection [ 
	patterns := aCollection.
	^ self
]
