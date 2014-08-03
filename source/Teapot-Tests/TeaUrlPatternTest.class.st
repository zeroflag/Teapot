Class {
	#name : #TeaUrlPatternTest,
	#superclass : #TestCase,
	#category : #'Teapot-Tests'
}

{ #category : #private }
TeaUrlPatternTest >> pattern: patternString matches: urlString [
	| placeholders |
	placeholders := Dictionary new.
	self assert: ((TeaUrlPattern parseString: patternString) matchesUrl: urlString asUrl placeholders: placeholders).
	^ placeholders
]

{ #category : #private }
TeaUrlPatternTest >> pattern: patternString noMatch: urlString [
	| placeholders |
	placeholders := Dictionary new.
	self deny: ((TeaUrlPattern parseString: patternString) matchesUrl: urlString asUrl placeholders: placeholders).
	^ placeholders
]

{ #category : #tests }
TeaUrlPatternTest >> testLongerPatternEndedPlaceholder [
	self pattern: '/a/b/<id>' noMatch: '/a/b'.

]

{ #category : #tests }
TeaUrlPatternTest >> testLongerPatternEndedWildcard [
	self pattern: '/a/b/c/*' matches: '/a/b/c'.
	self pattern: '/1/2/3/*/*' matches: '/1/2/3'.
	
	self pattern: '/a/b/c/*' noMatch: '/a/b'.
]

{ #category : #tests }
TeaUrlPatternTest >> testNoWildcard [	
	self pattern: '/aa' matches: '/aa'.
	self pattern: '/aa' noMatch: '/bb'.
]

{ #category : #tests }
TeaUrlPatternTest >> testPlaceholderSubstitute [
	| placeholders |
	
	placeholders := self pattern: '/<id>/a/b' matches: '/123/a/b'.
	self assert: (placeholders at: #id) equals: '123'.
	
	placeholders := self pattern: '/a/<id>/b' matches: '/a/25/b'.
	self assert: (placeholders at: #id) equals: '25'.
	
	placeholders := self pattern: '/a/b/<id>' matches: '/a/b/xyz'.	
	self assert: (placeholders at: #id) equals: 'xyz'.		

]

{ #category : #tests }
TeaUrlPatternTest >> testPlaceholderTypeMatch [
	| placeholders |
	placeholders := self pattern: '/<id:IsInteger>' matches: '/12'.
	self assert: (placeholders at: #id) equals: 12.
	
	placeholders := self pattern: '/<id:IsInteger>/abc' matches: '/-34/abc'.
	self assert: (placeholders at: #id) equals: -34.
	
	placeholders := self pattern: '/<float:IsNumber>/<int:IsNumber>' matches: '/3.14/3'.
	self assert: (placeholders at: #float) equals: 3.14.
	self assert: (placeholders at: #int) equals: 3.	
]

{ #category : #tests }
TeaUrlPatternTest >> testPlaceholderTypeNoMatch [
	self pattern: '/<id:IsInteger>' noMatch: '/foobar'.	
	self pattern: '/<id:IsNumber>' noMatch: '/foobar'.
	self pattern: '/<id:IsInteger>' noMatch: '/12.3'.

	
	
]

{ #category : #tests }
TeaUrlPatternTest >> testPlaceholders [
	self pattern: '/<id>/a/b' matches: '/1/a/b'.
	self pattern: '/a/<id>/b' matches: '/a/2/b'.
	self pattern: '/a/b/<id>' matches: '/a/b/1'.	
	
	self pattern: '/<id>/a/b' noMatch: '/1/a/c'.
	self pattern: '/a/<id>/b' noMatch: '/a/2/c'.
	self pattern: '/a/b/<id>' noMatch: '/a/c/1'.
]

{ #category : #tests }
TeaUrlPatternTest >> testRoot [
	self pattern: '/' matches: '/'.	
	self pattern: '/' noMatch: '/a'.	
	self pattern: '/a' noMatch: '/'.
]

{ #category : #tests }
TeaUrlPatternTest >> testShorterPatternEndedPlaceholder [
	self pattern: '/a/b/<id>' noMatch: '/a/b/1/2'.	

]

{ #category : #tests }
TeaUrlPatternTest >> testShorterPatternEndedWildcard [	
 	self pattern: '/a/*' matches: '/a/b/c'.
	self pattern: '/*' matches: '/1/2/3'.
	
 	self pattern: '/a/*' noMatch: '/b/b/c'.
	self pattern: '/a/b' noMatch: '/a/b/c'.	
]

{ #category : #tests }
TeaUrlPatternTest >> testTralingSlash [
	self pattern: '/a/b' matches: '/a/b/'.

]

{ #category : #tests }
TeaUrlPatternTest >> testWildcards [
	self pattern: '/*/1/2' matches: '/0/1/2'.
	self pattern: '/a/b/*' matches: '/a/b/c'.
	self pattern: '/x/*/z' matches: '/x/y/z'.
	
	self pattern: '/*/1/2' noMatch: '/a/1/z'.	
	self pattern: '/a/b/*' noMatch: '/a/1/z'.	
	self pattern: '/x/*/z' noMatch: '/a/1/z'.					

	
]
