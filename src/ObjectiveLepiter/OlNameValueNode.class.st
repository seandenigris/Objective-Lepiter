Class {
	#name : #OlNameValueNode,
	#superclass : #OlObjectParseNode,
	#instVars : [
		'value',
		'name',
		'equals'
	],
	#category : #'ObjectiveLepiter-Annotation'
}

{ #category : #generated }
OlNameValueNode >> acceptVisitor: anObjectParseVisitor [
	^ anObjectParseVisitor visitNameValue: self
]

{ #category : #generated }
OlNameValueNode >> equals [

	^ equals
]

{ #category : #generated }
OlNameValueNode >> equals: aSmaCCToken [

	equals := aSmaCCToken
]

{ #category : #generated }
OlNameValueNode >> name [

	^ name
]

{ #category : #generated }
OlNameValueNode >> name: aSmaCCToken [

	name := aSmaCCToken
]

{ #category : #generated }
OlNameValueNode >> tokenVariables [

	^ #( #value #name #equals )
]

{ #category : #accessing }
OlNameValueNode >> uid [
	"There's either a name or UID, but not both"
	^ nil
]

{ #category : #generated }
OlNameValueNode >> value [

	^ value
]

{ #category : #generated }
OlNameValueNode >> value: aSmaCCToken [

	value := aSmaCCToken
]

{ #category : #accessing }
OlNameValueNode >> valueStartPosition [
	^ self equals 
		ifNotNil: [ :eq | eq stopPosition ]
		ifNil: [ self value startPosition ]
]
