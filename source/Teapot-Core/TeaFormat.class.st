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

{ #category : #'instance creation' }
TeaFormat class >> html [
	^ [ :str :req :resp | ZnStringEntity with: str type: ZnMimeType textHtml ]
]

{ #category : #'instance creation' }
TeaFormat class >> json [
	^ [ :object :req :resp | 
			ZnStringEntity 
				with: ((Smalltalk at: #NeoJSONWriter) toString: object) 
				type: ZnMimeType applicationJson ]
]

{ #category : #'instance creation' }
TeaFormat class >> jsonPretty [
	^ [ :object :req :resp | 
			ZnStringEntity 
				with: ((Smalltalk at: #NeoJSONWriter) toStringPretty: object) 
				type: ZnMimeType applicationJson ]
]

{ #category : #'instance creation' }
TeaFormat class >> mustache: templateString contentType: contentType [
	^ [ :model :req :resp | 
			ZnStringEntity 
				with: (((Smalltalk at: #MustacheTemplate) on: templateString) value: model asDictionary) 
				type: contentType ]
]

{ #category : #'instance creation' }
TeaFormat class >> mustacheHtml: templateString [ 
	^ self mustache: templateString contentType: ZnMimeType textHtml.
]

{ #category : #'instance creation' }
TeaFormat class >> ston [
	^ [ :object :req :resp | 
			ZnStringEntity 
				with: ((Smalltalk at: #STON) toString: object) 
				type: ZnMimeType textPlain ]
]

{ #category : #'instance creation' }
TeaFormat class >> stonPretty [
	^ [ :object :req :resp | 
			ZnStringEntity 
				with: ((Smalltalk at: #STON) toStringPretty: object) 
				type: ZnMimeType textPlain ]
]

{ #category : #'instance creation' }
TeaFormat class >> stream [
	^ self stream: ZnMimeType applicationOctetStream 
]

{ #category : #'instance creation' }
TeaFormat class >> stream: aZnMimeType [
	^ [ :stream :req :resp | 		
		ZnStreamingEntity 
			readFrom: stream 
			usingType: aZnMimeType
			andLength: stream size ]

]

{ #category : #'instance creation' }
TeaFormat class >> text [
	^ [ :str :req :resp | ZnStringEntity with: str type: ZnMimeType textPlain ]
]
