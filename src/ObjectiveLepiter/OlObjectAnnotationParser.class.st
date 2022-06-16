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
	^'2022-06-16T16:04:37.347853-04:00'
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
	: Identifier 'identifier' (""|"" 'bar' OptionalArgument 'optionalArgument')? {{}}
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
	#(17 1 #reduceActionForName1: 668673 false) 
	#(10 1 #reduceActionForAnnotation1: 235521 false) 
	#(15 1 #liftFirstValue: 572418 false) 
	#(15 1 #liftFirstValue: 572417 false) 
	#(17 3 #reduceActionForName2: 668674 false) 
	#(16 3 #reduceActionForUID1: 602113 false) 
	#(14 0 #reduceActionForSwitchToLabel1: 525313 true) 
	#(10 3 #reduceActionForAnnotation2: 235522 false) 
	#(11 1 #liftFirstValue: 333825 false) 
	#(13 0 #reduceActionForSwitchToDefault1: 474113 true) 
	#(12 5 #reduceActionForLabel1: 363521 false)
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
	^ #('"="' '"name"' '"uid"' '"|"' '<name>' '<uid>' '<label>' '<labelText>' 'B e g i n' 'Annotation' 'OptionalArgument' 'Label' 'SwitchToDefault' 'SwitchToLabel' 'Identifier' 'UID' 'Name' 'E O F' 'error')
]

{ #category : #generated }
OlObjectAnnotationParser class >> symbolTypes [
	^ #(#SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #OlAnnotationNode #OlAnnotationNode #OlLabelArgumentNode #OlLabelArgumentNode nil nil #OlObjectParseNode #OlUIDArgumentNode #OlNameValueNode #SmaCCToken #SmaCCErrorNode)
]

{ #category : #generated }
OlObjectAnnotationParser class >> transitionTable [
^#(
#[1 0 9 0 2 0 13 0 3 0 17 0 5 0 21 0 10 0 25 0 15 0 25 0 16 0 25 0 17] 
#[0 0 37 0 1] 
#[0 0 41 0 1] 
#[0 0 6 0 4 0 18] 
#[0 0 0 0 18] 
#[1 0 45 0 4 0 10 0 18] 
#[0 0 14 0 4 0 18] 
#[0 0 18 0 4 0 18] 
#[0 0 49 0 5] 
#[0 0 53 0 6] 
#[1 0 57 0 7 0 61 0 11 0 61 0 12] 
#[0 0 22 0 4 0 18] 
#[0 0 26 0 4 0 18] 
#[1 0 30 0 1 0 69 0 14] 
#[0 0 34 0 18] 
#[0 0 38 0 18] 
#[0 0 73 0 1] 
#[1 0 42 0 8 0 77 0 13] 
#[0 0 81 0 8] 
#[0 0 46 0 18]
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
