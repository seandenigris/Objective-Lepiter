Class {
	#name : #OlArgumentNode,
	#superclass : #OlObjectParseNode,
	#instVars : [
		'name',
		'equals',
		'value'
	],
	#category : #'ObjectiveLepiter-Annotation'
}

{ #category : #generated }
OlArgumentNode >> acceptVisitor: anObjectParseVisitor [
	^ anObjectParseVisitor visitArgument: self
]

{ #category : #generated }
OlArgumentNode >> equals [
	^ equals
]

{ #category : #generated }
OlArgumentNode >> equals: aSmaCCToken [
	equals := aSmaCCToken
]

{ #category : #accessing }
OlArgumentNode >> isExpanded [
	^ false
]

{ #category : #accessing }
OlArgumentNode >> isLabel [
	^ false
]

{ #category : #accessing }
OlArgumentNode >> isShow [
	^ false
]

{ #category : #generated }
OlArgumentNode >> name [
	^ name
]

{ #category : #generated }
OlArgumentNode >> name: aSmaCCToken [
	name := aSmaCCToken
]

{ #category : #generated }
OlArgumentNode >> tokenVariables [
	^ #(#name #equals #value)
]

{ #category : #generated }
OlArgumentNode >> value [
	^ value
]

{ #category : #generated }
OlArgumentNode >> value: aSmaCCToken [
	value := aSmaCCToken
]
