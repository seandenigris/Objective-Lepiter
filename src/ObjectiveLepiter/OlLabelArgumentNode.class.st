Class {
	#name : #OlLabelArgumentNode,
	#superclass : #OlObjectParseNode,
	#instVars : [
		'name',
		'equals',
		'value'
	],
	#category : #'ObjectiveLepiter-Annotation'
}

{ #category : #generated }
OlLabelArgumentNode >> acceptVisitor: anObjectParseVisitor [
	^ anObjectParseVisitor visitLabelArgument: self
]

{ #category : #generated }
OlLabelArgumentNode >> equals [
	^ equals
]

{ #category : #generated }
OlLabelArgumentNode >> equals: aSmaCCToken [
	equals := aSmaCCToken
]

{ #category : #generated }
OlLabelArgumentNode >> name [
	^ name
]

{ #category : #generated }
OlLabelArgumentNode >> name: aSmaCCToken [
	name := aSmaCCToken
]

{ #category : #accessing }
OlLabelArgumentNode >> text [
	^ self value value asRopedText
]

{ #category : #generated }
OlLabelArgumentNode >> tokenVariables [
	^ #(#name #equals #value)
]

{ #category : #generated }
OlLabelArgumentNode >> value [
	^ value
]

{ #category : #generated }
OlLabelArgumentNode >> value: aSmaCCToken [
	value := aSmaCCToken
]
