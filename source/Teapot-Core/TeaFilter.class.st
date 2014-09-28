"
After and Before filters
"
Class {
	#name : #TeaFilter,
	#superclass : #Object,
	#instVars : [
		'action',
		'requestMatcher'
	],
	#category : #'Teapot-Core'
}

{ #category : #'instance creation' }
TeaFilter class >> urlPattern: anUrlPattern action: aTeaAction [
	^ self new 
		setMatcher: (TeaRequestMatcher method: TeaMethodMatcher any url: anUrlPattern)
		action: aTeaAction

]

{ #category : #initialization }
TeaFilter >> setMatcher: aTeaRequestMatcher action: aTeaAction [
	requestMatcher := aTeaRequestMatcher.
	action := aTeaAction.
	^ self
]
