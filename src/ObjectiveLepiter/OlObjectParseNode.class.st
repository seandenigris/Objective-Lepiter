Class {
	#name : #OlObjectParseNode,
	#superclass : #SmaCCParseNode,
	#category : #'ObjectiveLepiter-Annotation'
}

{ #category : #generated }
OlObjectParseNode >> acceptVisitor: anEntityParseVisitor [

	^ anEntityParseVisitor visitEntityParse: self
]
