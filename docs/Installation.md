# Installation

## Basic Installation

You can load **Teapot** evaluating:
```smalltalk
Metacello new
	baseline: 'Teapot';
	repository: 'github://zeroflag/teapot:master/source';
	load.
```
>  Change `master` to some released version if you want a pinned version

## Using as dependency

In order to include **Teapot** as part of your project, you should reference the package in your product baseline:

```smalltalk
setUpDependencies: spec

	spec
		baseline: 'Teapot'
			with: [ spec
				repository: 'github://zeroflag/Teapot:v{XX}/source';
				loads: #('Deployment') ];
		import: 'Stargate'.
```
> Replace `{XX}` with the version you want to depend on

```smalltalk
baseline: spec

	<baseline>
	spec
		for: #common
		do: [ self setUpDependencies: spec.
			spec package: 'My-Package' with: [ spec requires: #('Teapot') ] ]
```

## For Pharo 5 and previous

If you are using a Pharo older version see [Smalltalkhub](http://smalltalkhub.com/#!/~zeroflag/Teapot) 
