Extension { #name : 'BaselineOf' }

{ #category : '*ObjectiveLepiter' }
BaselineOf >> olBuildReferenceMap [

	self dbReferenceBuilderMap keysAndValuesDo: [ :aClass :aBlock |
		OlObjectPageType 
			modelReferenceForClass: aClass 
			builder: aBlock. ].
]
