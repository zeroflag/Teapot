Class {
	#name : #TeapotStaticFilesTest,
	#superclass : #TestCase,
	#instVars : [
		'server',
		'htdocs'
	],
	#category : #'Teapot-Tests'
}

{ #category : #private }
TeapotStaticFilesTest >> createTempHtdocs [
	| tmpHtdocs |
	tmpHtdocs := FileLocator temp asFileReference / 'test_htdocs'.
	tmpHtdocs createDirectory.
	tmpHtdocs / 'index.html' writeStreamDo: [ :stream | stream nextPutAll: 'static index' ].
	tmpHtdocs / 'a.txt' writeStreamDo: [ :stream | stream nextPutAll: 'a' ].
	tmpHtdocs / 'b.txt' writeStreamDo: [ :stream | stream nextPutAll: 'static' ].
	^ tmpHtdocs
]

{ #category : #running }
TeapotStaticFilesTest >> setUp [
	htdocs := self createTempHtdocs.
	server := Teapot on
		GET: 'here/are/statics/b.txt' -> 'dynamic';
		serveStatic: 'here/are/statics' from: htdocs;
		start
]

{ #category : #running }
TeapotStaticFilesTest >> tearDown [
	htdocs deleteAll.
	server stop.
]

{ #category : #tests }
TeapotStaticFilesTest >> testDynamicContentServedBeforeStatic [
	self assert: (TeaTestClient httpGetString: 'here/are/statics/b.txt') equals: 'dynamic'.
	
]

{ #category : #tests }
TeapotStaticFilesTest >> testStaticFile [
	self assert: (TeaTestClient httpGetString: 'here/are/statics/a.txt') equals: 'a'.
	
]

{ #category : #tests }
TeapotStaticFilesTest >> testStaticIndexHtml [
	self assert: (TeaTestClient httpGetString: 'here/are/statics') equals: 'static index'.
	
]

{ #category : #tests }
TeapotStaticFilesTest >> testStaticNotFound [
	self assert: (TeaTestClient httpGet: 'here/are/statics/notfound.txt') code equals: 404.
	
]
