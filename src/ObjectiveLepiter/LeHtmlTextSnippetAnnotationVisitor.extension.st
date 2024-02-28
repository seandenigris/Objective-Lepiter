Extension { #name : #LeHtmlTextSnippetAnnotationVisitor }

{ #category : #'*ObjectiveLepiter' }
LeHtmlTextSnippetAnnotationVisitor >> visitOlAnnotation: anOlAnnotationNode [

	context html str: anOlAnnotationNode renderedText asString.
	^ self
]
