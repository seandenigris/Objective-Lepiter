Class {
	#name : #ObjectiveLepiter,
	#superclass : #Object,
	#classVars : [
		'LepiterDB'
	],
	#category : #'ObjectiveLepiter-Support'
}

{ #category : #accessing }
ObjectiveLepiter class >> database [
	^ LepiterDB ifNil: [ LeDatabasesRegistry defaultPrimaryDatabase ]
]

{ #category : #accessing }
ObjectiveLepiter class >> database: anLeDatabase [
	LepiterDB := anLeDatabase
]
