Class {
	#name : #OlObjectAnnotationNode,
	#superclass : #OlObjectParseNode,
	#instVars : [
		'items',
		'bars'
	],
	#category : #'ObjectiveLepiter-Annotation'
}

{ #category : #generated }
OlObjectAnnotationNode >> acceptVisitor: anEntityParseVisitor [

	^ anEntityParseVisitor visitEntityAnnotation: self
]

{ #category : #generated }
OlObjectAnnotationNode >> bars [

	^ bars
]

{ #category : #generated }
OlObjectAnnotationNode >> bars: anOrderedCollection [

	bars := anOrderedCollection
]

{ #category : #generated }
OlObjectAnnotationNode >> compositeNodeVariables [

	^ #( #items )
]

{ #category : #generated }
OlObjectAnnotationNode >> compositeTokenVariables [

	^ #( #bars )
]

{ #category : #'generated-initialize-release' }
OlObjectAnnotationNode >> initialize [
	super initialize.
	items := OrderedCollection new: 2.
	bars := OrderedCollection new: 2.
]

{ #category : #generated }
OlObjectAnnotationNode >> items [

	^ items
]

{ #category : #generated }
OlObjectAnnotationNode >> items: anOrderedCollection [

	self setParents: self items to: nil.
	items := anOrderedCollection.
	self setParents: self items to: self
]

{ #category : #accessing }
OlObjectAnnotationNode >> object [
	^ DbSoup detectUIDString36: self uid
]

{ #category : #accessing }
OlObjectAnnotationNode >> uid [
	^ self items
		detect: [ :e | e isKindOf: OlUIDArgumentNode ]
		ifFound: [ :uidArg | uidArg uid ]
		ifNone: [ nil ]
]
