Class {
	#name : #BaselineOfTeapot,
	#superclass : #BaselineOf,
	#category : #BaselineOfTeapot
}

{ #category : #baselines }
BaselineOfTeapot >> baseline: spec [

	<baseline>
	spec for: #common do: [
		self setUpDependencies: spec.

		spec
			package: 'Teapot-Core' with: [ spec requires: #( 'NeoJSON' ) ];
			package: 'Teapot-Tools' with: [ spec requires: 'Teapot-Core' ].
		spec
			for: #( #'pharo7.x' #'pharo8.x' #'pharo9.x' )
			do: [ spec package: 'Teapot-Tests' with: [ spec requires: 'Teapot-Core' ] ].

		spec
			for: #( #'pharo10.x' #'pharo11.x' #'pharo12.x' )
			do: [ spec package: 'Teapot-Tests' with: [ spec requires: #( 'Teapot-Core' 'Zinc-Zodiac' ) ] ].

		spec
			group: 'Tests' with: #( 'Teapot-Tests' );
			group: 'Tools' with: #( 'Teapot-Tools' );
			group: 'Deployment' with: #( 'Teapot-Core' );
			group: 'Development' with: #( 'Tests' 'Tools' );
			group: 'default' with: 'Development'
		]
]

{ #category : #baselines }
BaselineOfTeapot >> setUpDependencies: spec [

	spec
		baseline: 'NeoJSON' with: [
			spec
				repository: 'github://svenvc/NeoJSON';
				loads: #( 'core' )
			];
		baseline: 'ZincHTTPComponents' with: [ spec repository: 'github://svenvc/zinc' ];
		project: 'Zinc-Zodiac' copyFrom: 'Zinc' with: [ spec loads: 'Zinc-Zodiac-Core' ]
]
