Class {
	#name : #UnicodeVisualizationTest,
	#superclass : #TestCase,
	#instVars : [
		'uv'
	],
	#category : #UnicodeVisualization
}

{ #category : #running }
UnicodeVisualizationTest >> setUp [
	uv := UnicodeVisualization new
]

{ #category : #tests }
UnicodeVisualizationTest >> testGenerateColor [

	self assert: (uv colorOf: 3) = (uv colorOf: 3).
	self assert: (uv colorOf: 3) ~= (uv colorOf: 4).
	self assert: (uv colorOf: 4) = (uv colorOf: 4).
]

{ #category : #tests }
UnicodeVisualizationTest >> testGenerateForm [

	| f |
	f := uv createFormForValues: #(1 2 2 1).
	self assert: f extent equals: 2 @ 2.
	self assert: (f colorAt: 0 @ 0) equals: (f colorAt: 1 @ 1).
	self assert: (f colorAt: 0 @ 1) equals: (f colorAt: 1 @ 0).
]
