Trait {
	#name : #TOlObjectParseNodeVisitor,
	#traits : 'TSmaCCParseNodeVisitor',
	#classTraits : 'TSmaCCParseNodeVisitor classTrait',
	#category : #'ObjectiveLepiter-Annotation'
}

{ #category : #generated }
TOlObjectParseNodeVisitor >> visitEntityAnnotation: anEntityAnnotation [

	^ self visitEntityParse: anEntityAnnotation
]

{ #category : #generated }
TOlObjectParseNodeVisitor >> visitEntityParse: anEntityParse [

	^ self visitSmaCCParseNode: anEntityParse
]

{ #category : #generated }
TOlObjectParseNodeVisitor >> visitNameValue: aNameValue [

	^ self visitEntityParse: aNameValue
]

{ #category : #generated }
TOlObjectParseNodeVisitor >> visitUIDArgument: anUIDArgument [
	^ self visitEntityParse: anUIDArgument
]
