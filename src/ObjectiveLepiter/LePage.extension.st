Extension { #name : #LePage }

{ #category : #'*ObjectiveLepiter' }
LePage class >> dbObject: anObject [
	| result type |
	result := self new.
	type := OlObjectPageType subjectModel: anObject page: result.
	^ result
		type: type;
		yourself
]
