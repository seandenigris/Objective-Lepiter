Class {
	#name : #OlLabelArgumentNode,
	#superclass : #OlArgumentNode,
	#category : #'ObjectiveLepiter-Annotation'
}

{ #category : #generated }
OlLabelArgumentNode >> acceptVisitor: anObjectParseVisitor [
	^ anObjectParseVisitor visitLabelArgument: self
]

{ #category : #accessing }
OlLabelArgumentNode >> text [
	^ self value value asRopedText
]
