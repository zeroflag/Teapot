"
I'm built up from a dynamically extensible list of other components.
"
Class {
	#name : #TeaKeyValueList,
	#superclass : #SpPresenter,
	#instVars : [
		'items'
	],
	#category : #'Teapot-Tools-UI-Components'
}

{ #category : #protocol }
TeaKeyValueList >> addKey: keyString value: valueString [
	items add: (TeaKeyValueInput key: keyString value: valueString removeAction: [ "TODO" ]).
	self rebuildLayout.
]

{ #category : #private }
TeaKeyValueList >> asAssociations [
	^ items collect: #asAssociation
]

{ #category : #initialization }
TeaKeyValueList >> defaultLayout [
	^ SpGridLayout new
]

{ #category : #initialization }
TeaKeyValueList >> initialize [
	super initialize.
	items := OrderedCollection new.
]

{ #category : #protocol }
TeaKeyValueList >> items [
	^ self withoutDuplicatesAndBlanks: (self asAssociations asOrderedDictionary)
]

{ #category : #protocol }
TeaKeyValueList >> items: keyedCollection [
	keyedCollection keysAndValuesDo: [ :key :value | self addKey: key value: value ].
]

{ #category : #initialization }
TeaKeyValueList >> layout [ 
	| grid |
	grid := SpBoxLayout newVertical.
	items do: [ :teaKeyValueInput | grid add: teaKeyValueInput ].
	^ grid
]

{ #category : #private }
TeaKeyValueList >> remove: item [
	items remove: item.
	self rebuildLayout.
]

{ #category : #private }
TeaKeyValueList >> withoutDuplicatesAndBlanks: keyedCollection [
	| keyset |
	keyset := PluggableSet new
		equalBlock: [ :a :b | a key = b key ];
		hashBlock: [ :x | x key hash ];
		yourself.				
	keyedCollection keysAndValuesDo: [ :key :value | 
		keyset add: (key -> value) ].
	^ keyset reject: [ :each | 
		each key isEmptyOrNil or: [ each value isEmptyOrNil ] ]
]
