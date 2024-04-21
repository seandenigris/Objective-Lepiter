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
TOlObjectParseNodeVisitor >> visitArgument: anArgument [
	^ self visitObjectParse: anArgument
]

{ #category : #generated }
TOlObjectParseNodeVisitor >> visitExpandedArgument: anExpandedArgument [
	^ self visitArgument: anExpandedArgument
]

{ #category : #generated }
TOlObjectParseNodeVisitor >> visitLabelArgument: aLabelArgument [
	^ self visitArgument: aLabelArgument
]

{ #category : #generated }
TOlObjectParseNodeVisitor >> visitNameArgument: aNameArgument [
	^ self visitArgument: aNameArgument
]

{ #category : #generated }
TOlObjectParseNodeVisitor >> visitObjectParse: anObjectParse [
	^ self visitSmaCCParseNode: anObjectParse
]

{ #category : #generated }
TOlObjectParseNodeVisitor >> visitShowArgument: aShowArgument [
	^ self visitArgument: aShowArgument
]

{ #category : #generated }
TOlObjectParseNodeVisitor >> visitUIDArgument: anUIDArgument [
	^ self visitArgument: anUIDArgument
]
