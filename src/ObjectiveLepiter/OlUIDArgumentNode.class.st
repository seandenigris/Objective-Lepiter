Class {
	#name : #OlUIDArgumentNode,
	#superclass : #OlArgumentNode,
	#category : #'ObjectiveLepiter-Annotation'
}

{ #category : #generated }
OlUIDArgumentNode >> acceptVisitor: anObjectParseVisitor [
	^ anObjectParseVisitor visitUIDArgument: self
]

{ #category : #accessing }
OlUIDArgumentNode >> uid [
	^ self value value
]
