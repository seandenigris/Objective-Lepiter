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
OlObjectAnnotationCompletionVisitor >> addStreamFor: words startingWith: prefix [
	^ self composite
		addStream:
			((words asyncStreamStartingWith: prefix)
				collect:
					[ :each | 
					GtInsertTextCompletionAction
						labeled: each
						completion: (each allButFirst: prefix size)
						position: self composite position ])
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
OlObjectAnnotationCompletionVisitor >> visitEntityAnnotation: anEntityAnnotation [
	"Halt once".
	"^ self addStreamFor: (GtPrefixTree add:'Tim1'; add: 'Tom2'; add: 'Toe3'; yourself) startingWith: ''."
	^ self visitEntityParse: anEntityAnnotation
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
