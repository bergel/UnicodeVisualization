Class {
	#name : #UnicodeEvolution,
	#superclass : #Object,
	#instVars : [
		'chars',
		'allVersions',
		'charsNotNil'
	],
	#category : #'UnicodeVisualization-Evolution'
}

{ #category : #private }
UnicodeEvolution >> allVersions [

	^ allVersions sortedAs: [ :s | (s substrings: '.') first asInteger ]
]

{ #category : #accessing }
UnicodeEvolution >> chars [
	^ chars select: #notNil
]

{ #category : #accessing }
UnicodeEvolution >> charsNotNil [
	charsNotNil ifNotNil: [ ^ charsNotNil ].
	charsNotNil := chars select: #notNil.
	^ charsNotNil
]

{ #category : #'as yet unclassified' }
UnicodeEvolution >> computeDifferences [
	| evolutionDifferences version1 d |
	evolutionDifferences := OrderedCollection new.
	
	version1 := self allVersions first.
	self allVersions allButFirst do: [ :version2 |
		d := UnicodeEvolutionDifference new.
		d version1: version1 version2: version2.
		d removedChars: (self chars select: [ :c | (c isInVersion: version1) and: [ (c isInVersion: version2) not ] ]) .
		d addedChars: (self chars select: [ :c | (c isInVersion: version1) not and: [ (c isInVersion: version2) ] ]) .
		evolutionDifferences add: d.
		version1 := version2.
	].	
	^ evolutionDifferences
]

{ #category : #private }
UnicodeEvolution >> gtInspectorDifferenceEvolutionIn: composite [
	<gtInspectorPresentationOrder: -10>
	composite roassal3
		title: 'DiffEvo';
		initializeCanvas: [ self visualizeDifferenceOfEvolution ]
]

{ #category : #private }
UnicodeEvolution >> gtInspectorEvolutionIn: composite [
	<gtInspectorPresentationOrder: -10>
	composite roassal3
		title: 'Evolution';
		initializeCanvas: [ self visualizeEvolution ]
]

{ #category : #initialization }
UnicodeEvolution >> initialize [
	super initialize.
	chars := Array new: 16r10FFFF.
	allVersions := OrderedCollection new
]

{ #category : #'as yet unclassified' }
UnicodeEvolution >> numberOfChars [
	^ (chars select: #notNil) size
]

{ #category : #private }
UnicodeEvolution >> process: aFileName [
	self process: aFileName as: aFileName asFileReference basename
]

{ #category : #private }
UnicodeEvolution >> process: aFileName as: versionName [
	| ss index c |
	"We register the version name"
	allVersions add: versionName.
	
	(aFileName asFileReference contents lines reject: #isEmpty) do: [ :l |
		ss := l substrings: ';'.
		index := Integer readFrom: ss first base: 16.
		(chars at: index + 1)
			ifNil: [
				c := UnicodeChar new.
				c code: ss first.
				c index: index.
				c name: ss second.
				chars at: index + 1 put: c ]
			ifNotNil: [ 
				c := chars at: index + 1.
				self assert: [ c code = ss first ].
				self assert: [ c index = index ].
				"self assert: [ c name = ss second ]."
				 ].
		c addVersion: versionName
			
	]
]

{ #category : #private }
UnicodeEvolution >> run [
	<script: 'self new run inspect'>
	
	| folder |
	folder := '/Users/alexandrebergel/Desktop/UnicodeData'.
	folder asFileReference children do: [ :version |
		self process: version absolutePath.
	]
	
]

{ #category : #versions }
UnicodeEvolution >> version12 [
	^ '/Users/alexandrebergel/Dropbox/GitRepos/UnicodeVisualization/data/www.unicode.org/Public/12.1.0/ucd/UnicodeData.txt'
]

{ #category : #versions }
UnicodeEvolution >> version13 [
	^ '/Users/alexandrebergel/Dropbox/GitRepos/UnicodeVisualization/data/www.unicode.org/Public/13.0.0/ucd/UnicodeData.txt'
]

{ #category : #versions }
UnicodeEvolution >> version14 [
	^ '/Users/alexandrebergel/Dropbox/GitRepos/UnicodeVisualization/data/www.unicode.org/Public/14.0.0/ucd/UnicodeData-14.0.0d1.txt'
]

{ #category : #private }
UnicodeEvolution >> visualizeDifferenceOfEvolution [

	| data c d |
	data := self computeDifferences.
	c := RSChart new.

	d := RSBarPlot new.
	d color: Color green darker darker darker.
	d y: (data collect: #numberOfAddedChars).
	c addPlot: d.

	d := RSBarPlot new.
	d color: Color red darker darker darker.
	d y: (data collect: #numberOfRemovedChars) negated.
	c addPlot: d.

	c addDecoration: (RSVerticalTick new integer).
	c addDecoration: (RSHorizontalTick new).
	c addDecoration: (RSYLabelDecoration new title: 'Difference of characters'; rotationAngle: -90; offset: -25 @ 0).
	c addDecoration: (RSXLabelDecoration new title: 'Evolution difference').
	c build.
	^ c canvas

]

{ #category : #private }
UnicodeEvolution >> visualizeEvolution [

	| c data d |
	
	data := OrderedCollection new.
	self allVersions do: [ :v | 
		data add: (self charsNotNil select: [ :ch | ch isInVersion: v ]) size
	].
	
	c := RSChart new.
	d := RSLinePlot new.
	d x: (1 to: self allVersions size) y: data.
	c addPlot: d.
	c mustInclude0inY.
	c addDecoration: (RSHorizontalTick new doNotUseNiceLabel; numberOfTicks: self allVersions size; withNoLabels).
	c addDecoration: (RSVerticalTick new).
	c xlabel: 'Unicode version'.
	c addDecoration: (RSYLabelDecoration new title: 'Number of Characters'; rotationAngle: -90; offset: -30 @ 0).
	c title: 'Evolution of the Unicode standard'.
	c build.
	^ c canvas
]
