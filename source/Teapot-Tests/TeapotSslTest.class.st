Class {
	#name : #TeapotSslTest,
	#superclass : #TestCase,
	#instVars : [
		'teapot'
	],
	#category : #'Teapot-Tests'
}

{ #category : #initialization }
TeapotSslTest >> setUp [
	teapot := Teapot configure: { 
		#znServerClass -> (
			(ZnSecureServer on: 1443) 
				certificate: '~/key.pem'; "TODO"
				logToTranscript; 
				yourself).
		#port -> 1443.
	}.
	teapot
		GET: '/ssl' -> 'secure';
		start.
]

{ #category : #running }
TeapotSslTest >> tearDown [
	teapot stop
]

{ #category : #tests }
TeapotSslTest >> testHttpsGet [
	self skip.
	"| result |
	result := ZnEasy get: 'https://localhost:1443/ssl'.
	self assert: result equals: 'secure'."
]
