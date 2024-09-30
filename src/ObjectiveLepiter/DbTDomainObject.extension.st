Extension { #name : #DbTDomainObject }

{ #category : #'*ObjectiveLepiter' }
DbTDomainObject >> editLepiterPageDescription [
	<magritteActionDescription>
	
	^ self 
		editLepiterPageDescriptionSpawning: [ :anObject | anObject ensureLepiterPage ] 
		icon: BrGlamorousVectorIcons note  
		deemphasizedUnless: self hasLepiterPage
		tooltip: 'View Lepiter Page'
]

{ #category : #'*ObjectiveLepiter' }
DbTDomainObject >> editLepiterPageDescriptionSpawning: aValuable icon: anIconStencil deemphasizedUnless: aBoolean tooltip: aString [

	| iconStencil |
	iconStencil := [ 
		| elpIcon |
		elpIcon := anIconStencil create.
		aBoolean ifFalse: [ elpIcon background: Color veryLightGray ].
		elpIcon ] asStencil.
	
	^ MAActionDescription new
		gtAction: [ :action :anObject :desc |
			| button |
			button := action button
				icon: iconStencil;
				yourself.
			button action: [ :bElem |
				bElem phlow spawnObject: (aValuable cull: anObject) ].
			button ];
		comment: aString;
		yourself
]

{ #category : #'*ObjectiveLepiter' }
DbTDomainObject >> ensureLepiterPage [

	self hasLepiterPage ifFalse: [ 
		| result |
		result := self lepiterDB addPage: self newLepiterPage.
		self lepiterPageID: result uid.
		^ result ].

	self lepiterDB pageWithID: self lepiterPageID ifPresent: [ :s | ^ s ] ifAbsent: [ ].
	
	"Should never get here during normal use, but useful for e.g. testing"
	LeDatabase allSubInstances do: [ :db |
		db pageWithID: self lepiterPageID ifPresent: [  :s | ^ s ] ifAbsent: [ ]  ].
		
	^ nil
]

{ #category : #'*ObjectiveLepiter' }
DbTDomainObject >> gtViewLepiterOn: aView [
	<gtView>
	self hasLepiterPage ifFalse: [ ^ aView empty ].
	
	^ aView forward
		title: 'Lepiter' translated;
		priority: 75;
		object: [ self ensureLepiterPage ];
		view: #gtLiveFor:
]

{ #category : #'*ObjectiveLepiter' }
DbTDomainObject >> hasLepiterPage [

	^ self lepiterPageID isNotNil
]

{ #category : #'*ObjectiveLepiter' }
DbTDomainObject >> lepiterDB [
	^ self propertyAt: #lepiterDB ifAbsent: [ ObjectiveLepiter database ]
]

{ #category : #'*ObjectiveLepiter' }
DbTDomainObject >> lepiterDB: aLeDatabase [
	self propertyAt: #lepiterDB put: aLeDatabase
]

{ #category : #'*ObjectiveLepiter' }
DbTDomainObject >> lepiterPageID [
	^ self propertyAt: #lepiterPageID ifAbsent: [ ^ nil ]
]

{ #category : #'*ObjectiveLepiter' }
DbTDomainObject >> lepiterPageID: aUID [
	^ self propertyAt: #lepiterPageID putRemovingNil: aUID
]

{ #category : #'*ObjectiveLepiter' }
DbTDomainObject >> lepiterPageTitle [
	^ self displayString
]

{ #category : #'*ObjectiveLepiter' }
DbTDomainObject >> newLepiterPage [
	^ LePage dbObject: self
]

{ #category : #'*ObjectiveLepiter' }
DbTDomainObject >> olUID [

	^ self ensureUUID
	
	"Implemented to have compatible interface with Lepiter snippets" 
]
