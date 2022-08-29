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
	| item |
	item := TeaKeyValueInput 
		key: keyString 
		value: valueString 
		removeAction: [ :teaKeyValueInput | self remove: teaKeyValueInput ].
	items add: item.
	self rebuildLayout.
]

{ #category : #private }
TeaKeyValueList >> asAssociations [
	^ items collect: #asAssociation
]

{ #category : #initialization }
TeaKeyValueList >> defaultLayout [
	^ SpBoxLayout new
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
	items removeAll.
	keyedCollection keysAndValuesDo: [ :key :value | self addKey: key value: value ].
]

{ #category : #initialization }
TeaKeyValueList >> layout [ 
	| box |
	box := SpBoxLayout newVertical
		spacing: 5;
		vAlignStart;
		yourself.
	items do: [ :teaKeyValueInput | box add: teaKeyValueInput ].
	^ items 
		ifEmpty: [ box ] 
		ifNotEmpty: [ SpScrollableLayout with: box ]
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
