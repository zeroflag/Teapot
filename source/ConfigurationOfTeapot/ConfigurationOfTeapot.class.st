"
Configuration for Teapot micro web framework.

See http://smalltalkhub.com/#!/~zeroflag/Teapot
"
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

{ #category : #catalog }
ConfigurationOfTeapot class >> catalogChangeLog [
	"Returns a paragraph describing the most important changes in the configuration class."
	^ ' '
]

{ #category : #catalog }
ConfigurationOfTeapot class >> catalogContactInfo [
	"Returns a paragraph describing contact information such as email, mailing lists and website."
	^ 'Contact the authors on the Pharo developer list (http://lists.pharo.org)'
]

{ #category : #catalog }
ConfigurationOfTeapot class >> catalogDescription [
	"Returns a paragraph describing the project"
	^ 'Teapot is micro web framework on top of the Zinc HTTP components, that focuses on simplicity and ease of use.'
]

{ #category : #catalog }
ConfigurationOfTeapot class >> catalogKeyClassesAndExample [
	"Returns a paragraph or more describing the key classes of your project. You can use Pillar/Pier syntax to layout out the text i.e., ==Code== and - for bullet."
	^ 'Checkout the class ==Teapot=='
]

{ #category : #catalog }
ConfigurationOfTeapot class >> catalogKeywords [
	"Returns an array of symbols"
	^ #(micro web framework http sinatra) 
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

{ #category : #baselines }
ConfigurationOfTeapot >> baseline20: spec [
	<version: '2.0-baseline'>

	spec for: #'common' do: [
		spec blessing: #'baseline'.
		spec repository: 'http://smalltalkhub.com/mc/zeroflag/Teapot/main/'.
		spec project: 'NeoJSON' with: [
				spec
					className: #ConfigurationOfNeoJSON;
					versionString: #'stable';
					repository: 'http://mc.stfx.eu/Neo' ].
				
		spec 
			package: 'Teapot-Core' with: [
				spec requires: #('NeoJSON' ). ];
			package: 'Teapot-Tools' with: [
				spec requires: #('Teapot-Core' ). ];
			package: 'Teapot-Tests' with: [
				spec requires: #('Teapot-Core' ). ].
		spec 
			group: 'Core' with: #('Teapot-Core' );
			group: 'Tools' with: #('Teapot-Tools' );
			group: 'Tests' with: #('Teapot-Tests' );
			group: 'default' with: #('Tools' 'Tests' ). ].

]

{ #category : #baselines }
ConfigurationOfTeapot >> baseline21: spec [
	<version: '2.1-baseline'>

	spec for: #'common' do: [
		spec blessing: #'baseline'.
		spec repository: 'http://smalltalkhub.com/mc/zeroflag/Teapot/main/'.
		spec project: 'NeoJSON' with: [
				spec
					className: #ConfigurationOfNeoJSON;
					versionString: #'stable';
					repository: 'http://mc.stfx.eu/Neo' ].
				
		spec 
			package: 'Teapot-Core' with: [
				spec requires: #('NeoJSON' ). ];
			package: 'Teapot-Tools' with: [
				spec requires: #('Teapot-Core' ). ];
			package: 'Teapot-Tests' with: [
				spec requires: #('Teapot-Core' ). ].
		spec 
			group: 'Core' with: #('Teapot-Core' );
			group: 'Tools' with: #('Teapot-Tools' );
			group: 'Tests' with: #('Teapot-Tests' );
			group: 'default' with: #('Tools' 'Tests' ). ].

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

	spec for: #'common' version: '2.1-baseline'.

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

	spec for: #'common' version: '2.0'.

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
ConfigurationOfTeapot >> version091: spec [
	<version: '0.91' imports: #('0.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 0.91'.
		spec author: 'AttilaMagyar'.
		spec timestamp: '5/9/2015 18:18'.
		spec package: 'Teapot-Core' with: 'Teapot-Core-AttilaMagyar.76'. ].

]

{ #category : #versions }
ConfigurationOfTeapot >> version09: spec [
	<version: '0.9' imports: #('0.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 0.9'.
		spec author: 'AttilaMagyar'.
		spec timestamp: '1/3/2015 20:01'.
		spec package: 'Teapot-Core' with: 'Teapot-Core-AttilaMagyar.69'. ].

]

{ #category : #versions }
ConfigurationOfTeapot >> version20: spec [
	<version: '2.0' imports: #('2.0-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'development'.
		spec description: 'version 2.0'.
		spec author: 'TorstenBergmann'.
		spec timestamp: '10/12/2015 13:11'.
		spec project: 'NeoJSON' with: #'stable'.
		spec 
			package: 'Teapot-Core' with: 'Teapot-Core-AttilaMagyar.76';
			package: 'Teapot-Tools' with: 'Teapot-Tools-TorstenBergmann.3';
			package: 'Teapot-Tests' with: 'Teapot-Tests-AttilaMagyar.53'. ].

]
