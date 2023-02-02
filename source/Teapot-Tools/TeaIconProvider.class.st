"
An icon provider for tools icons with an icon cache
"
Class {
	#name : #TeaIconProvider,
	#superclass : #Object,
	#classVars : [
		'IconCache'
	],
	#category : #'Teapot-Tools-Utilities'
}

{ #category : #'private - icons' }
TeaIconProvider class >> form: base64String [
	^ Form fromBinaryStream: (base64String base64Decoded asByteArray readStream)
]

{ #category : #accessing }
TeaIconProvider class >> icons [

	IconCache ifNil: [ IconCache := Dictionary new ].
	^IconCache
]

{ #category : #icons }
TeaIconProvider class >> teapotIcon [

	^ self icons
			at: #'teapotIcon'
			ifAbsentPut: [ self form: self teapotIconContents ]
]

{ #category : #'private - icons' }
TeaIconProvider class >> teapotIconContents [

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

{ #category : #icons }
TeaIconProvider class >> teapotInspectIcon [

	^ self iconNamed: #'glamorousInspect'
]

{ #category : #icons }
TeaIconProvider class >> teapotServerIcon [

	^ self icons
			at: #'teapotServerIcon'
			ifAbsentPut: [ self form: self teapotServerIconContents ]
]

{ #category : #'private - icons' }
TeaIconProvider class >> teapotServerIconContents [

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

{ #category : #icons }
TeaIconProvider class >> teapotServerStartIcon [

	^ self icons
			at: #'teapotServerStartIcon'
			ifAbsentPut: [ self form: self teapotServerStartIconContents ]
]

{ #category : #'private - icons' }
TeaIconProvider class >> teapotServerStartIconContents [

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

{ #category : #icons }
TeaIconProvider class >> teapotServerStaticIcon [

	^ self icons
			at: #'teapotServerStaticIcon'
			ifAbsentPut: [ self form: self teapotServerStaticIconContents ]
]

{ #category : #'private - icons' }
TeaIconProvider class >> teapotServerStaticIconContents [

	^'iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAADIElEQVR42l2Ta0gUURTH/1fH
WVNz2dLNIinQ0shAKCsSixIp7EMQ7VKbH8SICopo6UFaiBqZBm5R1Bc1i7ZwJw1DlzbQfKTr
9rA+aGX2MFbbNsu21Np259Gdcczwwsw5c+85vzn/e+8hoCM0NHThjh07KySJQBAl5BcUGUSR
AEREWWkh19Ls4H788DkFQRjCjEHkV0xMrKGj+70tWquRcZBBygIkGkEQDATg9Qyjr/f5kL2p
3vmw5QHn831XgEpcbKze0GDvs7FhGmgoIyJCQyEhNJ0ghBDlNyGyCZEQpqFw0Y+8XBN3395g
VAB6vd5grX1s07Dh4IMieD6I8FlhiIyaBZZlEDmbQVQEo0j6NPwVz3sGcL26nGtttU8DKqvb
bSyrQTDIq08QoijQPfHD7/fj14Qfo76f8AwPYmTkHSbGPnMOx71pwKXLDhsTxirJPD8JoBox
OPiSKhjFnDk6KlWLtFWpuHW7EdVVl8xu96BFBcwznCu/a2MYdjo5QEECjzdve7BvbzaSkpKp
PAEBXsDJE8WotVUaR0e/cQogLi7OkF9ww8Zq6B4EJgFysCjyePXahf37tyElJRXj4xP49TsI
85HjcLkcRo/Hw5HVaQlRSUv0pdu3rj/IIAj30E/09Osxf8EKMAxDAY+Rk5OF1NSV8P8BPnt9
OF9WjMamm/ECT48xL3fzoePmLSW6CEYLegISL6HD9RFdL3jodDqMfHEjOTke0XOTkLw8HV7v
F9zhrKi5dlGpnpwpybHmH0s3EZ5+C/Tq8HRSkFQ7OQfqV9S+QtrGw/B8eg9nZycuWApVQNFu
a8HRDJMcJKnBRJj0CfX/Abh+rM06hPq6Gjx1PXO2tTWtUwAlhbsoYINJDpbUBKLCiJoszx04
WwfHow9ITFyNsXEv1+1sNiqA4tNG6ynzRhNouUSYgkhqJdMS9pzhEIhbg8XaZXDYr1qePOky
K4CiUwbr6SOZJjJTgmqnAEevtGJRym709j50VlVeNE51Jtm0IcWcmbE0WxLpCdBWlgQRoFdY
9sfG/PqYeQkr5IZqfzrg7n/nsQwM9Fv+b+e/lwaeIIipiHQAAAAASUVORK5CYII='
]

{ #category : #icons }
TeaIconProvider class >> teapotServerStopIcon [

	^ self icons
			at: #'teapotServerStopIcon'
			ifAbsentPut: [ self form: self teapotServerStopIconContents ]
]

{ #category : #'private - icons' }
TeaIconProvider class >> teapotServerStopIconContents [

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

{ #category : #icons }
TeaIconProvider class >> teaspoonIcon [

	^ self icons
			at: #'teaspoonIcon'
			ifAbsentPut: [ self form: (self teaspoonIconContents) ]
]

{ #category : #'private - icons' }
TeaIconProvider class >> teaspoonIconContents [

	^'iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAABdklEQVR42mNkoBAwgoiJs6fL
vHv/oe/d27cM6urqTxQVFfq8HV2fEG1AQ1f7qlevX4XCBDk5OBnExcWLynLy+4kyIK+idNWf
v39C0SUNDQz7U6PjiggaMG3+3L4r164UokvycPMwdDU0MxI0YNfhgzK7du96/O37NwwFCfEJ
YWY6+qvxGgACPdMmF967f68PXYG8nHxYeW4BYQNAYM6yxX23bt0q/PL1C1xMVFRsdWNZZRhR
BsDA8YtnQw8ePMTw8+fP0JevXoby8vCu7qxvCiPaAGRQ2dyw6uOnj6FArzzR09Oz9LR3ekKS
ASDQNWXi4wcPH8hwc3E/YefgsGyprHlCkgGgWNqzd89xYNjIMDMxP2FkZLSc1NH9hGgDQKCu
o1Xm/fv3x//++yvDyMD4hIWV1XJiW+cTog0AAWCKlfn79+/x/wz/ZZiZmZ+oKCtbkmQACORX
lcv8//fvODDpy0hJSh0n2QAQmDx3lsynT59W/fnz5wkA2dSUkQj2i7UAAAAASUVORK5CYII='
]
