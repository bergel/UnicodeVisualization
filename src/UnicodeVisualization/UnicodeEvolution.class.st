Class {
	#name : #UnicodeEvolution,
	#superclass : #Object,
	#instVars : [
		'chars'
	],
	#category : #'UnicodeVisualization-Evolution'
}

{ #category : #initialization }
UnicodeEvolution >> initialize [
	super initialize.
	chars := Array new: 16r10FFFF
]

{ #category : #'as yet unclassified' }
UnicodeEvolution >> numberOfChars [
	^ (chars select: #notNil) size
]

{ #category : #private }
UnicodeEvolution >> process: aFileName [
	| ss index c |
	aFileName asFileReference contents lines do: [ :l |
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
				self assert: [ c name = ss second ].
				 ].
		c addVersion: aFileName asFileReference basename
			
	]
]

{ #category : #private }
UnicodeEvolution >> run [
	<script: 'self new run'>
	self process: self version14
]

{ #category : #versions }
UnicodeEvolution >> version14 [
	^ '/Users/alexandrebergel/Dropbox/GitRepos/UnicodeVisualization/data/www.unicode.org/Public/14.0.0/ucd/UnicodeData-14.0.0d1.txt'
]
