Class {
	#name : #OlExpandedArgumentNode,
	#superclass : #OlArgumentNode,
	#category : #'ObjectiveLepiter-Annotation'
}

{ #category : #generated }
OlExpandedArgumentNode >> acceptVisitor: anObjectParseVisitor [
	^ anObjectParseVisitor visitExpandedArgument: self
]

{ #category : #accessing }
OlExpandedArgumentNode >> booleanValue [
	"LeAnnotation puts this in ArgumentNode superclass, but we would have to push up the inst var first"
	^ value isNil or: [ value source sameAs: 'true' ]
]

{ #category : #accessing }
OlExpandedArgumentNode >> isExpanded [
	^ true
]
