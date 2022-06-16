Class {
	#name : #OlNameArgumentNode,
	#superclass : #OlObjectParseNode,
	#instVars : [
		'value',
		'name',
		'equals'
	],
	#category : #'ObjectiveLepiter-Annotation'
}

{ #category : #generated }
OlNameArgumentNode >> acceptVisitor: anObjectParseVisitor [
	^ anObjectParseVisitor visitNameArgument: self
]

{ #category : #generated }
OlNameArgumentNode >> equals [

	^ equals
]

{ #category : #generated }
OlNameArgumentNode >> equals: aSmaCCToken [

	equals := aSmaCCToken
]

{ #category : #generated }
OlNameArgumentNode >> name [

	^ name
]

{ #category : #generated }
OlNameArgumentNode >> name: aSmaCCToken [

	name := aSmaCCToken
]

{ #category : #generated }
OlNameArgumentNode >> tokenVariables [
	^ #(#name #equals #value)
]

{ #category : #accessing }
OlNameArgumentNode >> uid [
	"There's either a name or UID, but not both"
	^ nil
]

{ #category : #generated }
OlNameArgumentNode >> value [

	^ value
]

{ #category : #generated }
OlNameArgumentNode >> value: aSmaCCToken [

	value := aSmaCCToken
]
