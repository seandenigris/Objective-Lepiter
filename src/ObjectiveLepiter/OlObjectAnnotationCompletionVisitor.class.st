"
Adapted from {{gtClass:LeAnnotationCompletionVisitor}}.
"
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
OlObjectAnnotationCompletionVisitor >> optionsStartingWith: aString ignoring: aCollection [
	| valueStream |
	valueStream := OlObjectAnnotationParser argumentNames asAsyncStream
		filter: [ :each |
			| doesMatch isIgnoredBlock |
			doesMatch := aString isEmpty or: [ each beginsWith: aString ].
			isIgnoredBlock := [ (aCollection includes: each asString) not ].
			doesMatch and: isIgnoredBlock ].
		
	valueStream := valueStream collect: [ :each | 
		| completion |
		completion := GtInsertTextCompletionAction
			labeled: (self strategy labelFor: each , '=' withSearch: aString)
			completion: (each , '=' allButFirst: aString size)
			position: self position.
		completion partial: false ].
		
	self composite
		addStream: valueStream.
]

{ #category : #accessing }
OlObjectAnnotationCompletionVisitor >> position [
	^ self composite position
]

{ #category : #accessing }
OlObjectAnnotationCompletionVisitor >> previousOptionsFor: aSmaCCErrorNode [
	aSmaCCErrorNode stackContents
		do: [ :annNode | 
			(annNode isKindOf: OlAnnotationNode)
				ifTrue: [ ^ annNode children
						collect:
							[ :argNode | argNode name value ] ] ].
	^ #()
]

{ #category : #accessing }
OlObjectAnnotationCompletionVisitor >> strategy [
	^ self composite strategy
]

{ #category : #accessing }
OlObjectAnnotationCompletionVisitor >> valueForOption: optionName startingWith: aString [
	"LeAnnotations use this for canned options like boolean. See other sender"
	^ self
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
	| index token |
	index := (1 to: aSmaCCError dismissedTokens size)
		detect: [ :i | (aSmaCCError dismissedTokens at: i) stopPosition = self position ]
		ifNone: [ 0 ].
	index > 0
		ifTrue:
			[ 
			token := (aSmaCCError dismissedTokens at: index) value.
			token = '|'
				ifTrue:
					[ ^ self
						optionsStartingWith: ''
						ignoring: (self previousOptionsFor: aSmaCCError) ].
			token = '='
				ifTrue:
					[ ^ index > 1
						ifTrue: [ self valueForOption: (aSmaCCError dismissedTokens at: index - 1) value startingWith: '' ]
						ifFalse: [ self valueForOption: aSmaCCError stackContents last items last name value startingWith: '' ] ].
			index > 1
				ifTrue:
					[ (aSmaCCError dismissedTokens at: index - 1) value = '|'
						ifTrue:
							[ ^ self
								optionsStartingWith: token
								ignoring: (self previousOptionsFor: aSmaCCError) ].
					(aSmaCCError dismissedTokens at: index - 1) value = '='
						ifTrue:
							[ ^ index > 2
								ifTrue: [ self valueForOption: (aSmaCCError dismissedTokens at: index - 2) value startingWith: token ]
								ifFalse: [ self valueForOption: aSmaCCError stackContents last items last name value startingWith: token ] ] ].
			(('class' beginsWith: token)
				and: [ aSmaCCError stackContents notEmpty and: [ aSmaCCError stackContents last isKindOf: LeClassAnnotationNode ] ])
				ifTrue:
					[ ^ self composite
						addStream:
							{GtInsertTextCompletionAction
									labeled: (self strategy labelFor: 'class' withSearch: token)
									completion: ('class' allButFirst: token size)
									position: self position} asAsyncStream ] ].
	index = 0
		ifTrue:
			[ aSmaCCError stackContents isEmpty
				ifTrue:
					[ ^ aSmaCCError parent colon stopPosition = self position
						ifTrue:
							[ self
								optionsStartingWith: ''
								ignoring: #() ]
						ifFalse:
							[ aSmaCCError errorToken stopPosition = self position
								ifTrue:
									[ self
										optionsStartingWith: aSmaCCError errorToken value
										ignoring: #() ] ] ] ].
	
	"LeAnnotations handle class name completion here.  Not sure difference vs. we handling it right during the name argument visit"																
	^ self visitSmaCCParseNode: aSmaCCError
]
