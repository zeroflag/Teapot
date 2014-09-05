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
	^ [ :object | 
		ZnResponse ok: (ZnStringEntity 
			with: ((self optionalClass: #NeoJSONWriter) toString: object) 
			type: ZnMimeType applicationJson) ]
]

{ #category : #'response transformers' }
TeaOutput class >> mustache: templateStringOrStream contentType: contentType [
	^ [ :object | | model |
		model := (object respondsTo: #asDictionary)
			ifTrue: [ object asDictionary ]
			ifFalse: [ object ].		
		ZnResponse ok: (ZnStringEntity 
			with: (((self optionalClass: #MustacheTemplate) on: templateStringOrStream) value: model) 
			type: contentType) ]

]

{ #category : #'response transformers' }
TeaOutput class >> mustacheHtml: templateString [ 
	^ self mustache: templateString contentType: ZnMimeType textHtml.
]

{ #category : #'response transformers' }
TeaOutput class >> none [
	^ [ nil ]
]

{ #category : #private }
TeaOutput class >> optionalClass: aSymbol [
	[ ^ Smalltalk at: aSymbol ]
		on: KeyNotFound
		do: [ self error: 'An optional dependency ', aSymbol, ' was not found. Please load it first.' ]
]

{ #category : #'response transformers' }
TeaOutput class >> ston [
	^ [ :object | 
		ZnResponse ok: (ZnStringEntity 
			with: ((self optionalClass: #STON) toString: object) 
			type: ZnMimeType textPlain) ]				
]

{ #category : #'response transformers' }
TeaOutput class >> stream [
	^ self stream: ZnMimeType applicationOctetStream 
]

{ #category : #'response transformers' }
TeaOutput class >> stream: aZnMimeType [
	^ [ :aStream | 	
		ZnResponse ok: (ZnStreamingEntity 
			readFrom: aStream
			usingType: aZnMimeType
			andLength: aStream size) ]

]

{ #category : #'response transformers' }
TeaOutput class >> stringWithContentType: aZnMimeType [ 
	^ [ :object | | entity |
		entity := (ZnStringEntity type: aZnMimeType) 
			string: object asString;
			yourself.		
		ZnResponse ok: entity ]
]

{ #category : #'response transformers' }
TeaOutput class >> text [
	^ self stringWithContentType: ZnMimeType textPlain

]
