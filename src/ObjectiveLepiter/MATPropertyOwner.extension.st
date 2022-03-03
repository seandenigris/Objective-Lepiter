Extension { #name : #MATPropertyOwner }

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
