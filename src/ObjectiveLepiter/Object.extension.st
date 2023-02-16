Extension { #name : #Object }

{ #category : #'*ObjectiveLepiter' }
Object >> olAsReference [
	"Needed for Lepiter artifacts, like snippets and pages, because we can't directly hold pointers to them. For example, doing so stalls Fuel while it drags in half of GT, and the pointers would not be valid in another image"

	^ self
]
