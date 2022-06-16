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
	^'2022-06-16T12:58:11.252527-04:00'
]

{ #category : #generated }
OlObjectAnnotationParser class >> definitionComment [
"%glr;
%root ObjectParse;
%prefix Ol;
%suffix Node;

%scopes default lab;

<name>
	: <isUppercase> <isLetter> *
	;
<uid>
	: (<isLetter> | <isDigit>)+
	;
<label>
	: label
	;
default <eq>
	: \=
	;
label <labelText>
	: [^\|\}\\]+
	;
Annotation 
	: Identifier 'item' (""|"" 'bar' OptionalArgument 'item')* {{}}
	;
OptionalArgument
	: Label
	;
Label
	: <label> 'name' SwitchToLabel ""="" 'equals' SwitchToDefault <labelText> 'value' {{LabelArgument}}
	;
SwitchToDefault
	: [self scope: #default. nil]
	;
SwitchToLabel
	: [self scope: #label. nil]
	;
Identifier
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
	#(19 1 #reduceActionForName1: 650241 false) 
	#(12 0 #reduceActionFor______bar__OptionalArgument__item___1: 269313 false) 
	#(17 1 #liftFirstValue: 553986 false) 
	#(17 1 #liftFirstValue: 553985 false) 
	#(10 2 #reduceActionForAnnotation1: 235521 false) 
	#(19 3 #reduceActionForName2: 650242 false) 
	#(18 3 #reduceActionForUID1: 583681 false) 
	#(12 2 #reduceActionFor______bar__OptionalArgument__item___2: 269314 false) 
	#(16 0 #reduceActionForSwitchToLabel1: 506881 true) 
	#(11 2 #reduceActionFor______bar__OptionalArgument__item__1: 269313 false) 
	#(13 1 #liftFirstValue: 315393 false) 
	#(15 0 #reduceActionForSwitchToDefault1: 455681 true) 
	#(14 5 #reduceActionForLabel1: 345089 false)
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
	^ #('"="' '"name"' '"uid"' '"|"' '<name>' '<uid>' '<label>' '<labelText>' 'B e g i n' 'Annotation' '("|" ''bar'' OptionalArgument ''item'')' '("|" ''bar'' OptionalArgument ''item'')*' 'OptionalArgument' 'Label' 'SwitchToDefault' 'SwitchToLabel' 'Identifier' 'UID' 'Name' 'E O F' 'error')
]

{ #category : #generated }
OlObjectAnnotationParser class >> symbolTypes [
	^ #(#SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #OlAnnotationNode #OlAnnotationNode #OrderedCollection #OrderedCollection #OlLabelArgumentNode #OlLabelArgumentNode nil nil #OlObjectParseNode #OlUIDArgumentNode #OlNameValueNode #SmaCCToken #SmaCCErrorNode)
]

{ #category : #generated }
OlObjectAnnotationParser class >> transitionTable [
^#(
#[1 0 9 0 2 0 13 0 3 0 17 0 5 0 21 0 10 0 25 0 17 0 25 0 18 0 25 0 19] 
#[0 0 37 0 1] 
#[0 0 41 0 1] 
#[0 0 6 0 4 0 20] 
#[0 0 0 0 20] 
#[1 0 10 0 4 0 45 0 12 0 10 0 20] 
#[0 0 14 0 4 0 20] 
#[0 0 18 0 4 0 20] 
#[0 0 49 0 5] 
#[0 0 53 0 6] 
#[1 0 57 0 4 0 61 0 11 0 22 0 20] 
#[0 0 26 0 4 0 20] 
#[0 0 30 0 4 0 20] 
#[1 0 65 0 7 0 69 0 13 0 69 0 14] 
#[0 0 34 0 4 0 20] 
#[1 0 38 0 1 0 77 0 16] 
#[0 0 42 0 4 0 20] 
#[0 0 46 0 4 0 20] 
#[0 0 81 0 1] 
#[1 0 50 0 8 0 85 0 15] 
#[0 0 89 0 8] 
#[0 0 54 0 4 0 20]
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
OlObjectAnnotationParser >> reduceActionForLabel1: nodes [
	| result |
	result := OlLabelArgumentNode new.
	result name: (nodes at: 1).
	result equals: (nodes at: 3).
	result value: (nodes at: 5).
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
OlObjectAnnotationParser >> reduceActionForSwitchToDefault1: nodes [
	self scope: #default.
	^ nil
]

{ #category : #'generated-reduction actions' }
OlObjectAnnotationParser >> reduceActionForSwitchToLabel1: nodes [
	self scope: #label.
	^ nil
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
OlObjectAnnotationParser >> reduceActionFor______bar__OptionalArgument__item__1: nodes [
	| result |
	result := Array new: 2.
	result at: 1 put: (nodes at: 1).
	result at: 2 put: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
OlObjectAnnotationParser >> reduceActionFor______bar__OptionalArgument__item___1: nodes [
	| result |
	result := Array new: 2.
	result at: 1 put: (OrderedCollection new: 2).
	result at: 2 put: (OrderedCollection new: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
OlObjectAnnotationParser >> reduceActionFor______bar__OptionalArgument__item___2: nodes [
	| result |
	result := nodes at: 1.
	self add: ((nodes at: 2) at: 1) to: (result at: 1).
	self add: ((nodes at: 2) at: 2) to: (result at: 2).
	^ result
]
