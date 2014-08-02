Class {
	#name : #TeapotStaticFilesTest,
	#superclass : #TestCase,
	#instVars : [
		'server'
	],
	#category : #'Teapot-Tests'
}

{ #category : #running }
TeapotStaticFilesTest >> setUp [
	server := Teapot on
		GET: 'here/are/statics/b.txt' -> 'dynamic';
		serveStatic: 'here/are/statics' from: 'c:/temp/htdocs'; "TODO"
		start.		
]

{ #category : #running }
TeapotStaticFilesTest >> tearDown [
	server stop
]

{ #category : #tests }
TeapotStaticFilesTest >> testDynamicContentServedBeforeStatic [
	self assert: (TeaClient httpGetString: 'here/are/statics/b.txt') equals: 'dynamic'.
	
]

{ #category : #tests }
TeapotStaticFilesTest >> testStaticFile [
	self assert: (TeaClient httpGetString: 'here/are/statics/a.txt') equals: 'a'.
	
]

{ #category : #tests }
TeapotStaticFilesTest >> testStaticIndexHtml [
	self assert: (TeaClient httpGetString: 'here/are/statics') equals: 'static index'.
	
]

{ #category : #tests }
TeapotStaticFilesTest >> testStaticNotFound [
	self assert: (TeaClient httpGet: 'here/are/statics/notfound.txt') code equals: 404.
	
]
