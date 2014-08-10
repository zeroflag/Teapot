"
I have various response transformer methods on my class side, that can be used as follows:

Teapot on
	GET: '/books' 
	do: [ books values ]; to: TeaFormat json;
	start.
	
Some of the transformers require optional dependencies, like Neo-JSON, STON, or Mustache.

"
Class {
	#name : #TeaFormat,
	#superclass : #Object,
	#category : #'Teapot-Core'
}

{ #category : #'response transformers' }
TeaFormat class >> contentType: aZnMimeType [ 
	^ [ :object |
		object asTeaResponse 
			setContentType: aZnMimeType 
			yourself ]
]

{ #category : #'response transformers' }
TeaFormat class >> html [
	^ self contentType: ZnMimeType textHtml
]

{ #category : #'response transformers' }
TeaFormat class >> json [
	^ [ :object | 
		ZnResponse ok: (ZnStringEntity 
			with: ((Smalltalk at: #NeoJSONWriter) toString: object) 
			type: ZnMimeType applicationJson) ]
]

{ #category : #'response transformers' }
TeaFormat class >> jsonPretty [
	^ [ :object | 
		ZnResponse ok: (ZnStringEntity 
			with: ((Smalltalk at: #NeoJSONWriter) toStringPretty: object) 
			type: ZnMimeType applicationJson) ]		
]

{ #category : #'response transformers' }
TeaFormat class >> mustache: templateStringOrStream contentType: contentType [
	^ [ :object | 
		ZnResponse ok: (ZnStringEntity 
			with: (((Smalltalk at: #MustacheTemplate) on: templateStringOrStream) value: object asDictionary) 
			type: contentType) ]

]

{ #category : #'response transformers' }
TeaFormat class >> mustacheHtml: templateString [ 
	^ self mustache: templateString contentType: ZnMimeType textHtml.
]

{ #category : #'response transformers' }
TeaFormat class >> ston [
	^ [ :object | 
		ZnResponse ok: (ZnStringEntity 
			with: ((Smalltalk at: #STON) toString: object) 
			type: ZnMimeType textPlain) ]				
]

{ #category : #'response transformers' }
TeaFormat class >> stonPretty [
	^ [ :object | 
		ZnResponse ok: (ZnStringEntity 
			with: ((Smalltalk at: #STON) toStringPretty: object) 
			type: ZnMimeType textPlain) ]				
]

{ #category : #'response transformers' }
TeaFormat class >> stream [
	^ self stream: ZnMimeType applicationOctetStream 
]

{ #category : #'response transformers' }
TeaFormat class >> stream: aZnMimeType [
	^ [ :aStream | 	
		ZnResponse ok: (ZnStreamingEntity 
			readFrom: aStream
			usingType: aZnMimeType
			andLength: aStream size) ]

]

{ #category : #'response transformers' }
TeaFormat class >> text [
	^ self contentType: ZnMimeType textPlain

]
