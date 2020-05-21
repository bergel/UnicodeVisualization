Class {
	#name : #UVSequenceVisualization,
	#superclass : #Object,
	#instVars : [
		'colorMapping',
		'colorOfBlock',
		'r',
		'blockSize',
		'numberOfElements',
		'elements',
		'magnifier'
	],
	#category : #UnicodeVisualization
}

{ #category : #accessing }
UVSequenceVisualization >> blockSize [
	^ blockSize
]

{ #category : #accessing }
UVSequenceVisualization >> blockSize: anObject [
	blockSize := anObject
]

{ #category : #'as yet unclassified' }
UVSequenceVisualization >> colorOf: aValue [
	| key |
	key := (colorOfBlock rsValue: aValue) asString.

	(colorMapping includesKey: key)
		ifTrue: [ ^ colorMapping at: key ].
		
	 colorMapping at: key put: (Color r: r next g: r next b: r next).
	^ colorMapping at: key
]

{ #category : #accessing }
UVSequenceVisualization >> colorOfBlock [
	^ colorOfBlock
]

{ #category : #accessing }
UVSequenceVisualization >> colorOfBlock: oneArgBlock [
	colorOfBlock := oneArgBlock
]

{ #category : #'as yet unclassified' }
UVSequenceVisualization >> createFormForValues: someValues [
	| size form x y realExtent |
	self assert: [ someValues size sqrt isInteger ].
	size := someValues size sqrt.
	realExtent := (size @ size) * magnifier.
	form := Form extent: realExtent depth: 32.
	form fill: (1 @ 1 extent: realExtent) rule: Form over fillColor: Color black.

	x := 0.
	y := 0.
	
	someValues doWithIndex: [ :v :i |
		0 to: magnifier - 1 do: [ :mx | 
			0 to: magnifier - 1 do: [ :my |
				form colorAt: (x @ y) * magnifier + (mx @ my) put: (self colorOf: v).
			]
		].
		x := x + 1.
		size = x ifTrue: [ x := 0. y := y + 1 ].
	].
	^ form
]

{ #category : #accessing }
UVSequenceVisualization >> elements [
	^ elements
]

{ #category : #accessing }
UVSequenceVisualization >> elements: anObject [
	elements := anObject
]

{ #category : #'instance creation' }
UVSequenceVisualization >> gtInspectorViewIn: composite [
	<gtInspectorPresentationOrder: -10>
	composite roassal3
		title: 'View';
		initializeCanvas: [ self visualize ]
]

{ #category : #initialization }
UVSequenceVisualization >> initialize [
	super initialize.
	colorMapping := Dictionary new.
	r := Random seed: 42.
	magnifier := 1
]

{ #category : #accessing }
UVSequenceVisualization >> magnifier [
	^ magnifier
]

{ #category : #accessing }
UVSequenceVisualization >> magnifier: anInteger [
	magnifier := anInteger
]

{ #category : #accessing }
UVSequenceVisualization >> numberOfElements [
	^ numberOfElements
]

{ #category : #accessing }
UVSequenceVisualization >> numberOfElements: anObject [
	numberOfElements := anObject
]

{ #category : #'instance creation' }
UVSequenceVisualization >> visualize [
	
	| values f canvas |

	canvas := RSCanvas new.
	
	(1 to: numberOfElements by: blockSize) do: [ :charIndex |
		values := (charIndex to: charIndex + blockSize - 1) collect: [ :i | elements at: i ].
		f := self createFormForValues: values.
		canvas add: (RSBitmap new form: f; model: values).
	].

	RSGridLayout new gapSize: 2; lineItemsCount: blockSize sqrt; on: canvas shapes.
	
	canvas @ RSCanvasController.
	^ canvas
]
