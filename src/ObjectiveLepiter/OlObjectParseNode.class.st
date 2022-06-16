Class {
	#name : #OlObjectParseNode,
	#superclass : #SmaCCParseNode,
	#category : #'ObjectiveLepiter-Annotation'
}

{ #category : #generated }
OlObjectParseNode >> acceptVisitor: anObjectParseVisitor [
	^ anObjectParseVisitor visitObjectParse: self
]
