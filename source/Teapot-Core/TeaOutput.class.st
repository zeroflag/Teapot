"
I have various response transformer methods on my class side, that can be used as follows:

Teapot on
	GET: '/books' -> books; output: #json;
	start.
	
Some of the transformers require optional dependencies, like Neo-JSON, STON, or Mustache.

"
Class {
	#name : #TeaOutput,
	#superclass : #Object,
	#category : #'Teapot-Core'
}

{ #category : #'response transformers' }
TeaOutput class >> html [
	^ self stringWithContentType: ZnMimeType textHtml
]

{ #category : #'response transformers' }
TeaOutput class >> json [
	^ [ :aTeaResponse | | entity |
		entity := ZnStringEntity 
			with: ((self optionalClass: #NeoJSONWriter) toString: aTeaResponse body) 
			type: ZnMimeType applicationJson.
		self 
			znEntity: entity
			code: aTeaResponse code 
			headers: aTeaResponse headers ]
]

{ #category : #'response transformers' }
TeaOutput class >> mustache: templateStringOrStream contentType: contentType [
	^ [ :aTeaResponse | | model object entity |
		object := aTeaResponse body.
		model := (object respondsTo: #asDictionary) ifTrue: [ object asDictionary ] ifFalse: [ object ].		
		entity := (ZnStringEntity 
			with: (((self optionalClass: #MustacheTemplate) on: templateStringOrStream) value: model) 
			type: contentType).
		self 
			znEntity: entity
			code: aTeaResponse code 
			headers: aTeaResponse headers ]

]

{ #category : #'response transformers' }
TeaOutput class >> mustacheHtml: templateString [ 
	^ self mustache: templateString contentType: ZnMimeType textHtml.
]

{ #category : #private }
TeaOutput class >> optionalClass: aSymbol [
	[ ^ Smalltalk at: aSymbol ]
		on: KeyNotFound
		do: [ self error: 'An optional dependency ', aSymbol, ' was not found. Please load it first.' ]
]

{ #category : #'response transformers' }
TeaOutput class >> ston [
	^ [ :aTeaResponse | | entity |
		entity := ZnStringEntity 
			with: ((self optionalClass: #STON) toString: aTeaResponse body) 
			type: ZnMimeType textPlain.
		self 
			znEntity: entity
			code: aTeaResponse code 
			headers: aTeaResponse headers ]
]

{ #category : #'response transformers' }
TeaOutput class >> stream [
	^ self stream: ZnMimeType applicationOctetStream 
]

{ #category : #'response transformers' }
TeaOutput class >> stream: aZnMimeType [
	^ [ :aTeaResponse | | entity |
		entity := ZnStreamingEntity 
			readFrom: aTeaResponse body
			usingType: aZnMimeType
			andLength: aTeaResponse body size.
		self 
			znEntity: entity
			code: aTeaResponse code 
			headers: aTeaResponse headers ]

]

{ #category : #'response transformers' }
TeaOutput class >> stringWithContentType: aZnMimeType [ 
	^ [ :aTeaResponse | | entity |
		entity := (ZnStringEntity type: aZnMimeType) 
			string: aTeaResponse body asString;
			yourself.
		self 
			znEntity: entity 
			code: aTeaResponse code 
			headers: aTeaResponse headers ]
]

{ #category : #'response transformers' }
TeaOutput class >> text [
	^ self stringWithContentType: ZnMimeType textPlain

]

{ #category : #private }
TeaOutput class >> znEntity: aZnEntity code: anInteger headers: aDictionary [
	| headers |
	headers := ZnHeaders defaultResponseHeaders.
	headers addAll: aDictionary.
	^ ZnResponse new
		statusLine: (ZnStatusLine code: anInteger);
		headers: headers;
		entity: aZnEntity;
		yourself
]
