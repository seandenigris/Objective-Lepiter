Class {
	#name : #OlAnnotationNode,
	#superclass : #OlObjectParseNode,
	#instVars : [
		'identifier',
		'bars',
		'optionalArguments'
	],
	#category : #'ObjectiveLepiter-Annotation'
}

{ #category : #generated }
OlAnnotationNode >> acceptVisitor: anObjectParseVisitor [
	^ anObjectParseVisitor visitAnnotation: self
]

{ #category : #generated }
OlAnnotationNode >> bars [
	^ bars
]

{ #category : #generated }
OlAnnotationNode >> bars: anOrderedCollection [
	bars := anOrderedCollection
]

{ #category : #generated }
OlAnnotationNode >> compositeNodeVariables [
	^ #(#optionalArguments)
]

{ #category : #generated }
OlAnnotationNode >> compositeTokenVariables [
	^ #(#bars)
]

{ #category : #accessing }
OlAnnotationNode >> expanded [

	^ self optionalArguments 
		detect: [ :each | each isExpanded ] 
		ifFound: [ :e | e booleanValue ]
		ifNone: [ self expandedDefault ]
]

{ #category : #accessing }
OlAnnotationNode >> expandedDefault [
	^ false
]

{ #category : #accessing }
OlAnnotationNode >> hasUID [
	^ self uid isNotNil
]

{ #category : #generated }
OlAnnotationNode >> identifier [
	^ identifier
]

{ #category : #generated }
OlAnnotationNode >> identifier: anOlArgumentNode [
	self identifier notNil ifTrue: [ self identifier parent: nil ].
	identifier := anOlArgumentNode.
	self identifier notNil ifTrue: [ self identifier parent: self ]
]

{ #category : #'generated-initialize-release' }
OlAnnotationNode >> initialize [
	super initialize.
	bars := OrderedCollection new: 2.
	optionalArguments := OrderedCollection new: 2.
]

{ #category : #accessing }
OlAnnotationNode >> isExpanded [
	^ self attributeNamed: #isExpanded ifAbsent: [ self expanded ]
]

{ #category : #accessing }
OlAnnotationNode >> label [
	^ self labelNode ifNotNil: [ :arg | arg text ]
]

{ #category : #accessing }
OlAnnotationNode >> labelNode [
	^ self optionalArguments 
		detect: [ :each | each isLabel ] 
		ifNone: [ nil ]
]

{ #category : #generated }
OlAnnotationNode >> nodeVariables [
	^ #(#identifier)
]

{ #category : #accessing }
OlAnnotationNode >> object [
	^ DbSoup detectUID: self uid ifNone: [ nil ]
]

{ #category : #generated }
OlAnnotationNode >> optionalArguments [
	^ optionalArguments
]

{ #category : #generated }
OlAnnotationNode >> optionalArguments: anOrderedCollection [
	self setParents: self optionalArguments to: nil.
	optionalArguments := anOrderedCollection.
	self setParents: self optionalArguments to: self
]

{ #category : #accessing }
OlAnnotationNode >> renderedText [
	self label ifNotNil: [ :lbl | ^ lbl ].
	
	^ self object
		ifNotNil: [ :obj | obj displayString asRopedText ]
		ifNil: [ ('uid=', self uid) asRopedText ].
]

{ #category : #accessing }
OlAnnotationNode >> showNode [
	^ self optionalArguments 
		detect: [ :each | each isShow ] 
		ifNone: [ nil ]
]

{ #category : #accessing }
OlAnnotationNode >> showSelector [
	^ self showNode ifNotNil: [ :node | node selectorValue ]
]

{ #category : #accessing }
OlAnnotationNode >> uid [
	^ self identifier uid
]
