Extension { #name : #LePharoSnippetViewModel }

{ #category : #'*ObjectiveLepiter' }
LePharoSnippetViewModel >> initializeCoderAddOns: aCoderViewModel [
	"Initialise the keyboard shortcuts in the code editor"
	
	aCoderViewModel localBindings
		localAt: #thisSnippetViewModel
		put: self.

	aCoderViewModel localBindings
		localAt: #thisSnippet
		put: self snippetModel.
		
	(self snippetModel page type isKindOf: OlObjectPageType) ifTrue: [
		aCoderViewModel localBindings
			localAt: #thisObject
			put: self snippetModel page type subjectModel ].

	aCoderViewModel
		"Create New snippet (after the current snippet)"
		addShortcut: (LeSnippetSplitSnippetShortcut new combination: (self keyboardShortcut: #SplitSnippet));
		"Delete previous character, or merge with previous snippet"	
		addShortcut: (LeSnippetDeletePreviousShortcut new combination: (self keyboardShortcut: #DeletePrevious));
		"Indent LeSnippet"
		addShortcut: (LeSnippetIndentSnippetShortcut new combination: (self keyboardShortcut: #IndentSnippet));
		"Unindent LeSnippet"
		addShortcut: (LeSnippetUnindentSnippetShortcut new combination: (self keyboardShortcut: #UnindentSnippet));
		"Move Snippet up"
		addShortcut: (LeSnippetMoveSnippetUpShortcut new combination: (self keyboardShortcut: #MoveSnippetUp));
		"Move Snippet down"
		addShortcut: (LeSnippetMoveSnippetDownShortcut new combination: (self keyboardShortcut: #MoveSnippetDown))
]
