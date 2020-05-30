Class {
	#name : #UnicodeEvolutionDifference,
	#superclass : #Object,
	#instVars : [
		'version1',
		'version2',
		'addedChars',
		'removedChars'
	],
	#category : #'UnicodeVisualization-Evolution'
}

{ #category : #accessing }
UnicodeEvolutionDifference >> addedChars [
	^ addedChars
]

{ #category : #accessing }
UnicodeEvolutionDifference >> addedChars: anObject [
	addedChars := anObject
]

{ #category : #printing }
UnicodeEvolutionDifference >> printOn: str [
	super printOn: str.
	str nextPut: $<.
	addedChars ifNotNil: [ str nextPutAll: addedChars size asString ].
	str nextPut: $,.
	str nextPut: $ .
	removedChars ifNotNil: [ str nextPutAll: removedChars size asString ].
	str nextPut: $>.
]

{ #category : #accessing }
UnicodeEvolutionDifference >> removedChars [
	^ removedChars
]

{ #category : #accessing }
UnicodeEvolutionDifference >> removedChars: anObject [
	removedChars := anObject
]

{ #category : #versions }
UnicodeEvolutionDifference >> version1: v1 version2: v2 [
	version1 := v1.
	version2 := v2
]
