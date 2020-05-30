Class {
	#name : #UnicodeVisualization,
	#superclass : #Object,
	#category : #'UnicodeVisualization-Visualization'
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
UnicodeVisualization >> openFull [
	<script: 'self new openFull inspect'>

	| sq |
	sq := UVSequenceVisualization new.
	sq colorOfBlock: [ :c | 
		c ifNil: [ nil ]
			ifNotNil: [ c name substrings first ] ].
	sq numberOfElements: 256 * 256 * 17.
	sq blockSize: 256.
	sq elements: ((1 to: 256 * 256 * 17) collect: [ :i | 
			[ i unicodeCharacterData ] on: KeyNotFound do: [ :ex | nil ] ]).
	sq spaceEvery: 256 * 256.
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

{ #category : #'instance creation' }
UnicodeVisualization >> openSimple2 [
	<script: 'self new openSimple2 inspect'>

	| sq filename contents |
	filename := '/Users/alexandrebergel/Dropbox/GitRepos/UnicodeVisualization/data/www.unicode.org/Public/14.0.0/ucd/UnicodeData-14.0.0d1.txt'.
	contents := filename asFileReference contents lines first: 256.
	
	sq := UVSequenceVisualization new.
	sq colorOfBlock: [ :row | ((row substrings: ';') second) substrings first  ].
	sq numberOfElements: 16 * 16.
	sq blockSize: 256.
	sq elements: contents.
	sq magnifier: 20.
	^ sq
]

{ #category : #'instance creation' }
UnicodeVisualization >> openSimple3 [
	<script: 'self new openSimple3 inspect'>

	| sq filename contents |
	filename := '/Users/alexandrebergel/Dropbox/GitRepos/UnicodeVisualization/data/www.unicode.org/Public/14.0.0/ucd/UnicodeData-14.0.0d1.txt'.
	contents := filename asFileReference contents lines first: 256 * 256.
	
	sq := UVSequenceVisualization new.
	sq colorOfBlock: [ :row | ((row substrings: ';') second) substrings first  ].
	sq numberOfElements: 16 * 16 * 256.
	sq blockSize: 256.
	sq elements: contents.
	sq magnifier: 3.
	^ sq
]
