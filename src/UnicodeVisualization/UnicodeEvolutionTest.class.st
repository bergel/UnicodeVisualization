Class {
	#name : #UnicodeEvolutionTest,
	#superclass : #TestCase,
	#category : #'UnicodeVisualization-Evolution'
}

{ #category : #tests }
UnicodeEvolutionTest >> testVersion14 [
	| e |
	e := UnicodeEvolution new.
	self assert: e numberOfChars equals: 0.
	
	e process: e version14.
	self assert: e numberOfChars > 0.
]
