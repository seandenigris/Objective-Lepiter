Class {
	#name : #ObjectiveLepiter,
	#superclass : #Object,
	#classVars : [
		'LepiterDB'
	],
	#category : #ObjectiveLepiter
}

{ #category : #accessing }
ObjectiveLepiter class >> lepiterDB [
	^ LepiterDB ifNil: [ LeDatabasesRegistry defaultPrimaryDatabase ]
]

{ #category : #accessing }
ObjectiveLepiter class >> lepiterDB: anLeDatabase [
	LepiterDB := anLeDatabase
]
