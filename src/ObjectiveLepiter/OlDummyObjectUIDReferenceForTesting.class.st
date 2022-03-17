Class {
	#name : #OlDummyObjectUIDReferenceForTesting,
	#superclass : #OlObjectUIDReference,
	#instVars : [
		'source',
		'object'
	],
	#category : #ObjectiveLepiter
}

{ #category : #accessing }
OlDummyObjectUIDReferenceForTesting >> object [

	^ object ifNil: [  self source detect: [ :e | e uuid = self uid ] ]
]

{ #category : #accessing }
OlDummyObjectUIDReferenceForTesting >> object: anObject [

	object := anObject
]

{ #category : #accessing }
OlDummyObjectUIDReferenceForTesting >> source [

	^ source ifNil: [ { object } ]
]

{ #category : #accessing }
OlDummyObjectUIDReferenceForTesting >> source: anObject [

	source := anObject
]
