Class {
	#name : #OlAnnotationNode,
	#superclass : #OlObjectParseNode,
	#instVars : [
		'identifier',
		'bar',
		'optionalArgument'
	],
	#category : #'ObjectiveLepiter-Annotation'
}

{ #category : #generated }
OlAnnotationNode >> acceptVisitor: anObjectParseVisitor [
	^ anObjectParseVisitor visitOlAnnotation: self
]

{ #category : #generated }
OlAnnotationNode >> bar [
	^ bar
]

{ #category : #generated }
OlAnnotationNode >> bar: aSmaCCToken [
	bar := aSmaCCToken
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

{ #category : #accessing }
OlAnnotationNode >> label [
	^ self optionalArgument ifNotNil: [ :arg | arg text ]
]

{ #category : #generated }
OlAnnotationNode >> nodeVariables [
	^ #(#identifier #optionalArgument)
]

{ #category : #accessing }
OlAnnotationNode >> object [
	^ DbSoup detectUID: self uid ifNone: [ nil ]
]

{ #category : #generated }
OlAnnotationNode >> optionalArgument [
	^ optionalArgument
]

{ #category : #generated }
OlAnnotationNode >> optionalArgument: anOlLabelArgumentNode [
	self optionalArgument notNil ifTrue: [ self optionalArgument parent: nil ].
	optionalArgument := anOlLabelArgumentNode.
	self optionalArgument notNil ifTrue: [ self optionalArgument parent: self ]
]

{ #category : #accessing }
OlAnnotationNode >> renderedText [
	self label ifNotNil: [ :lbl | ^ lbl ].
	
	^ self object
		ifNotNil: [ :obj | obj displayString asRopedText ]
		ifNil: [ ('uid=', self uid) asRopedText ].
]

{ #category : #generated }
OlAnnotationNode >> tokenVariables [
	^ #(#bar)
]

{ #category : #accessing }
OlAnnotationNode >> uid [
	^ self identifier uid
]
