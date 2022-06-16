Trait {
	#name : #TOlObjectParseNodeVisitor,
	#traits : 'TSmaCCParseNodeVisitor',
	#classTraits : 'TSmaCCParseNodeVisitor classTrait',
	#category : #'ObjectiveLepiter-Annotation'
}

{ #category : #generated }
TOlObjectParseNodeVisitor >> visitAnnotation: anAnnotation [
	^ self visitObjectParse: anAnnotation
]

{ #category : #generated }
TOlObjectParseNodeVisitor >> visitNameValue: aNameValue [
	^ self visitObjectParse: aNameValue
]

{ #category : #generated }
TOlObjectParseNodeVisitor >> visitObjectParse: anObjectParse [
	^ self visitSmaCCParseNode: anObjectParse
]

{ #category : #generated }
TOlObjectParseNodeVisitor >> visitUIDArgument: anUIDArgument [
	^ self visitObjectParse: anUIDArgument
]
