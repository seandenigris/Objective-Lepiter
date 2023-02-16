Extension { #name : #LeSnippet }

{ #category : #'*ObjectiveLepiter' }
LeSnippet >> olAsReference [

	^ OlLepiterSnippet new
		databaseId: self database uuid asString36;
		id: self uid;
		yourself
]

{ #category : #'*ObjectiveLepiter' }
LeSnippet >> olUID [
	
	^ self uid
]
