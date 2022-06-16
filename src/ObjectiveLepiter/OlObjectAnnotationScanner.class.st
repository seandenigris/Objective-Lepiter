Class {
	#name : #OlObjectAnnotationScanner,
	#superclass : #SmaCCScanner,
	#category : #'ObjectiveLepiter-Annotation'
}

{ #category : #'generated-initialization' }
OlObjectAnnotationScanner class >> initializeKeywordMap [
	keywordMap := Dictionary new.
	#(#(6 'name' 2) #(6 'uid' 3))
		do: [ :each | 
			(keywordMap at: each first ifAbsentPut: [ Dictionary new ])
				at: (each at: 2)
				put: each last ].
	^ keywordMap
]

{ #category : #generated }
OlObjectAnnotationScanner >> emptySymbolTokenId [
	^ 14
]

{ #category : #generated }
OlObjectAnnotationScanner >> errorTokenId [
	^ 15
]

{ #category : #generated }
OlObjectAnnotationScanner >> scanForToken [
	self step.
	currentCharacter == $= ifTrue: [ ^ self recordAndReportMatch: #(1) ].
	currentCharacter == $| ifTrue: [ ^ self recordAndReportMatch: #(4) ].
	currentCharacter isUppercase
		ifTrue: [ [ self recordMatch: #(5 6).
			self step.
			currentCharacter isDigit
				ifTrue: [ [ self recordMatch: #(6).
					self step.
					currentCharacter isAlphaNumeric ] whileTrue.
					^ self reportLastMatch ].
			currentCharacter isLetter ] whileTrue.
			^ self reportLastMatch ].
	currentCharacter isAlphaNumeric
		ifTrue: [ [ self recordMatch: #(6).
			self step.
			currentCharacter isAlphaNumeric ] whileTrue ].
	^ self reportLastMatch
]
