Extension { #name : 'String' }

{ #category : '*Teapot-Core' }
String >> asTeaUrlPattern [
	^ TeaGlobUrlPattern parseString: self
]
