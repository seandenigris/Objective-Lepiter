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
OlObjectAnnotationCompletionVisitor class >> obsolete [
	LeContentCompletionVisitor additionalCompletionVisitors remove: self ifAbsent: [  ].
	^ super obsolete
]

{ #category : #accessing }
OlObjectAnnotationCompletionVisitor >> position [
	^ self composite position
]

{ #category : #generated }
OlObjectAnnotationCompletionVisitor >> visitAnnotation: anAnnotation [
	^ self visitObjectParse: anAnnotation
]

{ #category : #accessing }
OlObjectAnnotationCompletionVisitor >> visitArgument: anArgument [
	^ self visitObjectParse: anArgument
]

{ #category : #accessing }
OlObjectAnnotationCompletionVisitor >> visitNameArgument: aNameValue [
	| first last completion isCursorInside |
	first := aNameValue startPosition.
	last := aNameValue stopPosition + 1.
	
	isCursorInside := self position >= first and: [ self position < last ].
	isCursorInside ifFalse: [ ^ self visitArgument: aNameValue ].
			
	completion := OlObjectCompletionResult forInterval: (first to: last).
	^ self composite completionResult: completion
]

{ #category : #visiting }
OlObjectAnnotationCompletionVisitor >> visitSmaCCError: aSmaCCError [
	| index token annotationType class className isMeta |
	index := (1 to: aSmaCCError dismissedTokens size)
		detect: [ :i | (aSmaCCError dismissedTokens at: i) stopPosition = self position ]
		ifNone: [ 0 ].
	annotationType := aSmaCCError parent name source.
	Halt now.
	^ self visitSmaCCParseNode: aSmaCCError
]
