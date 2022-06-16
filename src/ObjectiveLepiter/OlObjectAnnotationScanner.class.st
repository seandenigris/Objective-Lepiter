Class {
	#name : #OlObjectAnnotationScanner,
	#superclass : #SmaCCScanner,
	#category : #'ObjectiveLepiter-Annotation'
}

{ #category : #'generated-initialization' }
OlObjectAnnotationScanner class >> initializeKeywordMap [
	keywordMap := Dictionary new.
	#(#(6 'label' #(7 #(#default #lab))) #(6 'name' #(2 #(#default #lab))) #(6 'uid' #(3 #(#default #lab))))
		do: [ :each | 
			(keywordMap at: each first ifAbsentPut: [ Dictionary new ])
				at: (each at: 2)
				put: each last ].
	^ keywordMap
]

{ #category : #generated }
OlObjectAnnotationScanner >> emptySymbolTokenId [
	^ 18
]

{ #category : #generated }
OlObjectAnnotationScanner >> errorTokenId [
	^ 19
]

{ #category : #generated }
OlObjectAnnotationScanner >> scanForToken [
	scope == #label
		ifTrue: [ self step.
			(currentCharacter <= $[
				or: [ (currentCharacter between: $] and: ${) or: [ currentCharacter >= $~ ] ])
				ifTrue: [ [ self recordMatch: #(8).
					self step.
					currentCharacter <= $[
						or: [ (currentCharacter between: $] and: ${) or: [ currentCharacter >= $~ ] ] ]
						whileTrue ].
			^ self reportLastMatch ].
	(#(#default #lab) includes: scope)
		ifTrue: [ self step.
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
					currentCharacter isAlphaNumeric ] whileTrue ] ].
	^ self reportLastMatch
]
