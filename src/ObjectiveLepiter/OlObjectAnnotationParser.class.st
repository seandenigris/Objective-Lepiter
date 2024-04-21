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

{ #category : #accessing }
OlObjectAnnotationParser class >> argumentNames [
	"For e.g. completion"
	^ #(name uid label expanded show)
]

{ #category : #'generated-accessing' }
OlObjectAnnotationParser class >> cacheId [
	^'2024-04-21T00:04:07.079853-04:00'
]

{ #category : #generated }
OlObjectAnnotationParser class >> definitionComment [
"%glr;
%root ObjectParse;
%prefix Ol;
%suffix Node;

%scopes default label uid;

%hierarchy Argument (
	ExpandedArgument
	LabelArgument
	NameArgument
	ShowArgument
	UIDArgument
);

uid <uid>
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
default <expanded>
	: expanded
	;
default <boolean>
	: true 
	| false
	;
default <show>
	: show
	;
<unarySelector>
	: (<isLetter> | _ ) ( <isLetter> | _ | <isDigit> ) *
	;
<binarySelector>
	: ([\~\-\!\@\%\&\*\+\=\?\/\>\<\,] |(\\ [\~\-\!\@\%\&\*\+\=\\\|\?\/\>\<\,])) +
	;
<keywordSelector>
	: (<unarySelector> \:)+
	;
default <selector>
	: \#? <unarySelector>
	| \#? <binarySelector>
	| \#? <keywordSelector>
	;
Annotation 
	: Identifier 'identifier' (""|"" 'bar' OptionalArgument 'optionalArgument')+ {{}}
	| Identifier 'identifier' {{}}
	;
OptionalArgument
	: Label
	| Expanded
	| Show
	;
Show
	: ""show"" 'name' ""="" 'equals' <selector> 'value' {{ShowArgument}}
	;
Expanded
	: <expanded> 'name' OptionalBooleanValue {{ExpandedArgument}}
	;
OptionalBooleanValue
	: (""="" 'equals' <boolean> 'value')?
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
	:""uid"" 'name' SwitchToUid ""="" 'equals' SwitchToDefault <uid> 'value' {{UIDArgument}}
	;
SwitchToUid
	: [self scope: #uid. nil]
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
	#(22 0 #reduceActionForSwitchToLabel1: 1306625 true) 
	#(25 0 #reduceActionForSwitchToUid1: 1478657 true) 
	#(13 1 #reduceActionForAnnotation2: 741378 false) 
	#(23 1 #liftFirstValue: 1353730 false) 
	#(23 1 #liftFirstValue: 1353729 false) 
	#(15 1 #reduceActionFor______bar__OptionalArgument__optionalArgument___1: 781313 false) 
	#(13 2 #reduceActionForAnnotation1: 741377 false) 
	#(21 0 #reduceActionForSwitchToDefault1: 1255425 true) 
	#(19 0 #reduceActionForOptionalBooleanValue1: 1075201 false) 
	#(14 2 #reduceActionFor______bar__OptionalArgument__optionalArgument__1: 781313 false) 
	#(16 1 #liftFirstValue: 872451 false) 
	#(16 1 #liftFirstValue: 872450 false) 
	#(16 1 #liftFirstValue: 872449 false) 
	#(15 2 #reduceActionFor______bar__OptionalArgument__optionalArgument___2: 781314 false) 
	#(18 2 #reduceActionForExpanded1: 998401 false) 
	#(26 5 #reduceActionForName1: 1521665 false) 
	#(24 5 #reduceActionForUID1: 1383425 false) 
	#(17 3 #reduceActionForShow1: 922625 false) 
	#(19 2 #reduceActionFor______bar__OptionalArgument__optionalArgument__1: 1075202 false) 
	#(20 5 #reduceActionForLabel1: 1137665 false)
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
	^ #('"="' '"name"' '"show"' '"uid"' '"|"' '<uid>' '<labelKeyword>' '<labelText>' '<expanded>' '<boolean>' '<selector>' 'B e g i n' 'Annotation' '("|" ''bar'' OptionalArgument ''optionalArgument'')' '("|" ''bar'' OptionalArgument ''optionalArgument'')+' 'OptionalArgument' 'Show' 'Expanded' 'OptionalBooleanValue' 'Label' 'SwitchToDefault' 'SwitchToLabel' 'Identifier' 'UID' 'SwitchToUid' 'Name' 'E O F' 'error')
]

{ #category : #generated }
OlObjectAnnotationParser class >> symbolTypes [
	^ #(#SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #OlAnnotationNode #OlAnnotationNode #OrderedCollection #OrderedCollection #OlArgumentNode #OlShowArgumentNode #OlExpandedArgumentNode #OrderedCollection #OlLabelArgumentNode nil nil #OlArgumentNode #OlUIDArgumentNode nil #OlNameArgumentNode #SmaCCToken #SmaCCErrorNode)
]

{ #category : #generated }
OlObjectAnnotationParser class >> transitionTable [
^#(
#[1 0 9 0 2 0 13 0 4 0 17 0 13 0 21 0 23 0 21 0 24 0 21 0 26] 
#[1 0 6 0 1 0 33 0 22] 
#[1 0 10 0 1 0 37 0 25] 
#[0 0 0 0 27] 
#[1 0 41 0 5 0 45 0 14 0 49 0 15 0 14 0 27] 
#[0 0 18 0 5 0 27] 
#[0 0 22 0 5 0 27] 
#[0 0 53 0 1] 
#[0 0 57 0 1] 
#[1 0 61 0 3 0 65 0 7 0 69 0 9 0 73 0 16 0 73 0 17 0 73 0 18 0 73 0 20] 
#[0 0 26 0 5 0 27] 
#[1 0 41 0 5 0 89 0 14 0 30 0 27] 
#[1 0 34 0 8 0 93 0 21] 
#[1 0 34 0 6 0 97 0 21] 
#[0 0 101 0 1] 
#[1 0 6 0 1 0 105 0 22] 
#[1 0 109 0 1 0 38 0 5 0 113 0 19 0 38 0 27] 
#[0 0 42 0 5 0 27] 
#[0 0 46 0 5 0 27] 
#[0 0 50 0 5 0 27] 
#[0 0 54 0 5 0 27] 
#[0 0 58 0 5 0 27] 
#[0 0 117 0 8] 
#[0 0 121 0 6] 
#[0 0 125 0 11] 
#[0 0 129 0 1] 
#[0 0 133 0 10] 
#[0 0 62 0 5 0 27] 
#[0 0 66 0 5 0 27] 
#[0 0 70 0 5 0 27] 
#[0 0 74 0 5 0 27] 
#[1 0 34 0 8 0 137 0 21] 
#[0 0 78 0 5 0 27] 
#[0 0 141 0 8] 
#[0 0 82 0 5 0 27]
	).
]

{ #category : #'generated-reduction actions' }
OlObjectAnnotationParser >> reduceActionForAnnotation1: nodes [
	| result |
	result := OlAnnotationNode new.
	result identifier: (nodes at: 1).
	result addTokens: ((nodes at: 2) at: 1) to: result bars.
	result addNodes: ((nodes at: 2) at: 2) to: result optionalArguments.
	^ result
]

{ #category : #'generated-reduction actions' }
OlObjectAnnotationParser >> reduceActionForAnnotation2: nodes [
	| result |
	result := OlAnnotationNode new.
	result identifier: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
OlObjectAnnotationParser >> reduceActionForExpanded1: nodes [
	| result |
	result := OlExpandedArgumentNode new.
	result name: (nodes at: 1).
	result equals: ((nodes at: 2) at: 1).
	result value: ((nodes at: 2) at: 2).
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
OlObjectAnnotationParser >> reduceActionForOptionalBooleanValue1: nodes [
	| result |
	result := Array new: 2.
	^ result
]

{ #category : #'generated-reduction actions' }
OlObjectAnnotationParser >> reduceActionForShow1: nodes [
	| result |
	result := OlShowArgumentNode new.
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
OlObjectAnnotationParser >> reduceActionForSwitchToUid1: nodes [
	self scope: #uid.
	^ nil
]

{ #category : #'generated-reduction actions' }
OlObjectAnnotationParser >> reduceActionForUID1: nodes [
	| result |
	result := OlUIDArgumentNode new.
	result name: (nodes at: 1).
	result equals: (nodes at: 3).
	result value: (nodes at: 5).
	^ result
]

{ #category : #'generated-reduction actions' }
OlObjectAnnotationParser >> reduceActionFor______bar__OptionalArgument__optionalArgument__1: nodes [
	| result |
	result := Array new: 2.
	result at: 1 put: (nodes at: 1).
	result at: 2 put: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
OlObjectAnnotationParser >> reduceActionFor______bar__OptionalArgument__optionalArgument___1: nodes [
	| result |
	result := Array new: 2.
	result at: 1 put: (OrderedCollection new: 2).
	result at: 2 put: (OrderedCollection new: 2).
	self add: ((nodes at: 1) at: 1) to: (result at: 1).
	self add: ((nodes at: 1) at: 2) to: (result at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
OlObjectAnnotationParser >> reduceActionFor______bar__OptionalArgument__optionalArgument___2: nodes [
	| result |
	result := nodes at: 1.
	self add: ((nodes at: 2) at: 1) to: (result at: 1).
	self add: ((nodes at: 2) at: 2) to: (result at: 2).
	^ result
]
