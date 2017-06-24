Class {
	#name : #TeapotSslTest,
	#superclass : #TestCase,
	#instVars : [
		'server'
	],
	#category : #'Teapot-Tests'
}

{ #category : #initialization }
TeapotSslTest >> setUp [
	server := Teapot configure: { #znServerClass -> ZnSecureServer . #port -> 1443 }.
	server
		GET: '/ssl' -> 'secure';
		start.
]

{ #category : #running }
TeapotSslTest >> tearDown [
	server stop
]

{ #category : #tests }
TeapotSslTest >> testHttpsGet [
	| result |
	self flag: 'peding'; skip.
	"result := ZnEasy get: 'http://localhost:1443/ssl'.
	self assert: result equals: 'secure'."
]
