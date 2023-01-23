Extension { #name : #ByteString }

{ #category : #'*ObjectiveLepiter' }
ByteString >> olDetectUIDBlock [

	^ [ :uid | uid asString36 = self ]
]
