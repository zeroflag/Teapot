"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestTeapotTools,
	#superclass : #PackageManifest,
	#category : #'Teapot-Tools-Manifest'
}

{ #category : #'code-critics' }
ManifestTeapotTools class >> ruleLongMethodsRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#Cupboard #inspectTeapot: #false)) #'2022-08-29T16:00:19.64012+02:00') )
]
