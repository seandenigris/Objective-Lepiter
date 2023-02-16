Class {
	#name : #OlLepiterSnippet,
	#superclass : #Object,
	#instVars : [
		'databaseIdString',
		'idString'
	],
	#category : #ObjectiveLepiter
}

{ #category : #accessing }
OlLepiterSnippet >> database [

	self databaseId ifNil: [ ^ nil ].
	
	^ LeDatabasesRegistry defaultLogicalDatabase
		databaseWithID: self databaseId 
		ifNone: [ nil ]
]

{ #category : #accessing }
OlLepiterSnippet >> databaseId [

	^ databaseIdString
]

{ #category : #accessing }
OlLepiterSnippet >> databaseId: aString [

	databaseIdString := aString
]

{ #category : #accessing }
OlLepiterSnippet >> displayStringOn: aStream [

	aStream << self snippet contentAsString
]

{ #category : #accessing }
OlLepiterSnippet >> gtLiveFor: aView [
	<gtView>
	
	self snippet ifNil: [ ^ aView empty ].
	
	^ aView forward
		title: 'Live';
		priority: 10;
		object: [ self snippet ];
		view: #gtLiveFor:;
		yourself
]

{ #category : #accessing }
OlLepiterSnippet >> gtPageFor: aView [
	<gtView>
	
	self snippet ifNil: [ ^ aView empty ].
	
	^ aView forward
		title: 'Page';
		priority: 10;
		object: [ self snippet page ];
		view: #gtLiveFor:;
		yourself
]

{ #category : #accessing }
OlLepiterSnippet >> id [
	^ idString
]

{ #category : #accessing }
OlLepiterSnippet >> id: aString [
	idString := aString
]

{ #category : #accessing }
OlLepiterSnippet >> snippet [

	self database blockWithUID: self id ifPresent: [ :s | ^ s ] ifAbsent: [ nil ].
]
