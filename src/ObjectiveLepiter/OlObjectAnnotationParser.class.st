Class {
	#name : #OlObjectAnnotationParser,
	#superclass : #SmaCCGLRParser,
	#category : #'ObjectiveLepiter-Annotation'
}

{ #category : #initialization }
OlObjectAnnotationParser class >> activate [
	LeParser annotationParsers
		at: 'olObject'
		put: [ :parser | parser spawnParser: self startingAt: self startingStateForAnnotation ].
	OlObjectAnnotationStyler activate.
	OlObjectAnnotationCompletionVisitor activate
]

{ #category : #'generated-accessing' }
OlObjectAnnotationParser class >> cacheId [
	^'2022-06-16T11:53:53.438199-04:00'
]

{ #category : #generated }
OlObjectAnnotationParser class >> definitionComment [
"%glr;
%root ObjectParse;
%prefix Ol;
%suffix Node;

<name>
	: <isUppercase> <isLetter> *
	;
<uid>
	: (<isLetter> | <isDigit>)+
	;
Annotation 
	: Item 'item' (""|"" 'bar' Item 'item')* ""|"" 'bar'? {{}}
	;
Item
	: Name
	| UID
	;
UID
	:""uid"" 'name' ""="" 'equals' <uid> 'value' {{UIDArgument}}
	;
Name
	: (""name"" 'name' ""="" 'equals')? <name> 'value' {{NameValue}}
	;"
]

{ #category : #initialization }
OlObjectAnnotationParser class >> initialize [
	self activate
]

{ #category : #initialization }
OlObjectAnnotationParser class >> obsolete [
	LeParser annotationParsers removeKey: 'olObject' ifAbsent: [  ].
	^ super obsolete
]

{ #category : #generated }
OlObjectAnnotationParser class >> reduceTable [
^#(
	#(13 1 #reduceActionForName1: 296961 false) 
	#(10 0 #reduceActionFor______bar__Item__item___1: 161793 false) 
	#(11 1 #liftFirstValue: 206850 false) 
	#(11 1 #liftFirstValue: 206849 false) 
	#(8 2 #reduceActionForAnnotation1: 134145 false) 
	#(13 3 #reduceActionForName2: 296962 false) 
	#(12 3 #reduceActionForUID1: 230401 false) 
	#(8 3 #reduceActionForAnnotation2: 134146 false) 
	#(10 2 #reduceActionFor______bar__Item__item___2: 161794 false) 
	#(9 2 #reduceActionFor______bar__Item__item__1: 161793 false)
	).
]

{ #category : #generated }
OlObjectAnnotationParser class >> scannerClass [
	^OlObjectAnnotationScanner
]

{ #category : #generated }
OlObjectAnnotationParser class >> startingStateForAnnotation [
	^ 1
]

{ #category : #generated }
OlObjectAnnotationParser class >> symbolNames [
	^ #('"="' '"name"' '"uid"' '"|"' '<name>' '<uid>' 'B e g i n' 'Annotation' '("|" ''bar'' Item ''item'')' '("|" ''bar'' Item ''item'')*' 'Item' 'UID' 'Name' 'E O F' 'error')
]

{ #category : #generated }
OlObjectAnnotationParser class >> symbolTypes [
	^ #(#SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #OlAnnotationNode #OlAnnotationNode #OrderedCollection #OrderedCollection #OlObjectParseNode #OlUIDArgumentNode #OlNameValueNode #SmaCCToken #SmaCCErrorNode)
]

{ #category : #generated }
OlObjectAnnotationParser class >> transitionTable [
^#(
#[1 0 9 0 2 0 13 0 3 0 17 0 5 0 21 0 8 0 25 0 11 0 25 0 12 0 25 0 13] 
#[0 0 37 0 1] 
#[0 0 41 0 1] 
#[0 0 6 0 4 0 14] 
#[0 0 0 0 14] 
#[1 0 10 0 4 0 45 0 10 0 10 0 14] 
#[0 0 14 0 4 0 14] 
#[0 0 18 0 4 0 14] 
#[0 0 49 0 5] 
#[0 0 53 0 6] 
#[1 0 57 0 4 0 61 0 9 0 22 0 14] 
#[0 0 26 0 4 0 14] 
#[0 0 30 0 4 0 14] 
#[1 0 9 0 2 0 13 0 3 0 17 0 5 0 65 0 11 0 65 0 12 0 65 0 13 0 34 0 14] 
#[0 0 38 0 4 0 14] 
#[0 0 42 0 4 0 14]
	).
]

{ #category : #'generated-reduction actions' }
OlObjectAnnotationParser >> reduceActionForAnnotation1: nodes [
	| result |
	result := OlAnnotationNode new.
	result addNode: (nodes at: 1) to: result items.
	result addTokens: ((nodes at: 2) at: 1) to: result bars.
	result addNodes: ((nodes at: 2) at: 2) to: result items.
	^ result
]

{ #category : #'generated-reduction actions' }
OlObjectAnnotationParser >> reduceActionForAnnotation2: nodes [
	| result |
	result := OlAnnotationNode new.
	result addNode: (nodes at: 1) to: result items.
	result addTokens: ((nodes at: 2) at: 1) to: result bars.
	result addNodes: ((nodes at: 2) at: 2) to: result items.
	result addToken: (nodes at: 3) to: result bars.
	^ result
]

{ #category : #'generated-reduction actions' }
OlObjectAnnotationParser >> reduceActionForName1: nodes [
	| result |
	result := OlNameValueNode new.
	result value: (nodes at: 1).
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
OlObjectAnnotationParser >> reduceActionForUID1: nodes [
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
