Extension { #name : 'DbTDomainObject' }

{ #category : '*ObjectiveLepiter' }
DbTDomainObject >> editLepiterPageDescription [
	<magritteActionDescription>
	
	^ self 
		editLepiterPageDescriptionSpawning: [ :anObject | anObject ensureLepiterPage ] 
		icon: BrGlamorousVectorIcons note  
		deemphasizedUnless: [ :obj | obj hasLepiterPage ]
		tooltip: 'View Lepiter Page'
]

{ #category : '*ObjectiveLepiter' }
DbTDomainObject >> editLepiterPageDescriptionSpawning: aValuable icon: anIconStencil deemphasizedUnless: aBooleanValuable tooltip: aString [

	| iconStencil |
	iconStencil := [ :obj |
		| elpIcon |
		elpIcon := anIconStencil create.
		(aBooleanValuable cull: obj) ifFalse: [ elpIcon background: Color veryLightGray ].
		elpIcon ] asStencil.
	
	^ MAActionDescription new
		gtAction: [ :action :anObject :desc |
			| button |
			iconStencil arguments: { anObject }.
			button := action button
				icon: iconStencil;
				tooltip: aString;
				yourself.
			button action: [ :aButton |
				| isPageMissing |
				isPageMissing := (aBooleanValuable cull: self).
				aButton phlow spawnObject: (aValuable cull: anObject).
				isPageMissing ifFalse: [ aButton phlow fireToolUpdateWish.
				self flag: 'we would like to select the new tab but don''t know how. See implementation below' ] ].
			button ];
		comment: aString;
		yourself.
		
	"Implementation note: we would like to select the new tab, but not sure how because we don't know how to track if/when the wish is fulfilled. A one second delay did not help. If we can figure out how to synchronize the tab selection with the tool update, this is how you select the tab (as discussed at https://discord.com/channels/729445214812504107/735945764597006466/1509704956825833472):
	anAction button action: [ :aButton :aTab | 
    	aTab viewContentElement tabs 
        	detect: [ :aTabModel | aTabModel tabLabel text asString = 'Transcript' ]
	        ifFound: #select ]"
]

{ #category : '*ObjectiveLepiter' }
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

{ #category : '*ObjectiveLepiter' }
DbTDomainObject >> gtViewLepiterOn: aView [
	<gtView>
	self hasLepiterPage ifFalse: [ ^ aView empty ].
	
	^ aView forward
		title: 'Lepiter' translated;
		priority: 75;
		object: [ self ensureLepiterPage ];
		view: #gtLiveFor:
]

{ #category : '*ObjectiveLepiter' }
DbTDomainObject >> hasLepiterPage [

	^ self lepiterPageID isNotNil
]

{ #category : '*ObjectiveLepiter' }
DbTDomainObject >> lepiterDB [
	^ self propertyAt: #lepiterDB ifAbsent: [ ObjectiveLepiter database ]
]

{ #category : '*ObjectiveLepiter' }
DbTDomainObject >> lepiterDB: aLeDatabase [
	self propertyAt: #lepiterDB put: aLeDatabase
]

{ #category : '*ObjectiveLepiter' }
DbTDomainObject >> lepiterPageEnsureRemoved [

	self hasLepiterPage ifFalse: [ ^ self ].
	self ensureLepiterPage removeSelf.
	self lepiterPageID: nil
]

{ #category : '*ObjectiveLepiter' }
DbTDomainObject >> lepiterPageID [
	^ self propertyAt: #lepiterPageID ifAbsent: [ ^ nil ]
]

{ #category : '*ObjectiveLepiter' }
DbTDomainObject >> lepiterPageID: aUID [
	^ self propertyAt: #lepiterPageID putRemovingNil: aUID
]

{ #category : '*ObjectiveLepiter' }
DbTDomainObject >> lepiterPageTitle [
	^ self displayString
]

{ #category : '*ObjectiveLepiter' }
DbTDomainObject >> newLepiterPage [
	^ LePage dbObject: self
]

{ #category : '*ObjectiveLepiter' }
DbTDomainObject >> olReferences [

	^ LeDatabasesRegistry uniqueInstance defaultLogicalDatabase pages select: [ :p | 
		p olObjectReferences anySatisfy: [ :node | 
			node matchesUidString36: self ensureUUID asString36 ] ]
]

{ #category : '*ObjectiveLepiter' }
DbTDomainObject >> olReferencesGtViewFor: aView [
	<gtView>
	
	self olReferences ifEmpty: [ ^ aView empty ].
	
	^ aView list
		title: 'ObjLep Refs';
		priority: 67;
		items: [ self olReferences ];
		actionUpdateButton
]

{ #category : '*ObjectiveLepiter' }
DbTDomainObject >> olUID [

	^ self ensureUUID
	
	"Implemented to have compatible interface with Lepiter snippets" 
]
