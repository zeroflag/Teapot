"
I'm built up from a dynamically extensible list of other components.
"
Class {
	#name : #TeaKeyValueList,
	#superclass : #DynamicComposableModel,
	#instVars : [
		'models'
	],
	#category : #'Teapot-Tools-UI-Components'
}

{ #category : #specs }
TeaKeyValueList class >> defaultSpec [
	^ SpecLayout composed
]

{ #category : #protocol }
TeaKeyValueList >> addKey: keyString value: valueString [
	self needFullRebuild: false.	
	self buildWithSpecLayout: 
		(self dynamicLayout: 
			(self asAssociations copyWith: keyString -> valueString))
]

{ #category : #private }
TeaKeyValueList >> asAssociations [
	^ models collect: #asAssociation
]

{ #category : #private }
TeaKeyValueList >> dynamicLayout: associations [
	self focusOrder removeAll.
	models removeAll.
	self widgets removeAll.
	^ SpecLayout composed newColumn: [ :col |
			associations doWithIndex: [:assoc :i | 
				| inputName widget |
				inputName := ('input', i asString) asSymbol.
				self instantiateModels: {inputName.  #TeaKeyValueInput}.
				widget := self perform: inputName.
				widget
					setKey: assoc key
					value: assoc value
					removeAction: [ :me | self remove: me ].
				models add: widget.
				self focusOrder add: widget.
				col 
					newRow: [ :row | row add: inputName ] ] ].
		
]

{ #category : #initialization }
TeaKeyValueList >> initialize [
	super initialize.
	models := OrderedCollection new.
]

{ #category : #protocol }
TeaKeyValueList >> items [
	^ self withoutDuplicatesAndBlanks: (self asAssociations asOrderedDictionary)
]

{ #category : #protocol }
TeaKeyValueList >> items: keyedCollection [
	self needFullRebuild: false.
	self buildWithSpecLayout: 
		(self dynamicLayout: 
			(self withoutDuplicatesAndBlanks: keyedCollection))
]

{ #category : #private }
TeaKeyValueList >> remove: model [
	self needFullRebuild: false.
	models remove: model.
	self buildWithSpecLayout: (self dynamicLayout: self asAssociations)
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
