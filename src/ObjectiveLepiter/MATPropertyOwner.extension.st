Extension { #name : #MATPropertyOwner }

{ #category : #'*ObjectiveLepiter' }
MATPropertyOwner >> clipUUID [

	 ^ Clipboard clipboardText: self ensureUUID asString36
]

{ #category : #'*ObjectiveLepiter' }
MATPropertyOwner >> clipUUIDDescription [
	<magritteActionDescription>
	
	^ MAActionDescription new
		action: #clipUUID;
		gtIcon: [ 
			BaselineOfObjectiveLepiter loadGtIconFromRepositoryPath:'icons/noun-identification-4239883.png' ];
		isLabelVisible: false;
		comment: 'Copy UUID string36 to clipboard';
		yourself
]

{ #category : #'*ObjectiveLepiter' }
MATPropertyOwner >> ensureLepiterPage [

	self lepiterPageID ifNil: [ 
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
MATPropertyOwner >> ensureUUID [
	"See #uuid comment"
	 ^ self 
	 	propertyAt: #uuid
	 	ifAbsentPut: [ UUIDGenerator next ]
]

{ #category : #'*ObjectiveLepiter' }
MATPropertyOwner >> gtViewLepiterOn: aView [
	<gtView>
	self lepiterPageID ifNil: [ ^ aView empty ].
	
	^ aView forward
		title: 'Lepiter' translated;
		priority: 75;
		object: [ self ensureLepiterPage ];
		view: #gtLiveFor:
]

{ #category : #'*ObjectiveLepiter' }
MATPropertyOwner >> lepiterDB [
	^ self propertyAt: #lepiterDB ifAbsent: [ ObjectiveLepiter database ]
]

{ #category : #'*ObjectiveLepiter' }
MATPropertyOwner >> lepiterDB: aLeDatabase [
	self propertyAt: #lepiterDB put: aLeDatabase
]

{ #category : #'*ObjectiveLepiter' }
MATPropertyOwner >> lepiterPageID [
	^ self propertyAt: #lepiterPageID ifAbsent: [ ^ nil ]
]

{ #category : #'*ObjectiveLepiter' }
MATPropertyOwner >> lepiterPageID: aUID [
	^ self propertyAt: #lepiterPageID put: aUID
]

{ #category : #'*ObjectiveLepiter' }
MATPropertyOwner >> lepiterPageTitle [
	^ self displayString
]

{ #category : #'*ObjectiveLepiter' }
MATPropertyOwner >> newLepiterPage [
	^ LePage dbObject: self
]

{ #category : #'*ObjectiveLepiter' }
MATPropertyOwner >> uuid [
	
	 ^ self propertyAt: #uuid ifAbsent: [ nil ]
	"It is a stretch to place this in MATPropertyOwner, but it's only two methods, so in the interest of simplicity we'll put it here until someone complains"
]
