Trait {
	#name : #OlTLepiterSubject,
	#category : #ObjectiveLepiter
}

{ #category : #'page-accessing' }
OlTLepiterSubject >> ensureLepiterPage [

	self lepiterPageID ifNil: [ 
		| result |
		result := LeDatabasesRegistry defaultPrimaryDatabase addPage: self newLepiterPage.
		self lepiterPageID: result uid.
		^ result ].

	LeDatabasesRegistry defaultPrimaryDatabase pageWithID: self lepiterPageID ifPresent: [ :s | ^ s ] ifAbsent: [ ].
	
	"Should never get here during normal use, but useful for e.g. testing"
	LeDatabase allSubInstances do: [ :db |
		db pageWithID: self lepiterPageID ifPresent: [  :s | ^ s ] ifAbsent: [ ]  ].
		
	^ nil
]

{ #category : #uuid }
OlTLepiterSubject >> ensureUUID [
	"See #uuid comment"
	 ^ self 
	 	propertyAt: #uuid
	 	ifAbsentPut: [ UUIDGenerator next ]
]

{ #category : #'page-accessing' }
OlTLepiterSubject >> lepiterPageID [
	^ self propertyAt: #lepiterPageID ifAbsent: [ ^ nil ]
]

{ #category : #'page-accessing' }
OlTLepiterSubject >> lepiterPageID: aUID [
	^ self propertyAt: #lepiterPageID put: aUID
]

{ #category : #accessing }
OlTLepiterSubject >> lepiterPageTitle [
	^ self displayString
]

{ #category : #private }
OlTLepiterSubject >> newLepiterPage [
	^ LePage dbObject: self
]

{ #category : #uuid }
OlTLepiterSubject >> uuid [
	
	 ^ self propertyAt: #uuid ifAbsent: [ nil ]
	"It is a stretch to place this in MATPropertyOwner, but it's only two methods, so in the interest of simplicity we'll put it here until someone complains"
]
