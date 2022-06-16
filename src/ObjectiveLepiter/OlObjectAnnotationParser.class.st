Class {
	#name : #OlObjectAnnotationParser,
	#superclass : #SmaCCGLRParser,
	#category : #'ObjectiveLepiter-Annotation'
}

{ #category : #initialization }
OlObjectAnnotationParser class >> activate [
	LeParser annotationParsers
		at: 'mpEntity'
		put: [ :parser | parser spawnParser: self startingAt: self startingStateForEntityAnnotation ].
	OlObjectAnnotationStyler activate.
	OlObjectAnnotationCompletionVisitor activate
]

{ #category : #'generated-accessing' }
OlObjectAnnotationParser class >> cacheId [
	^'2022-06-16T07:28:30.685976-04:00'
]

{ #category : #generated }
OlObjectAnnotationParser class >> definitionComment [
"%glr;
%root EntityParse;
%prefix MpLe;
%suffix Node;

<name>
	: <isLetter> +
	;
<uid>
	: (<isLetter> | <isDigit>)+
	;
EntityAnnotation 
	: Item 'item' (""|"" 'bar' Item 'item')* ""|"" 'bar'? {{}}
	;
Item
	: Name
	| UID
	;
UID
	: (""uid"" 'name' ""="" 'equals')? <uid> 'value' {{UIDArgument}}
	;
Name
	: (""name"" 'name' ""="" 'equals')? <name> 'value' {{NameValue}}
	| ""name"" 'value' {{NameValue}}
	;"
]

{ #category : #initialization }
OlObjectAnnotationParser class >> initialize [
	self activate
]

{ #category : #initialization }
OlObjectAnnotationParser class >> obsolete [
	LeParser annotationParsers removeKey: 'mpEntity' ifAbsent: [  ].
	^ super obsolete
]

{ #category : #generated }
OlObjectAnnotationParser class >> reduceTable [
^#(
	#(13 1 #reduceActionForName3: 294915 false) 
	#(13 1 #reduceActionForName3: 294913 false) 
	#(12 1 #reduceActionForUID1: 224257 false) 
	#(10 0 #reduceActionFor______bar__Item__item___1: 155649 false) 
	#(11 1 #liftFirstValue: 200706 false) 
	#(11 1 #liftFirstValue: 200705 false) 
	#(8 2 #reduceActionForEntityAnnotation1: 121857 false) 
	#(13 3 #reduceActionForName2: 294914 false) 
	#(12 3 #reduceActionForUID2: 224258 false) 
	#(8 3 #reduceActionForEntityAnnotation2: 121858 false) 
	#(10 2 #reduceActionFor______bar__Item__item___2: 155650 false) 
	#(9 2 #reduceActionFor______bar__Item__item__1: 155649 false)
	).
]

{ #category : #generated }
OlObjectAnnotationParser class >> scannerClass [
	^OlObjectAnnotationScanner
]

{ #category : #generated }
OlObjectAnnotationParser class >> startingStateForEntityAnnotation [

	^ 1
]

{ #category : #generated }
OlObjectAnnotationParser class >> symbolNames [
	^ #('"="' '"name"' '"uid"' '"|"' '<name>' '<uid>' 'B e g i n' 'EntityAnnotation' '("|" ''bar'' Item ''item'')' '("|" ''bar'' Item ''item'')*' 'Item' 'UID' 'Name' 'E O F' 'error')
]

{ #category : #generated }
OlObjectAnnotationParser class >> symbolTypes [
	^ #(#SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #OlObjectAnnotationNode #OlObjectAnnotationNode #OrderedCollection #OrderedCollection #OlObjectParseNode #OlUIDArgumentNode #OlNameValueNode #SmaCCToken #SmaCCErrorNode)
]

{ #category : #generated }
OlObjectAnnotationParser class >> transitionTable [
^#(
#[1 0 9 0 2 0 13 0 3 0 17 0 5 0 21 0 6 0 25 0 8 0 29 0 11 0 29 0 12 0 29 0 13] 
#[1 0 41 0 1 0 6 0 4 0 6 0 14] 
#[0 0 45 0 1] 
#[0 0 10 0 4 0 14] 
#[0 0 14 0 4 0 14] 
#[0 0 0 0 14] 
#[1 0 18 0 4 0 49 0 10 0 18 0 14] 
#[0 0 22 0 4 0 14] 
#[0 0 26 0 4 0 14] 
#[0 0 53 0 5] 
#[0 0 57 0 6] 
#[1 0 61 0 4 0 65 0 9 0 30 0 14] 
#[0 0 34 0 4 0 14] 
#[0 0 38 0 4 0 14] 
#[1 0 9 0 2 0 13 0 3 0 17 0 5 0 21 0 6 0 69 0 11 0 69 0 12 0 69 0 13 0 42 0 14] 
#[0 0 46 0 4 0 14] 
#[0 0 50 0 4 0 14]
	).
]

{ #category : #'generated-reduction actions' }
OlObjectAnnotationParser >> reduceActionForEntityAnnotation1: nodes [

	| result |
	result := OlObjectAnnotationNode new.
	result addNode: (nodes at: 1) to: result items.
	result addTokens: ((nodes at: 2) at: 1) to: result bars.
	result addNodes: ((nodes at: 2) at: 2) to: result items.
	^ result
]

{ #category : #'generated-reduction actions' }
OlObjectAnnotationParser >> reduceActionForEntityAnnotation2: nodes [

	| result |
	result := OlObjectAnnotationNode new.
	result addNode: (nodes at: 1) to: result items.
	result addTokens: ((nodes at: 2) at: 1) to: result bars.
	result addNodes: ((nodes at: 2) at: 2) to: result items.
	result addToken: (nodes at: 3) to: result bars.
	^ result
]

{ #category : #'generated-reduction actions' }
OlObjectAnnotationParser >> reduceActionForName2: nodes [

	| result |
	result := OlNameValueNode new.
	result name: (nodes at: 1).
	result equals: (nodes at: 2).
	result value: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
OlObjectAnnotationParser >> reduceActionForName3: nodes [

	| result |
	result := OlNameValueNode new.
	result value: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
OlObjectAnnotationParser >> reduceActionForUID1: nodes [
	| result |
	result := OlUIDArgumentNode new.
	result value: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
OlObjectAnnotationParser >> reduceActionForUID2: nodes [
	| result |
	result := OlUIDArgumentNode new.
	result name: (nodes at: 1).
	result equals: (nodes at: 2).
	result value: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
OlObjectAnnotationParser >> reduceActionFor______bar__Item__item__1: nodes [

	| result |
	result := Array new: 2.
	result at: 1 put: (nodes at: 1).
	result at: 2 put: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
OlObjectAnnotationParser >> reduceActionFor______bar__Item__item___1: nodes [

	| result |
	result := Array new: 2.
	result at: 1 put: (OrderedCollection new: 2).
	result at: 2 put: (OrderedCollection new: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
OlObjectAnnotationParser >> reduceActionFor______bar__Item__item___2: nodes [

	| result |
	result := nodes at: 1.
	self add: ((nodes at: 2) at: 1) to: (result at: 1).
	self add: ((nodes at: 2) at: 2) to: (result at: 2).
	^ result
]
