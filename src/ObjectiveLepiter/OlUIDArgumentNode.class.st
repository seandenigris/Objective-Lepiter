Class {
	#name : #OlUIDArgumentNode,
	#superclass : #OlObjectParseNode,
	#instVars : [
		'value',
		'name',
		'equals'
	],
	#category : #'ObjectiveLepiter-Annotation'
}

{ #category : #generated }
OlUIDArgumentNode >> acceptVisitor: anObjectParseVisitor [
	^ anObjectParseVisitor visitUIDArgument: self
]

{ #category : #generated }
OlUIDArgumentNode >> equals [
	^ equals
]

{ #category : #generated }
OlUIDArgumentNode >> equals: aSmaCCToken [
	equals := aSmaCCToken
]

{ #category : #generated }
OlUIDArgumentNode >> name [
	^ name
]

{ #category : #generated }
OlUIDArgumentNode >> name: aSmaCCToken [
	name := aSmaCCToken
]

{ #category : #generated }
OlUIDArgumentNode >> tokenVariables [
	^ #(#value #name #equals)
]

{ #category : #accessing }
OlUIDArgumentNode >> uid [
	^ self value value
]

{ #category : #generated }
OlUIDArgumentNode >> value [
	^ value
]

{ #category : #generated }
OlUIDArgumentNode >> value: aSmaCCToken [
	value := aSmaCCToken
]
