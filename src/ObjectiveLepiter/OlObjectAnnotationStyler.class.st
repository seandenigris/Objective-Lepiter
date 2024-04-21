Class {
	#name : #OlObjectAnnotationStyler,
	#superclass : #LeComponentStyler,
	#traits : 'TOlObjectParseNodeVisitor',
	#classTraits : 'TOlObjectParseNodeVisitor classTrait',
	#category : #'ObjectiveLepiter-Annotation'
}

{ #category : #accessing }
OlObjectAnnotationStyler class >> activate [
	LeSnippetStylerVisitor additionalStylers add: self
]

{ #category : #accessing }
OlObjectAnnotationStyler class >> obsolete [
	LeSnippetStylerVisitor additionalStylers remove: self ifAbsent: [  ].
	^ super obsolete
]

{ #category : #accessing }
OlObjectAnnotationStyler >> elements [
	^ self composite elements
]

{ #category : #accessing }
OlObjectAnnotationStyler >> expanded [
	^ self composite expanded
]

{ #category : #private }
OlObjectAnnotationStyler >> renderedAttributeLabeled: aRopedText withAction: aBlock isValid: aBoolean [

	^ GtButtonAttribute new
		beAppend;
		stencil: [ 
			| button |
			button := LeSnippetStylerVisitor 
				textLinkButtonPadding: (BlInsets top: 2) 
				margin: BlInsets empty
				valid: aBoolean.
			button aptitude glamorousCodeFont.
			button
				beSmallSize;
				label: aRopedText;
				action: aBlock;
				yourself ]
]

{ #category : #private }
OlObjectAnnotationStyler >> styleAutoHiding: anAnnotation [
	"Add styling that hides the markup when it loses keyboard focus"
	| first last range |
	"anAnnotation hasWordSpecified ifFalse: [ ^ self ]."
	first := anAnnotation parent startPosition max: 1.
	last := anAnnotation parent stopPosition min: self composite text size.
	range := first to: last.
	composite
		styleAutoHiding: range
		and: range
		whenOutside: anAnnotation parent sourceInterval 
]

{ #category : #accessing }
OlObjectAnnotationStyler >> styleExpandingObject: anAnnotation [

	| cacheKey attribute |
	
	anAnnotation showNode ifNil: [ ^ self ].
	
	cacheKey := anAnnotation source.
	attribute := (GtCachedTextExpandButtonAttribute new)
		isExpanded: (self expanded at: cacheKey ifAbsentPut: [ anAnnotation isExpanded ]);
		attributesCreatingBlock:
				[ (GtResizablePreviewAttribute new)
						withCache: self elements key: cacheKey;
						result: anAnnotation object;
						showSelector: anAnnotation showSelector";
						height: anAnnotation height" ];
		onCachingDo: [ :aBoolean :theAttribute | self expanded at: cacheKey put: aBoolean ].
	self text
		attribute: attribute
		from: anAnnotation parent startPosition
		to: anAnnotation parent stopPosition
]

{ #category : #private }
OlObjectAnnotationStyler >> styleMarkup: anAnnotation [
	self utility
		subtleMarkupsInText: self text
		start: anAnnotation parent startPosition
		stop: anAnnotation parent stopPosition
]

{ #category : #private }
OlObjectAnnotationStyler >> styleRendered: anAnnotation [
	"Add styling for the (in this case clickable) rendered markup"
	| attribute |
	
	attribute := anAnnotation object
		ifNotNil: [ :obj | 
			self 
				renderedAttributeLabeled: anAnnotation renderedText
				withAction: [ :aButton | aButton phlow spawnObject: anAnnotation object ]
				isValid: true ]
		ifNil: [
			self 
				renderedAttributeLabeled: anAnnotation renderedText
				withAction: [ :aButton | ]
				isValid: false ].
	
	self composite text
		attribute: attribute
		from: anAnnotation parent startPosition
		to: anAnnotation parent stopPosition
]

{ #category : #accessing }
OlObjectAnnotationStyler >> text [
	^ self composite text
]

{ #category : #accessing }
OlObjectAnnotationStyler >> utility [
	^ GtDocumentUtility
]

{ #category : #accessing }
OlObjectAnnotationStyler >> visitAnnotation: anAnnotation [
"Halt now."
	self styleMarkup: anAnnotation.
	self styleAutoHiding: anAnnotation.
	self styleRendered: anAnnotation.
	self styleExpandingObject: anAnnotation
]
