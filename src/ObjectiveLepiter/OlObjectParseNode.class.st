Class {
	#name : 'OlObjectParseNode',
	#superclass : 'SmaCCParseNode',
	#category : 'ObjectiveLepiter-Annotation',
	#package : 'ObjectiveLepiter',
	#tag : 'Annotation'
}

{ #category : 'generated' }
OlObjectParseNode >> acceptVisitor: anObjectParseVisitor [
	^ anObjectParseVisitor visitObjectParse: self
]
