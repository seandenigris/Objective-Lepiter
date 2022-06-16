Class {
	#name : #OlObjectAnnotationCompletionVisitor,
	#superclass : #Object,
	#traits : 'TSmaCCComponentVisitor + (TOlObjectParseNodeVisitor - {#acceptNode:})',
	#classTraits : 'TSmaCCComponentVisitor classTrait + TOlObjectParseNodeVisitor classTrait',
	#category : #'ObjectiveLepiter-Annotation'
}

{ #category : #accessing }
OlObjectAnnotationCompletionVisitor class >> activate [
	LeContentCompletionVisitor additionalCompletionVisitors add: self
]

{ #category : #accessing }
OlObjectAnnotationCompletionVisitor class >> initialize [
	self activate
]

{ #category : #accessing }
OlObjectAnnotationCompletionVisitor class >> obsolete [
	LeContentCompletionVisitor additionalCompletionVisitors remove: self ifAbsent: [  ].
	^ super obsolete
]

{ #category : #accessing }
OlObjectAnnotationCompletionVisitor >> position [
	^ self composite position
]

{ #category : #accessing }
OlObjectAnnotationCompletionVisitor >> visitArgument: anArgument [
	^ self visitEntityParse: anArgument
]

{ #category : #generated }
OlObjectAnnotationCompletionVisitor >> visitNameValue: aNameValue [
	| first last completion isCursorInside |
	first := aNameValue valueStartPosition.
	last := aNameValue stopPosition + 1.
	
	isCursorInside := self position >= first and: [ self position < last ].
	isCursorInside ifFalse: [ ^ self visitArgument: aNameValue ].
			
	completion := OlObjectCompletionResult forInterval: (first to: last).
	^ self composite completionResult: completion
]
