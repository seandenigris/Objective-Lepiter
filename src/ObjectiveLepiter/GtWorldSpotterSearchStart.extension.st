Extension { #name : #GtWorldSpotterSearchStart }

{ #category : #'*ObjectiveLepiter' }
GtWorldSpotterSearchStart >> gtSpotterContainingSubPartsFor: aSearch [
	"<gtSearch>"
	
	self hasKnowledgeBase ifFalse: [ ^ self ].
	self hasChildren ifFalse: [ ^ self ].
	
	^ aSearch list
		priority: 23;
		title: 'Pages';
		wantsToDisplayOnEmptyQuery: true;
		filter: LeSubstringFilter
			item: [ :filter :context | 
				self knowledgeBase pagesWithNameDo: filter.
				self knowledgeBase unnamedPagesDo: filter.
				"self knowledgeBase pagesDo: filter" ];
		itemName: #spotterItemName 
]
