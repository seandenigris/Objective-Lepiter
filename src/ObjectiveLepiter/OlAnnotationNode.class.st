Class {
	#name : #OlAnnotationNode,
	#superclass : #OlObjectParseNode,
	#instVars : [
		'items',
		'bars'
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

	^ #( #items )
]

{ #category : #generated }
OlAnnotationNode >> compositeTokenVariables [

	^ #( #bars )
]

{ #category : #'generated-initialize-release' }
OlAnnotationNode >> initialize [
	super initialize.
	items := OrderedCollection new: 2.
	bars := OrderedCollection new: 2.
]

{ #category : #generated }
OlAnnotationNode >> items [

	^ items
]

{ #category : #generated }
OlAnnotationNode >> items: anOrderedCollection [

	self setParents: self items to: nil.
	items := anOrderedCollection.
	self setParents: self items to: self
]

{ #category : #accessing }
OlAnnotationNode >> object [
	^ DbSoup detectUIDString36: self uid
]

{ #category : #accessing }
OlAnnotationNode >> uid [
	^ self items
		detect: [ :e | e isKindOf: OlUIDArgumentNode ]
		ifFound: [ :uidArg | uidArg uid ]
		ifNone: [ nil ]
]
