Class {
	#name : #TeaFormat,
	#superclass : #Object,
	#category : #'Teapot-Core'
}

{ #category : #'instance creation' }
TeaFormat class >> html [
	^ [ :content :req :resp | 
		resp setContentType: 'text/html'. 
		content ]
]

{ #category : #'instance creation' }
TeaFormat class >> json [
	^ [ :object :req :resp | 
		resp setContentType: 'application/json'.
		(Smalltalk at: #NeoJSONWriter) toString: object ]
]

{ #category : #'instance creation' }
TeaFormat class >> jsonPretty [
	^ [ :object :req :resp | 
		resp setContentType: 'application/json'.
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
	^ self mustache: templateString contentType: 'text/html'
]

{ #category : #'instance creation' }
TeaFormat class >> ston [
	^ [ :object :req :resp | 
		resp setContentType: 'text/plain'.
		(Smalltalk at: #STON) toString: object ]
]

{ #category : #'instance creation' }
TeaFormat class >> stonPretty [
	^ [ :object :req :resp | 
		resp setContentType: 'text/plain'.
		(Smalltalk at: #STON) toString: object ]
]

{ #category : #'instance creation' }
TeaFormat class >> text [
	^ [ :content :req :resp | 
		resp setContentType: 'text/plain'. 
		content ]
]
