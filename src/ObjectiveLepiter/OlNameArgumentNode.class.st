Class {
	#name : #OlNameArgumentNode,
	#superclass : #OlArgumentNode,
	#category : #'ObjectiveLepiter-Annotation'
}

{ #category : #generated }
OlNameArgumentNode >> acceptVisitor: anObjectParseVisitor [
	^ anObjectParseVisitor visitNameArgument: self
]

{ #category : #accessing }
OlNameArgumentNode >> uid [
	"There's either a name or UID, but not both"
	^ nil
]
