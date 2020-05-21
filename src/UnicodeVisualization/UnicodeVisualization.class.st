Class {
	#name : #UnicodeVisualization,
	#superclass : #Object,
	#category : #UnicodeVisualization
}

{ #category : #'instance creation' }
UnicodeVisualization >> open [
	<script: 'self new open inspect'>

	| sq |
	sq := UVSequenceVisualization new.
	sq colorOfBlock: [ :c | 
		c ifNil: [ nil ]
			ifNotNil: [ c name substrings first ] ].
	sq numberOfElements: 256 * 256.
	sq blockSize: 256.
	sq elements: ((1 to: 256 * 256) collect: [ :i | 
			[ i unicodeCharacterData ] on: KeyNotFound do: [ :ex | nil ] ]).
	^ sq
]

{ #category : #'instance creation' }
UnicodeVisualization >> openSimple [
	<script: 'self new openSimple inspect'>

	| sq |
	sq := UVSequenceVisualization new.
	sq colorOfBlock: [ :c | 
		c ifNil: [ nil ]
			ifNotNil: [ c name substrings first ] ].
	sq numberOfElements: 16 * 16.
	sq blockSize: 256.
	sq elements: ((1 to: 16 * 16) collect: [ :i | 
			[ i unicodeCharacterData ] on: KeyNotFound do: [ :ex | nil ] ]).
	sq magnifier: 20.
	^ sq
]
