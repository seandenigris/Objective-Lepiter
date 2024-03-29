"
Adapted from {{gtClass:GtCalendarCompletionResult}}
"
Class {
	#name : #OlObjectCompletionResult,
	#superclass : #GtCompletionResult,
	#instVars : [
		'interval'
	],
	#category : #'ObjectiveLepiter-Annotation'
}

{ #category : #'instance creation' }
OlObjectCompletionResult class >> forInterval: anInterval [
	^ self new
		interval: anInterval;
		yourself
]

{ #category : #accessing }
OlObjectCompletionResult >> actionForEntity: anEntity [
	| insertionAction text |
	text := 'uid=', anEntity olUID asString36.
	insertionAction := GtInsertTextCompletionAction
		labeled: text
		completion: text
		position: self interval first - 1
		from: self interval first - 1.
	self interval last > self interval first
		ifTrue:
			[ ^ (GtCompositeCompletionAction labeled: text)
				addAction:
						(GtDeleteTextCompletionAction
								labeled: text
								from: self interval first
								to: self interval last - 1);
				addAction: insertionAction ].
	^ insertionAction
	
	"Adapted from GtCalendarCompletionResult>>#actionForDate:"
]

{ #category : #accessing }
OlObjectCompletionResult >> hasCompletionActions [
	"This was needed for completion to appear. Same implementation as GtCalendarCompletionResult"
	^ true
]

{ #category : #accessing }
OlObjectCompletionResult >> interval [

	^ interval
]

{ #category : #accessing }
OlObjectCompletionResult >> interval: anObject [

	interval := anObject
]

{ #category : #accessing }
OlObjectCompletionResult >> newSpotterElementFor: aController [

	^ GtSpotterDropdownButtonStencil new
		valuable: [ DbSoup uniqueInstance ];
		icon: BrGlamorousVectorIcons search;
		spotterElementDo: [ :element |
			element fireEvent: BrDropdownShowWish new. ];
		spotterModelDo: [ :sm |
			| initialText |
			initialText := aController text 
				copyFrom: self interval first + 'name=' size
				to: self interval last - 1.
			sm currentStep searchQuery: initialText asString ];
		actOn: [ :evt :selection :element |
			| task |
			task := BlTaskAction new 
				action: [ 
					| completionAction |
					completionAction := self actionForEntity: selection.
					aController completeWithAction: completionAction ];
				yourself.
				
			"We have to enqueue on the text element because apparently the button disappears before the task is started. A clue was that the next time the button becomes visible, a previous task suddenly is executed"
			(aController instVarNamed: #textElement) enqueueTask: task.
			
			"Doesn't close without this. Tried moving #beActed to beginning & end"
			element fireEvent: BrDropdownHideWish new.
			
			"Prevent spawning an inspector on the selected object"
			evt beActed ];
		create.
]

{ #category : #accessing }
OlObjectCompletionResult >> showOn: aController [
	| element showTask |
	element := self newSpotterElementFor: aController.
	aController popupElement: element.
	
	showTask := BlTaskAction new 
		action: [ element fireEvent: BrDropdownShowWish new ];
		yourself.
	element enqueueTask: showTask
]
