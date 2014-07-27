Class {
	#name : #UrlPatternTest,
	#superclass : #TestCase,
	#category : #'Teapot-Tests'
}

{ #category : #private }
UrlPatternTest >> pattern: patternString matches: urlString [
	| placeholders |
	placeholders := Dictionary new.
	self assert: ((UrlPattern parseString: patternString) matchesUrl: urlString asUrl placeholders: placeholders).
	^ placeholders
]

{ #category : #private }
UrlPatternTest >> pattern: patternString noMatch: urlString [
	| placeholders |
	placeholders := Dictionary new.
	self deny: ((UrlPattern parseString: patternString) matchesUrl: urlString asUrl placeholders: placeholders).
	^ placeholders
]

{ #category : #tests }
UrlPatternTest >> testLongerPatternEndedPlaceholder [
	self pattern: '/a/b/:id' noMatch: '/a/b'.

]

{ #category : #tests }
UrlPatternTest >> testLongerPatternEndedWildcard [
	self pattern: '/a/b/c/*' matches: '/a/b/c'.
	self pattern: '/1/2/3/*/*' matches: '/1/2/3'.
	
	self pattern: '/a/b/c/*' noMatch: '/a/b'.
]

{ #category : #tests }
UrlPatternTest >> testNoWildcard [	
	self pattern: '/aa' matches: '/aa'.
	self pattern: '/aa' noMatch: '/bb'.
]

{ #category : #tests }
UrlPatternTest >> testPlaceholderSubstitute [
	| placeholders |
	
	placeholders := self pattern: '/:id/a/b' matches: '/123/a/b'.
	self assert: (placeholders at: #id) equals: '123'.
	
	placeholders := self pattern: '/a/:id/b' matches: '/a/25/b'.
	self assert: (placeholders at: #id) equals: '25'.
	
	placeholders := self pattern: '/a/b/:id' matches: '/a/b/xyz'.	
	self assert: (placeholders at: #id) equals: 'xyz'.		

]

{ #category : #tests }
UrlPatternTest >> testPlaceholders [
	self pattern: '/:id/a/b' matches: '/1/a/b'.
	self pattern: '/a/:id/b' matches: '/a/2/b'.
	self pattern: '/a/b/:id' matches: '/a/b/1'.	
	
	self pattern: '/:id/a/b' noMatch: '/1/a/c'.
	self pattern: '/a/:id/b' noMatch: '/a/2/c'.
	self pattern: '/a/b/:id' noMatch: '/a/c/1'.	
]

{ #category : #tests }
UrlPatternTest >> testRoot [
	self pattern: '/' matches: '/'.	
	self pattern: '/' noMatch: '/a'.	

]

{ #category : #tests }
UrlPatternTest >> testShorterPatternEndedPlaceholder [
	self pattern: '/a/b/:id' noMatch: '/a/b/1/2'.	

]

{ #category : #tests }
UrlPatternTest >> testShorterPatternEndedWildcard [	
 	self pattern: '/a/*' matches: '/a/b/c'.
	self pattern: '/*' matches: '/1/2/3'.
	
 	self pattern: '/a/*' noMatch: '/b/b/c'.
	self pattern: '/a/b' noMatch: '/a/b/c'.	
]

{ #category : #tests }
UrlPatternTest >> testTralingSlash [
	self pattern: '/a/b' matches: '/a/b/'.

]

{ #category : #tests }
UrlPatternTest >> testWildcards [
	self pattern: '/*/1/2' matches: '/0/1/2'.
	self pattern: '/a/b/*' matches: '/a/b/c'.
	self pattern: '/x/*/z' matches: '/x/y/z'.
	
	self pattern: '/*/1/2' noMatch: '/a/1/z'.	
	self pattern: '/a/b/*' noMatch: '/a/1/z'.	
	self pattern: '/x/*/z' noMatch: '/a/1/z'.					

	
]
