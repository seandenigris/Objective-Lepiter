Extension { #name : 'LePage' }

{ #category : '*ObjectiveLepiter' }
LePage class >> dbObject: anObject [
	| result type |
	result := self new.
	type := OlObjectPageType subjectModel: anObject page: result.
	^ result
		type: type;
		yourself
]

{ #category : '*ObjectiveLepiter' }
LePage >> olAsReference [

	^ OlLepiterPage new
		databaseId: self database uuid asString36;
		id: self uid asString36;
		yourself
]

{ #category : '*ObjectiveLepiter' }
LePage >> olObject [

	self type isDbObjectPageType ifFalse: [ ^ nil ].
	
	^ self type subjectModel
]

{ #category : '*ObjectiveLepiter' }
LePage >> olObjectGtViewFor: aView [
  <gtView>
  
  self type isDbObjectPageType ifFalse: [ ^ aView empty ].
  
  ^ aView forward
      title: 'Object (OL)';
      priority: 5;
      object: [ self type ];
      view: #subjectModelGtViewFor:inContext:
]

{ #category : '*ObjectiveLepiter' }
LePage >> olObjectReferences [
	^ self allChildrenTextSnippets
		flatCollect: [ :aTextSnippet | aTextSnippet ast // OlAnnotationNode ]
]
