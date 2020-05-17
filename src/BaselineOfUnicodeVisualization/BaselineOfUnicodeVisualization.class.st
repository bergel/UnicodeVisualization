Class {
	#name : #BaselineOfUnicodeVisualization,
	#superclass : #BaselineOf,
	#category : #BaselineOfUnicodeVisualization
}

{ #category : #baselines }
BaselineOfUnicodeVisualization >> baseline: spec [     
	<baseline>

	spec for: #common do: [

		"Load morphic before Spec"
		spec baseline: 'Roassal3' with: [ spec repository: 'github://ObjectProfile/Roassal3/src' ].
		spec baseline: 'Unicode' with: [ spec repository: 'github://pharo-contributions/pharo-unicode/src' ].
		spec package: 'UnicodeVisualization'.
		
		spec 
			group: 'default' with: #('Roassal3' 'Unicode' 'UnicodeVisualization')
	].
]
