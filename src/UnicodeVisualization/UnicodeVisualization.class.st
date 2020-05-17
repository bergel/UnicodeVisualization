Class {
	#name : #UnicodeVisualization,
	#superclass : #Object,
	#instVars : [
		'colorMapping',
		'colorOfBlock',
		'r'
	],
	#category : #UnicodeVisualization
}

{ #category : #'as yet unclassified' }
UnicodeVisualization >> colorOf: aValue [
	| key |
	key := (colorOfBlock rsValue: aValue) asString.

	(colorMapping includesKey: key)
		ifTrue: [ ^ colorMapping at: key ].
		
	 colorMapping at: key put: (Color r: r next g: r next b: r next).
	^ colorMapping at: key
]

{ #category : #accessing }
UnicodeVisualization >> colorOfBlock [
	^ colorOfBlock
]

{ #category : #accessing }
UnicodeVisualization >> colorOfBlock: oneArgBlock [
	colorOfBlock := oneArgBlock
]

{ #category : #'as yet unclassified' }
UnicodeVisualization >> createFormForValues: someValues [
	| size form x y |
	self assert: [ someValues size sqrt isInteger ].
	size := someValues size sqrt.
	form := Form extent: size @ size depth: 32.
	form fill: (1 @ 1 extent: size @ size) rule: Form over fillColor: Color black.

	x := 0.
	y := 0.
	
	someValues doWithIndex: [ :v :i |
		form colorAt: (x @ y) put: (self colorOf: v).
		x := x + 1.
		size = x ifTrue: [ x := 0. y := y + 1 ].
	].
	^ form
]

{ #category : #'instance creation' }
UnicodeVisualization >> gtInspectorViewIn: composite [
	<gtInspectorPresentationOrder: -10>
	composite roassal3
		title: 'View';
		initializeCanvas: [ self visualize ]
]

{ #category : #initialization }
UnicodeVisualization >> initialize [
	super initialize.
	colorMapping := Dictionary new.
	r := Random seed: 42.
]

{ #category : #'instance creation' }
UnicodeVisualization >> open [
	<script: 'self new open inspect'>

]

{ #category : #'instance creation' }
UnicodeVisualization >> visualize [
	
	| numberOfCharacters values f canvas blockSize |
	self colorOfBlock: [ :c | 
		c ifNil: [ nil ]
			ifNotNil: [ c name substrings first ] ].

	canvas := RSCanvas new.
	
	numberOfCharacters := 256 * 256.
	blockSize := 256.
	(1 to: numberOfCharacters by: blockSize) do: [ :charIndex |
		values := (charIndex to: charIndex + blockSize - 1) collect: [ :i |
			[ i unicodeCharacterData ] on: KeyNotFound do: [ :ex | nil ] ].
		f := self createFormForValues: values.
		canvas add: (RSBitmap new form: f; model: values).
	].

	RSGridLayout new gapSize: 2; lineItemsCount: blockSize sqrt; on: canvas shapes.
	
	canvas @ RSCanvasController.
	^ canvas
]
