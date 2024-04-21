Class {
	#name : #OlLepiterPage,
	#superclass : #Object,
	#instVars : [
		'databaseIdString',
		'idString'
	],
	#category : #'ObjectiveLepiter-Wrappers'
}

{ #category : #accessing }
OlLepiterPage >> database [

	self databaseId ifNil: [ ^ nil ].
	
	^ LeDatabasesRegistry defaultLogicalDatabase
		databaseWithID: self databaseId 
		ifNone: [ nil ]
]

{ #category : #accessing }
OlLepiterPage >> databaseId [

	^ databaseIdString
]

{ #category : #accessing }
OlLepiterPage >> databaseId: aString [

	databaseIdString := aString
]

{ #category : #accessing }
OlLepiterPage >> displayStringOn: aStream [

	aStream << self page title
]

{ #category : #accessing }
OlLepiterPage >> gtLiveFor: aView [
	<gtView>
	
	self page ifNil: [ ^ aView empty ].
	
	^ aView forward
		title: 'Live';
		priority: 10;
		object: [ self page ];
		view: #gtLiveFor:;
		yourself
]

{ #category : #accessing }
OlLepiterPage >> id [
	^ idString
]

{ #category : #accessing }
OlLepiterPage >> id: aString [
	idString := aString
]

{ #category : #accessing }
OlLepiterPage >> page [

	self database pageWithID: self id ifPresent: [ :s | ^ s ] ifAbsent: [ nil ].
]
