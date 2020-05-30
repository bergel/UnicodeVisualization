Class {
	#name : #UnicodeChar,
	#superclass : #Object,
	#instVars : [
		'code',
		'index',
		'name',
		'inVersions'
	],
	#category : #'UnicodeVisualization-Evolution'
}

{ #category : #adding }
UnicodeChar >> addVersion: aString [
	inVersions add: aString
]

{ #category : #accessing }
UnicodeChar >> code [
	^ code
]

{ #category : #accessing }
UnicodeChar >> code: anObject [
	code := anObject
]

{ #category : #accessing }
UnicodeChar >> inVersions [
	^ inVersions
]

{ #category : #accessing }
UnicodeChar >> inVersions: anObject [
	inVersions := anObject
]

{ #category : #accessing }
UnicodeChar >> index [
	^ index
]

{ #category : #accessing }
UnicodeChar >> index: anObject [
	index := anObject
]

{ #category : #initialization }
UnicodeChar >> initialize [
	super initialize.	
	inVersions := OrderedCollection new
]

{ #category : #testing }
UnicodeChar >> isInVersion: aVersion [
	^ inVersions includes: aVersion
]

{ #category : #accessing }
UnicodeChar >> name [
	^ name
]

{ #category : #accessing }
UnicodeChar >> name: anObject [
	name := anObject
]

{ #category : #'as yet unclassified' }
UnicodeChar >> numberOfVersions [
	^ inVersions size
]
