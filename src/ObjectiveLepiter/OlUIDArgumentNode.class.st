Class {
	#name : 'OlUIDArgumentNode',
	#superclass : 'OlArgumentNode',
	#category : 'ObjectiveLepiter-Annotation',
	#package : 'ObjectiveLepiter',
	#tag : 'Annotation'
}

{ #category : 'generated' }
OlUIDArgumentNode >> acceptVisitor: anObjectParseVisitor [
	^ anObjectParseVisitor visitUIDArgument: self
]

{ #category : 'accessing' }
OlUIDArgumentNode >> uid [
	^ self value value
]
