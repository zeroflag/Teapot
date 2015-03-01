Class {
	#name : #ConfigurationOfTeapot,
	#superclass : #Object,
	#instVars : [
		'project'
	],
	#classVars : [
		'LastVersionLoad'
	],
	#category : #ConfigurationOfTeapot
}

{ #category : #'development support' }
ConfigurationOfTeapot class >> DevelopmentSupport [

"See the methods in the 'development support' category on the class-side of MetacelloBaseConfiguration. Decide what development support methods you would like to use and copy them the the class-side of your configuration."
	<apiDocumentation>

]

{ #category : #private }
ConfigurationOfTeapot class >> baseConfigurationClassIfAbsent: aBlock [

	^Smalltalk
		at: #MetacelloBaseConfiguration
		ifAbsent: [ 
			self ensureMetacelloBaseConfiguration.
			Smalltalk at: #MetacelloBaseConfiguration ifAbsent: aBlock ].

]

{ #category : #private }
ConfigurationOfTeapot class >> ensureMetacello [

	(self baseConfigurationClassIfAbsent: []) ensureMetacello
]

{ #category : #private }
ConfigurationOfTeapot class >> ensureMetacelloBaseConfiguration [

	Smalltalk
		at: #MetacelloBaseConfiguration
		ifAbsent: [ 
			| repository version |
			repository := MCHttpRepository location: 'http://seaside.gemstone.com/ss/metacello' user: '' password: ''.
			repository
				versionReaderForFileNamed: 'Metacello-Base-DaleHenrichs.2.mcz'
				do: [ :reader | 
					version := reader version.
					version load.
					version workingCopy repositoryGroup addRepository: repository ] ]
]

{ #category : #'metacello tool support' }
ConfigurationOfTeapot class >> isMetacelloConfig [
	"Answer true and the Metacello tools will operate on you"
	
	^true
]

{ #category : #loading }
ConfigurationOfTeapot class >> load [
	"Load the #stable version defined for this platform. The #stable version is the version that is recommended to be used on this platform."

	"self load"

	<apiDocumentation>
	^(self project version: #stable) load
]

{ #category : #loading }
ConfigurationOfTeapot class >> loadBleedingEdge [
	"Load the latest versions of the mcz files defined for this project. It is not likely that the #bleedingEdge has been tested."

	"self loadBleedingEdge"

	<apiDocumentation>
	^(self project version: #bleedingEdge) load
]

{ #category : #loading }
ConfigurationOfTeapot class >> loadDevelopment [
	"Load the #development version defined for this platform. The #development version will change over time and is not expected to be stable."

	"self loadDevelopment"

	<apiDocumentation>
	^(self project version: #development) load
]

{ #category : #accessing }
ConfigurationOfTeapot class >> project [

	^self new project
]

{ #category : #'development support' }
ConfigurationOfTeapot class >> validate [
	"Check the configuration for Errors, Critical Warnings, and Warnings (see class comment for MetacelloMCVersionValidator for more information). 
	Errors identify specification issues that will result in unexpected behaviour when you load the configuration. 
	Critical Warnings identify specification issues that may result in unexpected behavior when you load the configuration.
	Warnings identify specification issues that are technically correct, but are worth take a look at."

	"self validate"

	<apiDocumentation>
	self ensureMetacello.
	^ ((Smalltalk at: #MetacelloToolBox) validateConfiguration: self debug: #() recurse: false) explore
]

{ #category : #baselines }
ConfigurationOfTeapot >> baseline01: spec [
	<version: '0.1-baseline'>

	spec for: #'common' do: [
		spec blessing: #'baseline'.
		spec repository: 'http://smalltalkhub.com/mc/zeroflag/Teapot/main/'.
		spec package: 'Teapot-Core'. ].

]

{ #category : #accessing }
ConfigurationOfTeapot >> customProjectAttributes [
	 "Edit to return a collection of any custom attributes e.g. for conditional loading: Array with: #'Condition1' with: #'Condition2.
	For more information see: http://code.google.com/p/metacello/wiki/CustomProjectAttrributes"

	^ #().
]

{ #category : #'symbolic versions' }
ConfigurationOfTeapot >> development: spec [
	<symbolicVersion: #'development'>

	spec for: #'common' version: '0.1-baseline'.

]

{ #category : #accessing }
ConfigurationOfTeapot >> project [

	^ project ifNil: [ 
		"Bootstrap Metacello if it is not already loaded"
		(self class baseConfigurationClassIfAbsent: []) ensureMetacello.
		"Construct Metacello project"
		project := MetacelloMCProject new projectAttributes: self customProjectAttributes. 
		(Smalltalk at: #MetacelloVersionConstructor) on: self project: project.
		project loadType: #linear. "change to #atomic if desired"
		project ]
]

{ #category : #'symbolic versions' }
ConfigurationOfTeapot >> stable: spec [
	<symbolicVersion: #'stable'>

	spec for: #'common' version: '0.9'.

]

{ #category : #versions }
ConfigurationOfTeapot >> version08: spec [
	<version: '0.8' imports: #('0.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 0.8'.
		spec author: 'AttilaMagyar'.
		spec timestamp: '8/24/2014 20:01'.
		spec package: 'Teapot-Core' with: 'Teapot-Core-AttilaMagyar.52'. ].

]

{ #category : #versions }
ConfigurationOfTeapot >> version09: spec [
	<version: '0.9' imports: #('0.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 0.9'.
		spec author: 'AttilaMagyar'.
		spec timestamp: '1/3/2015 20:01'.
		spec package: 'Teapot-Core' with: 'Teapot-Core-AttilaMagyar.68'. ].

]
