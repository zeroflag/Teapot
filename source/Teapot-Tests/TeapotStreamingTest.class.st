Class {
	#name : 'TeapotStreamingTest',
	#superclass : 'TestCase',
	#instVars : [
		'server',
		'downloadFile'
	],
	#category : 'Teapot-Tests',
	#package : 'Teapot-Tests'
}

{ #category : 'private' }
TeapotStreamingTest >> content [
	^ (ByteArray new: 4096 withAll: 65) asString
]

{ #category : 'private' }
TeapotStreamingTest >> createDownloadableFile [
	| file |
	file := FileLocator temp asFileReference / 'download.file'.
	file writeStreamDo: [ :stream | stream nextPutAll: self content ].
	^ file

]

{ #category : 'private' }
TeapotStreamingTest >> deleteDownloadableFile [
	downloadFile delete
]

{ #category : 'running' }
TeapotStreamingTest >> setUp [
	downloadFile := self createDownloadableFile.
	server := Teapot on
		GET: '/stream' -> downloadFile readStream;
		output: #stream;
		start
]

{ #category : 'running' }
TeapotStreamingTest >> tearDown [
	self deleteDownloadableFile.
	server stop.
]

{ #category : 'tests' }
TeapotStreamingTest >> testStreamingContent [
	self 
		assert: (TeaTestClient httpGet: '/stream') contents asString 
		equals: self content
	
]
