Class {
	#name : #OlObjectPageType,
	#superclass : #LePageType,
	#instVars : [
		'subjectModelReference'
	],
	#classVars : [
		'ModelReferenceBuilder',
		'ModelReferenceBuilderMap'
	],
	#category : #'ObjectiveLepiter-Wrappers'
}

{ #category : #examples }
OlObjectPageType class >> exampleEmptyPage [
	<gtExample>
	
	| page model transcript |
	transcript := QuTranscript new.
	model := Object new.
	model stub olUID willReturn: 1.
	model stub uuid willReturn: 1.
	model stub participants willReturn: #('Jack' 'Jill').
	model stub transcript willReturn: transcript.
	self modelReferenceBuilderMap at: Object put: [OlDummyObjectUIDReferenceForTesting new
		object: model;
		uid: model uuid;
		yourself ].
	[ 
		page := LePage quTranscriptOwner: model.
	] ensure: [ self modelReferenceBuilderMap removeKey: Object ].
	LeDatabase new addPage: page.
	^ page
]

{ #category : #initialization }
OlObjectPageType class >> initialize [

	self updatePrimaryDBPageTypes
]

{ #category : #accessing }
OlObjectPageType class >> leJsonV4AttributeMapping [

	^ super leJsonV4AttributeMapping
		add: (#subjectModelReference -> #subjectModelReference);
		yourself
]

{ #category : #accessing }
OlObjectPageType class >> leJsonV4Name [

	^ 'olObjectPage'
]

{ #category : #accessing }
OlObjectPageType class >> modelReferenceBuilderMap [

	^ ModelReferenceBuilderMap ifNil: [ ModelReferenceBuilderMap := Dictionary new ]
]

{ #category : #accessing }
OlObjectPageType class >> modelReferenceBuilderMap: anObject [

	^ ModelReferenceBuilderMap := anObject
]

{ #category : #accessing }
OlObjectPageType class >> modelReferenceForClass: aClass [
	^ self modelReferenceBuilderMap 
		at: aClass
		ifAbsent: [ 
			aClass superclass
				ifNotNil: [ :supr | self modelReferenceForClass: supr ]
				ifNil: [ self error: 'no builder for ', aClass name ] ]
]

{ #category : #accessing }
OlObjectPageType class >> modelReferenceForClass: aClass builder: aValuable [
	^ self modelReferenceBuilderMap at: aClass put: aValuable
]

{ #category : #'instance creation' }
OlObjectPageType class >> subjectModel: anObject page: aLePage [
	| referenceBuilder reference |
	referenceBuilder := self modelReferenceForClass: anObject class.
	reference := referenceBuilder value
		uid: anObject olUID;
		yourself.
	^ self new
		subjectModelReference: reference;
		page: aLePage;
		yourself.
]

{ #category : #comparing }
OlObjectPageType >> = anObject [
	"Answer whether the receiver and anObject represent the same page type."

	self == anObject
		ifTrue: [ ^ true ].
	self class = anObject class
		ifFalse: [ ^ false ].
	^ self subjectModelID = anObject subjectModelID
]

{ #category : #accessing }
OlObjectPageType >> databaseKey [
	"Answer the attribute used to index a page of the receiver's type in the database."

	^ self subjectModelID
]

{ #category : #comparing }
OlObjectPageType >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ self subjectModelID hash
]

{ #category : #'api - testing' }
OlObjectPageType >> isDbObjectPageType [
	^ true
]

{ #category : #accessing }
OlObjectPageType >> pageElementClass [
	^ super pageElementClass
]

{ #category : #printing }
OlObjectPageType >> printOn: aStream [

	aStream
		<< 'Object Page: ';
		<< (self subjectModel ifNotNil: #printString ifNil: [ '<none>' ])
]

{ #category : #accessing }
OlObjectPageType >> saveEmptyPages [
	"We leave it up to the subject object to decide if/when to delete"

	^ true
]

{ #category : #accessing }
OlObjectPageType >> subjectModel [
	self subjectModelReference ifNil: [ ^ nil ].
	^ self subjectModelReference object
]

{ #category : #accessing }
OlObjectPageType >> subjectModelID [

	^ self subjectModelReference ifNotNil: [ :ref | ref uid ]
]

{ #category : #accessing }
OlObjectPageType >> subjectModelReference [

	^ subjectModelReference
]

{ #category : #accessing }
OlObjectPageType >> subjectModelReference: anMAObjectUIDReference [

	subjectModelReference := anMAObjectUIDReference
]

{ #category : #accessing }
OlObjectPageType >> title [

	^ self subjectModel 
		ifNotNil: [ :sub | sub lepiterPageTitle ]
		ifNil: [ 'Object Page' ]
]
