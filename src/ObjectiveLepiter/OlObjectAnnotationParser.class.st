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
	^'2022-06-16T21:19:16.741827-04:00'
]

{ #category : #generated }
OlObjectAnnotationParser class >> definitionComment [
"%glr;
%root ObjectParse;
%prefix Ol;
%suffix Node;

%scopes default label;

%hierarchy Argument (
	LabelArgument
	NameArgument
	UIDArgument
);

default <uid>
	: (<isLetter> | <isDigit>)+
	;
default <labelKeyword>
	: label
	;
default <eq>
	: \=
	;
label <labelText>
	: [^\|\}]+
	;
Annotation 
	: Identifier 'identifier' (""|"" 'bar' OptionalArgument 'optionalArgument')? {{}}
	;
OptionalArgument
	: Label
	;
Label
	: <labelKeyword> 'name' SwitchToLabel ""="" 'equals' SwitchToDefault <labelText> 'value' {{LabelArgument}}
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
	: ""name"" 'name' SwitchToLabel ""="" 'equals' SwitchToDefault <labelText> 'value' {{NameArgument}}
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
	#(13 0 #reduceActionForSwitchToLabel1: 584705 true) 
	#(9 1 #reduceActionForAnnotation1: 287745 false) 
	#(14 1 #liftFirstValue: 631810 false) 
	#(14 1 #liftFirstValue: 631809 false) 
	#(12 0 #reduceActionForSwitchToDefault1: 533505 true) 
	#(15 3 #reduceActionForUID1: 661505 false) 
	#(9 3 #reduceActionForAnnotation2: 287746 false) 
	#(10 1 #liftFirstValue: 386049 false) 
	#(16 5 #reduceActionForName1: 728065 false) 
	#(11 5 #reduceActionForLabel1: 415745 false)
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
	^ #('"="' '"name"' '"uid"' '"|"' '<uid>' '<labelKeyword>' '<labelText>' 'B e g i n' 'Annotation' 'OptionalArgument' 'Label' 'SwitchToDefault' 'SwitchToLabel' 'Identifier' 'UID' 'Name' 'E O F' 'error')
]

{ #category : #generated }
OlObjectAnnotationParser class >> symbolTypes [
	^ #(#SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #OlAnnotationNode #OlAnnotationNode #OlLabelArgumentNode #OlLabelArgumentNode nil nil #OlArgumentNode #OlUIDArgumentNode #OlNameArgumentNode #SmaCCToken #SmaCCErrorNode)
]

{ #category : #generated }
OlObjectAnnotationParser class >> transitionTable [
^#(
#[1 0 9 0 2 0 13 0 3 0 17 0 9 0 21 0 14 0 21 0 15 0 21 0 16] 
#[1 0 6 0 1 0 33 0 13] 
#[0 0 37 0 1] 
#[0 0 0 0 17] 
#[1 0 41 0 4 0 10 0 17] 
#[0 0 14 0 4 0 17] 
#[0 0 18 0 4 0 17] 
#[0 0 45 0 1] 
#[0 0 49 0 5] 
#[1 0 53 0 6 0 57 0 10 0 57 0 11] 
#[1 0 22 0 7 0 65 0 12] 
#[0 0 26 0 4 0 17] 
#[1 0 6 0 1 0 69 0 13] 
#[0 0 30 0 17] 
#[0 0 34 0 17] 
#[0 0 73 0 7] 
#[0 0 77 0 1] 
#[0 0 38 0 4 0 17] 
#[1 0 22 0 7 0 81 0 12] 
#[0 0 85 0 7] 
#[0 0 42 0 17]
	).
]

{ #category : #'generated-reduction actions' }
OlObjectAnnotationParser >> reduceActionForAnnotation1: nodes [
	| result |
	result := OlAnnotationNode new.
	result identifier: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
OlObjectAnnotationParser >> reduceActionForAnnotation2: nodes [
	| result |
	result := OlAnnotationNode new.
	result identifier: (nodes at: 1).
	result bar: (nodes at: 2).
	result optionalArgument: (nodes at: 3).
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
	result := OlNameArgumentNode new.
	result name: (nodes at: 1).
	result equals: (nodes at: 3).
	result value: (nodes at: 5).
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
