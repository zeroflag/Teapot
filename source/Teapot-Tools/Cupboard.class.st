"
A cupboad for teapots
"
Class {
	#name : #Cupboard,
	#superclass : #Object,
	#classInstVars : [
		'soleInstance',
		'icons'
	],
	#category : #'Teapot-Tools-UI'
}

{ #category : #'private - accessing' }
Cupboard class >> icons [

	icons ifNil: [ icons := Dictionary new ].
	^icons
]

{ #category : #'world menu' }
Cupboard class >> menuCommandOn: aBuilder [ 
	<worldMenu> 
	
	(aBuilder item: #'Teapot')	 
		help: 'Teatime'; 
		parent: #'Tools' translated;
		icon: self teapotIcon;
		action: [ self soleInstance inspect ].
	 aBuilder withSeparatorAfter 
]

{ #category : #'instance creation' }
Cupboard class >> new [

	self error: 'Do not create new instances - access using #soleInstance'
]

{ #category : #private }
Cupboard class >> reset [
	<script>
	
	soleInstance := nil.
	 
]

{ #category : #accessing }
Cupboard class >> soleInstance [
	<script: 'self soleInstance inspect'>
	
	^ soleInstance ifNil: [ soleInstance := self basicNew initialize ]
]

{ #category : #'private - icons' }
Cupboard class >> teapotIcon [

	^ self icons
			at: #'teapotIcon'
			ifAbsentPut: [ Form fromBinaryStream: (Base64MimeConverter mimeDecodeToBytes: self teapotIconContents readStream) ].
]

{ #category : #'private - icons' }
Cupboard class >> teapotIconContents [

	^'iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAABhklEQVR42rWSPSxDURTHzzmv
r8TyRBP00Y1BQiwiRD+YkKiPyWqTSDAZjUaj2SyS0lbEpNWPRCTEYBeNKrv4qN57nFYiPoqX
NM7Nzcs799zf/Z//vQg1Bv4rIO4LdDCgF5FPwrn0s2PAdmsf1RkNvbK6KbMLGGaR4SCcTz19
A0S8A3NkGo/TuexWORG1A/2MvE9EHuQ3PsuQeFFcWjXQtaEVjpHBzZLexj07cK4Je1jTKBn6
khmzCNzyJo7h41dAD8z6FJEs+TuT1hijdnAICdJS8ShFRSlv/Ms4Zp6ZzKd2Y75gBqM+v9Do
Chgt587zsrtObRSLdFFpMm4Hk0AQcgpw89N6CdyHCnGtAthp93e6gI6l0yZ08DTEi1NibSmC
pffqeFvILF+C3MD47/LFK8Y9MNRiOJe5+3RczDviYXpJisvdP+wXo2FCVCbC10dc9SHF7eF6
QD2vUC8Qkkf0uiT9wFon5OSVqUL65oui6hGxBy3TMMsAU+Y9Ki5M3KZ1lZZqi5oBr2z5j75R
N5raAAAAAElFTkSuQmCC'
]

{ #category : #'private - icons' }
Cupboard class >> teapotServerIcon [

	^ self icons
			at: #'teapotServerIcon'
			ifAbsentPut: [ Form fromBinaryStream: (Base64MimeConverter mimeDecodeToBytes: self teapotServerIconContents readStream) ].
]

{ #category : #'private - icons' }
Cupboard class >> teapotServerIconContents [

	^'iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAC0UlEQVR4Xo2SbU+SURzG+RS2
hDdufQBtM0e58GHa8o2W3mbWkjbLhzURTTNEHnwowNKG2oM6JUWF2+fHTJ2aJaFCPlAzJygG
OMPM8qF8wqtbXli2rK7t2v7n7Fy/c8520fbk4nKEkZkpIUViKckXSEj9qBEjehNG3kxDILxL
enoyCVdXVwbtMHl7s4hJ4ypsi1uUHbDad2Fz2kGtd2G2bWBIZ0Jz6wvLHtDL69RBIIvlS2hG
FqEbW4FhcgWmuU0YzduYNu9QswOmDw7MWhwUaAe2Tw7M29dxIyGV3Af4+voR3X1mDAwuoLd/
Hl09c9Q8D/34MgVcxYz1O+yft2Ff3sTYWxvKK/oRxU44CGhpe4/Orlm0tk+joWkS6toJ1KhH
oax5jdLyPsgLn0GUrUZMnBTnw64jPj7lIEBNjqK+8R1U5DiU1XqUP9WitGwQfEEJMgRS5D8o
hrJKjampKQhF9+HjG8j9BeBPlCk0qFDqUKbQ4knJSzwsom6Vd1N/lcJgMGBraxvf1jfw5es6
4mJvwfMEk9gHBAaeIeQFXXhcPIDCwl7k5z9HrqwDUkkL2Ox0aLXDWFvbwsLCMmZm7QgJYeNs
UNBPgLu7B1MirUdeXidk0nbkZDdBLKqjXIuIiBS0tXXBal2C0bSEVxoTgoOjQGfQD/YiLU1M
ioQqZ1AoUEOQoYZISCI8PBnVNc2YMFiocpnR1jEM9lUO/lioa9FJZDqvygnYsxNwIQmKikYq
bMGAZgbquh4kcsU4tJUyWYklg6/aBxDhXBQ9UkE3/hGDQzNIThUg5BxbcyjgKFVRHk9uEWSo
nIAwgoukm3eo0CW4uR1DQEAktRdN0v4md4/jTA4n17L3ipjYe2D5ROK0z0VcTuSBL6zElajY
PNq/5OcfQGRlKZHAKaLal4/bPAXkBa3IypZr6HQ6g/Y/8vI6SVRW9qChUYPsnCJNaGgE9/cz
PwCyhvLlWzqQAwAAAABJRU5ErkJggg=='
]

{ #category : #'private - icons' }
Cupboard class >> teapotServerStartIcon [

	^ self icons
			at: #'teapotServerStartIcon'
			ifAbsentPut: [ Form fromBinaryStream: (Base64MimeConverter mimeDecodeToBytes: self teapotServerStartIconContents readStream) ].
]

{ #category : #'private - icons' }
Cupboard class >> teapotServerStartIconContents [

	^'iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAADR0lEQVR4Xn2T71fTZRyG+S80
4RV56k3Hc6jciTpHICnNOnVYfCWhCZiiCAxGlEbbhCg2TjQdIYlCwWIIU0crDhAiiOA8xL6B
4kFqG7+22QYRHCL5Nbia7ByOnNPpc859zvPmup7nOef+hDw5JzOydQWfaU0qtdYkDjro/9VJ
v2in8lKdVaMtNUkkksiQ/xtr3ygu3yqe6TU8U4+zHjgHM/FwmT5xFMtP3S71GY1JocjT7dgR
GrZF0NH1O+LdBe7en8c+tohzfBXHmB/HhB/n5BpjrkA8fh4GLnB7/0aRm2/aImhpG6LH6qOz
20N7xwQ3ezzYBv/i3vBCAF7CN7PK1NwyA0Muqr69wcmMj7cKmiw22q6P09xip8nyANPVIeob
Bqhv/IXq7zopK2+l4PNG0k5oiBfSSUxM1W0RNDRaMf8wTOOVe9TVi9QY+rhY1UthkQGlUsPZ
c5UYjSbsdgenPikmIkIibMK7JS9G5p0vIfF8Dqll+ZRUmKmouIlef52c3HOINhsrKys8+meZ
2dkFUlKziY19LSiQ7JUIh5vep2SgmNbJFgy/1XC09SgHNXI0xRbSjmvo6uxiIQB7vbPYHX8g
laYSFxcnhGx7altYglmgxl5Ns+tHFlcfMTI3TJ2zluzeLA4pPyLlSCENDddwu2dwOP+kq/tB
4P/pbNwe/UGU7thtGbXOSuaX51hfX9+IdfoW+pESdpdHkpx6hksXjQzdn6TfNo7Z0kumXBUU
PK/YZZKLR5ha9G7Cj+Nf82NxX+E5YziyFCXlFbXYRDc9t0epu9yCUlUaFLycJzEliq9TMfkF
7TPmALyGb9nDhUkN6hE5uy4/TVLyp3xZWoU46KM30FZ5zile3SsNdkCaJdW9eecF0u1vUT+t
3xC4lhx86BQ4OPgKMd/EIktWkZmlJu5dGeHhO9m3T4bscEZQEBoWGpbbeZwi1zF+nq8LvmBl
gq+8uSTciiFNpSUzs4zomCT2RL9HUk4+6oLv2f/GO4rNDhx4+4CQcTXFVTRygralKmqnNMit
hyisLrBqtUYUiguB9p3ldH4N+q+bAxU+bfrPbYzaHyVsj9guPBv5jCB5Kbi6UXtiBIOhnWvm
O3TcsBEfn6B4kvkXxV9YN+ClYBQAAAAASUVORK5CYII='
]

{ #category : #'private - icons' }
Cupboard class >> teapotServerStopIcon [

	^ self icons
			at: #'teapotServerStopIcon'
			ifAbsentPut: [ Form fromBinaryStream: (Base64MimeConverter mimeDecodeToBytes: self teapotServerStopIconContents readStream) ].
]

{ #category : #'private - icons' }
Cupboard class >> teapotServerStopIconContents [

	^'iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAADO0lEQVR4Xn2T7U+TVxiH+xds
Gfso0Q+Gbh+UBYFEsjeSzS6yKWDWdKyMurEXytDyVsfcKHRtFKdWRFyljxoiVbEoq3vxPVM2
qKwd5XXZYK30BYotuEXWQaSUa8/GdDZLdidX7i/nvk7OOb8jebhK399uqtfvsdXqGmx9A15c
bi9Ot4cWi9VRUrLNtGnTZrnk/6q710swHCM0vchkeInJyH3iTIQX+WHAj6vPw8e1u2ylpRrT
unXpWQmCq9+M4h6KMjByl7HxOby+RTzjcbx+kcAStwJxxicWRVmc8K/3uHSlhwTB1xeH+c4R
4XpXiCvXAlz/Nige4w6DI7/j8c8zNR1j5m6MUe805+xOzC32REGn3cXlq36+uuDh8/M/Yzs7
zKn2fto7XAitN2g+chljQwea8kMoCspQKsscCYJT7T102n/iTMcQJ0+7aT3hRDjWw8HmC2zb
vpP9piMcP96G0+nCaj1NXv5W24PhZLGExjO06Fux7LdjOdrNZ+YbHGy6hmFXO21tVhYWYszP
32N2do69ew/xVrFmWaDKzatoK1IFbxoM/GhpoddoxKpS0/CBwO7dX1Dz4TGaD5uZm1sgEpkl
EJihvEJHdfVHNsnG7Gz5RaUSryA84NY/vXOLAl25mR07BOrqDExMzuAL/IZ78DbKwjLS0jLl
EqtCERyqqmasvp5fHmJUZKSmhk8zXxJ3sqDV1jI8EqSv3ye+zCQvv1LIixtkcok9dS1Rv49Y
NCryR0JfiM5yMvNpqkSBpnwn/YMhurq99Nz0kpPzOiuSVyRLvpRKmQuFiC/F/0s8ztn09VRW
mSlRa+l1BcWQ3WHPvhaKVGXLGegqKGAsO5tg7mZuFxYSURUxVfgGvtw8RmUyhLTnqKg0o3jt
Xd4s1iBNeZL1WTL0emFZ8Iw0Rf79Y0kEVq4kLBJZtYopsY+LOB55FJ2qXrwDgRc2bOXZ5xW8
qq5AU3kYXd2Bf0O0JUVaMZiRQTQ3l/miImbz8xlIz0AoUTuamjqo1gq8856JKu1R9h04T2Oj
NZia+lTiR0p9Qppl3JhjM65ZYzPIZLa1q1f/vSAp6fHkE9ZLdJzrRv9Jk6P4bbXpr9Ddn/sT
U0VgFvyaFxkAAAAASUVORK5CYII='
]

{ #category : #inspecting }
Cupboard >> gtInspectorTeapotsIn: composite [
	<gtInspectorPresentationOrder: 0>  
	
	^(composite list)
		title: 'Teapots';
		icon: [:each | self class teapotServerIcon ];
		display: [ self teapots ]; 
		format: [:each | self nameForTeapot: each ];
		selectionAct:  [:each | each selection ifNotNil: [ each selection start ]. each update ] icon: self class teapotServerStartIcon entitled: 'Start';
		selectionAct: [:each | each selection ifNotNil: [ each selection stop ]. each update ] icon: self class teapotServerStopIcon entitled: 'Stop';
		act: [:each | self onNewServer. each update ] icon: self class teapotServerIcon entitled: 'New Teapot'
		
]

{ #category : #private }
Cupboard >> nameForTeapot: aTeapot [
	^String streamContents: [:stream |
		stream nextPutAll: aTeapot server port asString.
		stream nextPutAll: ' - '.
		stream nextPutAll: (aTeapot server isRunning ifTrue: [ 'running' ] ifFalse: [ 'stopped' ]) ].

]

{ #category : #actions }
Cupboard >> onNewServer [
	|port directory pot |
	port := UIManager default request: 'New server' initialAnswer: '80'.
	port ifNil: [ ^self ].
	directory := UIManager default chooseDirectory: 'Serve directory'.
	directory ifNil: [ ^self ].
	pot := Teapot configure: { 
		#port -> port asNumber
	}.
	pot serveStatic: '/' from: directory.
	pot start
	
		

]

{ #category : #printing }
Cupboard >> printOn: aStream [

	aStream nextPutAll: 'Cupboard'
]

{ #category : #accessing }
Cupboard >> teapots [

	^Teapot allInstances
]
