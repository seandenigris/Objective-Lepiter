Class {
	#name : #OlObjectAnnotationScanner,
	#superclass : #SmaCCScanner,
	#category : #'ObjectiveLepiter-Annotation'
}

{ #category : #'generated-initialization' }
OlObjectAnnotationScanner class >> initializeKeywordMap [
	keywordMap := Dictionary new.
	#(#(5 'label' #(6 #(#default))))
		do: [ :each | 
			(keywordMap at: each first ifAbsentPut: [ Dictionary new ])
				at: (each at: 2)
				put: each last ].
	^ keywordMap
]

{ #category : #generated }
OlObjectAnnotationScanner >> emptySymbolTokenId [
	^ 17
]

{ #category : #generated }
OlObjectAnnotationScanner >> errorTokenId [
	^ 18
]

{ #category : #generated }
OlObjectAnnotationScanner >> scan1 [
	self step.
	currentCharacter == $= ifTrue: [ ^ self recordAndReportMatch: #(1) ].
	currentCharacter == $n
		ifTrue: [ self recordMatch: #(5).
			(self scanForString: 'ame')
				ifTrue: [ self recordMatch: #(2 5).
					self step ].
			currentCharacter isAlphaNumeric
				ifTrue: [ [ self recordMatch: #(5).
					self step.
					currentCharacter isAlphaNumeric ] whileTrue ].
			^ self reportLastMatch ].
	currentCharacter == $u
		ifTrue: [ self recordMatch: #(5).
			(self scanForString: 'id')
				ifTrue: [ self recordMatch: #(3 5).
					self step ].
			currentCharacter isAlphaNumeric
				ifTrue: [ [ self recordMatch: #(5).
					self step.
					currentCharacter isAlphaNumeric ] whileTrue ].
			^ self reportLastMatch ].
	currentCharacter == $| ifTrue: [ ^ self recordAndReportMatch: #(4) ].
	currentCharacter isAlphaNumeric
		ifTrue: [ [ self recordMatch: #(5).
			self step.
			currentCharacter isAlphaNumeric ] whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
OlObjectAnnotationScanner >> scanForToken [
	scope == #label
		ifTrue: [ self step.
			currentCharacter == $=
				ifTrue: [ self recordMatch: #(1 7).
					self step.
					(currentCharacter <= ${ or: [ currentCharacter >= $~ ])
						ifTrue: [ [ self recordMatch: #(7).
							self step.
							currentCharacter <= ${ or: [ currentCharacter >= $~ ] ] whileTrue ].
					^ self reportLastMatch ].
			currentCharacter == $n
				ifTrue: [ self recordMatch: #(7).
					(self scanForString: 'ame')
						ifTrue: [ self recordMatch: #(2 7).
							self step ].
					(currentCharacter <= ${ or: [ currentCharacter >= $~ ])
						ifTrue: [ [ self recordMatch: #(7).
							self step.
							currentCharacter <= ${ or: [ currentCharacter >= $~ ] ] whileTrue ].
					^ self reportLastMatch ].
			currentCharacter == $u
				ifTrue: [ self recordMatch: #(7).
					(self scanForString: 'id')
						ifTrue: [ self recordMatch: #(3 7).
							self step ].
					(currentCharacter <= ${ or: [ currentCharacter >= $~ ])
						ifTrue: [ [ self recordMatch: #(7).
							self step.
							currentCharacter <= ${ or: [ currentCharacter >= $~ ] ] whileTrue ].
					^ self reportLastMatch ].
			currentCharacter == $| ifTrue: [ ^ self recordAndReportMatch: #(4) ].
			(currentCharacter <= ${ or: [ currentCharacter >= $~ ])
				ifTrue: [ [ self recordMatch: #(7).
					self step.
					currentCharacter <= ${ or: [ currentCharacter >= $~ ] ] whileTrue ].
			^ self reportLastMatch ].
	scope == #default ifTrue: [ ^ self scan1 ].
	^ self reportLastMatch
]
