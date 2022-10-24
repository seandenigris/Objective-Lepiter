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
	"LeAnnotationCompletionVisitor uses this for canned options like boolean. See other sender"
	^ self
]

{ #category : #visiting }
OlObjectAnnotationCompletionVisitor >> visitError: aSmaCCError at: index [

	| token |
	
	WrapperSignal emit: { aSmaCCError. 'visit token at', index asString }.
	
	token := (aSmaCCError dismissedTokens at: index) value.
	
	token = '|' ifTrue: [ 
		WrapperSignal emit: { aSmaCCError. 'token at', index asString, 'is |' }.
		^ self
			optionsStartingWith: ''
			ignoring: (self previousOptionsFor: aSmaCCError) ].
			
	token = '=' ifTrue: [
		| completion |
		completion := OlObjectCompletionResult forInterval: (index to: index).
		WrapperSignal emit: { aSmaCCError. 'token at', index asString, 'is =' }.
		^ self composite completionResult: completion ].
		
	index > 1 ifTrue: [ 
		WrapperSignal emit: { aSmaCCError. 'token at', index asString, ' > 1' }.
		(aSmaCCError dismissedTokens at: index - 1) value = '|'
			ifTrue: [ 
				^ self
					optionsStartingWith: token
					ignoring: (self previousOptionsFor: aSmaCCError) ].
					
		(aSmaCCError dismissedTokens at: index - 1) value = '='
			ifTrue: [ 
				WrapperSignal emit: { aSmaCCError. 'token at', index asString, ' > 1 is =' }.
				^ index > 2
					ifTrue: [ self valueForOption: (aSmaCCError dismissedTokens at: index - 2) value startingWith: token ]
					ifFalse: [ self valueForOption: aSmaCCError stackContents last items last name value startingWith: token ] ] ].
					
	^ self visitSmaCCParseNode: aSmaCCError
]

{ #category : #accessing }
OlObjectAnnotationCompletionVisitor >> visitNameArgument: aNameValue [
	| first last completion isCursorInside |
	first := aNameValue startPosition.
	last := aNameValue stopPosition + 1.
	
	isCursorInside := self position >= first and: [ self position < last ].
	
	isCursorInside ifFalse: [ ^ self visitArgument: aNameValue ].
			
	completion := OlObjectCompletionResult forInterval: (first to: last).
	StringSignal emit: 'spotting'.
	^ self composite completionResult: completion
]

{ #category : #visiting }
OlObjectAnnotationCompletionVisitor >> visitSmaCCError: aSmaCCError [
	| index |
	WrapperSignal emit: aSmaCCError.
	index := (1 to: aSmaCCError dismissedTokens size)
		detect: [ :i | (aSmaCCError dismissedTokens at: i) stopPosition = self position ]
		ifNone: [ 0 ].
		
	"StringSignal emit: 'visiting error at ', index asString.
	WrapperSignal emit: aSmaCCError."
		
	index > 0 ifTrue: [ ^ self visitError: aSmaCCError at: index].
			
	index = 0 ifTrue: [ ^ self visitStartingError: aSmaCCError ].
	
	"LeAnnotations handle class name completion here.  Not sure difference vs. we handling it right during the name argument visit"																
	^ self visitSmaCCParseNode: aSmaCCError
]

{ #category : #visiting }
OlObjectAnnotationCompletionVisitor >> visitStartingError: aSmaCCError [
	WrapperSignal emit: 'visit starting'.
	 aSmaCCError stackContents isEmpty ifTrue: [ 
		WrapperSignal emit: 'stack empty'.
		^ aSmaCCError parent colon stopPosition = self position
			ifTrue: [ 
				WrapperSignal emit: 'colon'.
				self
					optionsStartingWith: ''
					ignoring: #() ]
			ifFalse: [ 
				WrapperSignal emit: { aSmaCCError. 'no colon' }.
				aSmaCCError errorToken stopPosition = self position
					ifTrue: [ 
						self
							optionsStartingWith: aSmaCCError errorToken value
							ignoring: #() ] ] ].
										
	(aSmaCCError stackContents last isKindOf: SmaCCToken)
		ifTrue: [ 
			WrapperSignal emit: { aSmaCCError. 'stack token' }.
			aSmaCCError stackContents last stopPosition = self position
				ifTrue: [ 
					| token |
					WrapperSignal emit: { aSmaCCError. 'stack end' }.
					token := aSmaCCError stackContents last value.
					(token = '=' and: [ (aSmaCCError stackContents at: aSmaCCError stackContents size - 2) value = 'name' ])
						ifTrue: [ 
							| completion |
							WrapperSignal emit: { aSmaCCError. 'stack token - yay!' }.
							completion := OlObjectCompletionResult forInterval: (1 to: 1).
							^ self composite completionResult: completion ] ] ].
	^ self visitSmaCCParseNode: aSmaCCError
]
