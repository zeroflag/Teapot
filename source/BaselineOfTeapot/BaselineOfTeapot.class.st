Class {
	#name : 'BaselineOfTeapot',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfTeapot',
	#package : 'BaselineOfTeapot'
}

{ #category : 'baselines' }
BaselineOfTeapot >> baseline: spec [

	<baseline>
	spec for: #common do: [
		self setUpDependencies: spec.

		spec
			package: 'Teapot-Core' with: [ spec requires: #( 'NeoJSON' ) ];
			package: 'Teapot-Tools' with: [ spec requires: 'Teapot-Core' ];
			package: 'Teapot-Tests' with: [ spec requires: 'Teapot-Core' ].

		spec
			group: 'Tests' with: #( 'Teapot-Tests' );
			group: 'Tools' with: #( 'Teapot-Tools' );
			group: 'Deployment' with: #( 'Teapot-Core' );
			group: 'Development' with: #( 'Tests' 'Tools' );
			group: 'default' with: 'Development'
		]
]

{ #category : 'baselines' }
BaselineOfTeapot >> pharoVersionsFrom: aVersion [
	"Method copied from BaselineOf to allow use of Pharo versions < 11"
	^ (aVersion to: SystemVersion current major) collect: [ :v | ('pharo' , v asString , '.x') asSymbol ]
]

{ #category : 'as yet unclassified' }
BaselineOfTeapot >> setUpDependencies: spec [

	spec
		baseline: 'NeoJSON' with: [
			spec
				repository: 'github://svenvc/NeoJSON';
				loads: #( 'core' )
		]
]
