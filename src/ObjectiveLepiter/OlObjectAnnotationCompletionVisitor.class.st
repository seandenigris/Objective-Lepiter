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

{ #category : #visiting }
OlObjectAnnotationCompletionVisitor >> isAtFirstArgumentStart: aSmaCCError [ 

	aSmaCCError stackContents isEmpty ifFalse: [ ^ false ].
	"WrapperSignal emit: 'stack empty'."
	
	^ aSmaCCError parent colon stopPosition = self position
]

{ #category : #visiting }
OlObjectAnnotationCompletionVisitor >> isInFirstArgumentName: aSmaCCError [ 

	aSmaCCError stackContents isEmpty ifFalse: [ ^ false ].
	aSmaCCError parent colon stopPosition = self position ifTrue: [ ^ false ].
	
	^ aSmaCCError errorToken stopPosition = self position
]

{ #category : #visiting }
OlObjectAnnotationCompletionVisitor >> isNameArgumentValueStart: aSmaCCError [

	| token argumentName |
	(aSmaCCError stackContents last isKindOf: SmaCCToken) ifFalse: [ ^ false ].
	WrapperSignal emit: {aSmaCCError. 'stack token'}.
	
	aSmaCCError stackContents last stopPosition = self position ifFalse: [ ^ false ].
	WrapperSignal emit: {aSmaCCError. 'stack end'}.
	
	token := aSmaCCError stackContents last value.
	token = '=' ifFalse: [ ^ false ].
	
	argumentName := (aSmaCCError stackContents at: aSmaCCError stackContents size - 2) value.
	argumentName = 'name' ifFalse: [ ^ false ].
	WrapperSignal emit: { aSmaCCError. 'stack token - yay!' }.
			
	^ true
]

{ #category : #accessing }
OlObjectAnnotationCompletionVisitor >> optionsStartingWith: aString ignoring: aCollection [
	| valueStream |
	WrapperSignal emit: { 'optionsStartingWith:ignoring:'. aString. aCollection. self }.
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
		
	self composite addStream: valueStream.
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
	
	WrapperSignal emit: { 'visitError:at:'. aSmaCCError. 'visit token at ', index asString }.
	
	token := (aSmaCCError dismissedTokens at: index) value.
	
	token = '|' ifTrue: [ 
		WrapperSignal emit: { '| token at ', index asString. aSmaCCError }.
		^ self
			optionsStartingWith: ''
			ignoring: (self previousOptionsFor: aSmaCCError) ].
			
	(token = '=' and: [ aSmaCCError dismissedTokens second value = 'name' ]) ifTrue: [
		| completion |
		WrapperSignal emit: { '= token at ', index asString. aSmaCCError }.
		completion := OlObjectCompletionResult forInterval: (index to: index).
		^ self composite completionResult: completion ].
		
	index > 1 ifTrue: [ 
		WrapperSignal emit: { 'token at', index asString, ' > 1'. aSmaCCError }.
		(aSmaCCError dismissedTokens at: index - 1) value = '|'
			ifTrue: [ 
				^ self
					optionsStartingWith: token
					ignoring: (self previousOptionsFor: aSmaCCError) ].
					
		(aSmaCCError dismissedTokens at: index - 1) value = '='
			ifTrue: [ 
				WrapperSignal emit: { '= token at ', index asString. aSmaCCError }.
				^ index > 2
					ifTrue: [ self valueForOption: (aSmaCCError dismissedTokens at: index - 2) value startingWith: token ]
					ifFalse: [ self valueForOption: aSmaCCError stackContents last items last name value startingWith: token ] ] ].
					
	WrapperSignal emit: { 'visitError:at: - final return'. aSmaCCError. 'visit token at ', index asString }.
					
	^ self visitSmaCCParseNode: aSmaCCError
]

{ #category : #visiting }
OlObjectAnnotationCompletionVisitor >> visitFirstArgumentError: aSmaCCError [
	WrapperSignal emit: 'visit first argument'.
	
	(self isAtFirstArgumentStart: aSmaCCError) ifTrue: [
		WrapperSignal emit: '1st arg start'.
		^ self
			optionsStartingWith: ''
			ignoring: #() ].
			
	(self isInFirstArgumentName: aSmaCCError) ifTrue: [
		| argNamePrefix |
		WrapperSignal emit: { '1st arg in name'. aSmaCCError }.
		argNamePrefix := aSmaCCError errorToken value.
		^ self
			optionsStartingWith: argNamePrefix
			ignoring: #() ].
	
	(self isNameArgumentValueStart: aSmaCCError) ifTrue: [ 
		| completion |
		WrapperSignal emit: { '1st arg name value start'. aSmaCCError }.
		completion := OlObjectCompletionResult forInterval: (aSmaCCError startPosition to: aSmaCCError stopPosition + 1).
		^ self composite completionResult: completion ].

	^ self visitSmaCCParseNode: aSmaCCError
]

{ #category : #accessing }
OlObjectAnnotationCompletionVisitor >> visitNameArgument: aNameValue [
	| first last completion isCursorInside |
	WrapperSignal emit: { 'visitNameArgument:'. aNameValue. self }.
	first := aNameValue startPosition.
	last := aNameValue stopPosition + 1.
	
	isCursorInside := self position >= first and: [ self position < last ].
	
	isCursorInside ifFalse: [ ^ self visitArgument: aNameValue ].
			
	completion := OlObjectCompletionResult forInterval: (first to: last).
	^ self composite completionResult: completion
]

{ #category : #visiting }
OlObjectAnnotationCompletionVisitor >> visitSmaCCError: aSmaCCError [
	| index |

	index := (1 to: aSmaCCError dismissedTokens size)
		detect: [ :i | (aSmaCCError dismissedTokens at: i) stopPosition = self position ]
		ifNone: [ 0 ].
		
	WrapperSignal emit: { 'visitSmaCCError:'. aSmaCCError. 'visit token at ', index asString }.
		
	index > 0 ifTrue: [ ^ self visitError: aSmaCCError at: index].
			
	index = 0 ifTrue: [ ^ self visitFirstArgumentError: aSmaCCError ].
	
	"LeAnnotations handle class name completion here.  Not sure difference vs. we handling it right during the name argument visit"																
	^ self visitSmaCCParseNode: aSmaCCError
]
