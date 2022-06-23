Extension { #name : #LeAnnotationCompletionVisitor }

{ #category : #'*ObjectiveLepiter' }
LeAnnotationCompletionVisitor >> optionsFor: annotationType startingWith: aString ignoring: aCollection [
	| values |
	values := #().
	annotationType = 'gtClass' ifTrue: [ values := #(name label full expanded show height) ].
	annotationType = 'gtPackage' ifTrue: [ values := #(name label tag expanded show height) ].
	annotationType = 'gtMethod' ifTrue: [ values := #(name label expanded show height) ].
	annotationType = 'gtExample'
		ifTrue: [ values := #(name label expanded codeExpanded noCode previewHeight previewExpanded alignment return) ].
	annotationType = 'gtTodo' ifTrue: [ values := #(label due completed) ].
	annotationType = 'olObject' ifTrue: [ values := OlObjectAnnotationParser argumentNames ].
	self composite
		addStream:
			((values asAsyncStream
				filter: [ :each | (aString isEmpty or: [ each beginsWith: aString ]) and: [ (aCollection includes: each asString) not ] ])
				collect:
					[ :each | 
					| name hasOptionalValue |
					hasOptionalValue := self optionalValues includes: each.
					name := each , (hasOptionalValue ifTrue: [ '' ] ifFalse: [ '=' ]).
					(GtInsertTextCompletionAction
						labeled: (self strategy labelFor: name withSearch: aString)
						completion: (name allButFirst: aString size)
						position: self position) partial: hasOptionalValue not ])
]
