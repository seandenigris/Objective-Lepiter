Extension { #name : #GtWorldSpotterSearchStart }

{ #category : #'*ObjectiveLepiter' }
GtWorldSpotterSearchStart >> gtSpotterContainingSubPartsFor: aStep [
	<gtSearch>
	self hasKnowledgeBase ifFalse: [ ^ self ].
	self hasChildren ifFalse: [ ^ self ].
	
	aStep listProcessor
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
