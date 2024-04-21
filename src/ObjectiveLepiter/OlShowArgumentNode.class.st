Class {
	#name : #OlShowArgumentNode,
	#superclass : #OlArgumentNode,
	#category : #'ObjectiveLepiter-Annotation'
}

{ #category : #generated }
OlShowArgumentNode >> acceptVisitor: anObjectParseVisitor [
	^ anObjectParseVisitor visitShowArgument: self
]

{ #category : #accessing }
OlShowArgumentNode >> isShow [
	^ true
]

{ #category : #accessing }
OlShowArgumentNode >> selectorValue [

	^ self value value asSymbol
]
