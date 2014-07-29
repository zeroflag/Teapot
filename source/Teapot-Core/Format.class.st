Class {
	#name : #Format,
	#superclass : #Object,
	#category : #'Teapot-Core'
}

{ #category : #'instance creation' }
Format class >> html [
	^ [ :content :req :resp | 
		resp headers contentType: 'text/html'. 
		content ]
]

{ #category : #'instance creation' }
Format class >> json [
	^ [ :object :req :resp | 
		resp headers contentType: 'application/json'.
		(Smalltalk at: #NeoJSONWriter) toString: object ]
]

{ #category : #'instance creation' }
Format class >> jsonPretty [
	^ [ :object :req :resp | 
		resp headers contentType: 'application/json'.
		(Smalltalk at: #NeoJSONWriter) toStringPretty: object ]
]

{ #category : #'as yet unclassified' }
Format class >> mustache: templateString contentType: contentType [
	^ [ :model :req :resp | 
		resp headers contentType: contentType.
		((Smalltalk at: #MustacheTemplate) on: templateString) value: model ]
]

{ #category : #'instance creation' }
Format class >> ston [
	^ [ :object :req :resp | 
		resp headers contentType: 'text/plain'.
		(Smalltalk at: #STON) toString: object ]
]

{ #category : #'instance creation' }
Format class >> stonPretty [
	^ [ :object :req :resp | 
		resp headers contentType: 'text/plain'.
		(Smalltalk at: #STON) toString: object ]
]

{ #category : #'instance creation' }
Format class >> text [
	^ [ :content :req :resp | 
		resp headers contentType: 'text/plain'. 
		content ]
]
