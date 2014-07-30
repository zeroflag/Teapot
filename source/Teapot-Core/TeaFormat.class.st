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
	^ [ :content :req :resp | 
		resp setContentType: ZnMimeType textHtml.
		content ]
]

{ #category : #'instance creation' }
TeaFormat class >> json [
	^ [ :object :req :resp | 
		resp setContentType: ZnMimeType applicationJson.
		(Smalltalk at: #NeoJSONWriter) toString: object ]
]

{ #category : #'instance creation' }
TeaFormat class >> jsonPretty [
	^ [ :object :req :resp | 
		resp setContentType: ZnMimeType applicationJson.
		(Smalltalk at: #NeoJSONWriter) toStringPretty: object ]
]

{ #category : #'instance creation' }
TeaFormat class >> mustache: templateString contentType: contentType [
	^ [ :model :req :resp | 
		resp setContentType: contentType.
		((Smalltalk at: #MustacheTemplate) on: templateString) value: model ]
]

{ #category : #'instance creation' }
TeaFormat class >> mustacheHtml: templateString [ 
	^ self mustache: templateString contentType: ZnMimeType textHtml.
]

{ #category : #'instance creation' }
TeaFormat class >> ston [
	^ [ :object :req :resp | 
		resp setContentType: ZnMimeType textPlain.
		(Smalltalk at: #STON) toString: object ]
]

{ #category : #'instance creation' }
TeaFormat class >> stonPretty [
	^ [ :object :req :resp | 
		resp setContentType: ZnMimeType textPlain.
		(Smalltalk at: #STON) toStringPretty: object ]
]

{ #category : #'instance creation' }
TeaFormat class >> text [
	^ [ :content :req :resp | 
		resp setContentType: ZnMimeType textPlain.
		content ]
]
