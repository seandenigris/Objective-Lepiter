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
OlObjectAnnotationStyler class >> initialize [
	self activate
]

{ #category : #accessing }
OlObjectAnnotationStyler class >> obsolete [
	LeSnippetStylerVisitor additionalStylers remove: self ifAbsent: [  ].
	^ super obsolete
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
	"anAnnotation hasWordSpecified ifFalse: [ ^ self ]."
	
	attribute := (GtButtonAttribute new)
		beAppend;
		stencil:
				[ | button label |
					label := anAnnotation object displayString.
					button := LeSnippetStylerVisitor textLinkButtonPadding: (BlInsets top: 2) margin: BlInsets empty.
					button aptitude glamorousCodeFont.
					button
						beSmallSize;
						label: label;
						action: [ :aButton | aButton phlow spawnObject: anAnnotation object ].
					button ].
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

{ #category : #generated }
OlObjectAnnotationStyler >> visitEntityAnnotation: anAnnotation [
	self styleMarkup: anAnnotation.
	self styleAutoHiding: anAnnotation.
	self styleRendered: anAnnotation
]
