Class {
	#name : #OlObjectAnnotationScanner,
	#superclass : #SmaCCScanner,
	#category : #'ObjectiveLepiter-Annotation'
}

{ #category : #'generated-initialization' }
OlObjectAnnotationScanner class >> initializeKeywordMap [
	keywordMap := Dictionary new.
	#(#(11 'expanded' #(9 #(#default))) #(11 'false' #(10 #(#default))) #(11 'label' #(7 #(#default))) #(11 'true' #(10 #(#default))))
		do: [ :each | 
			(keywordMap at: each first ifAbsentPut: [ Dictionary new ])
				at: (each at: 2)
				put: each last ].
	^ keywordMap
]

{ #category : #generated }
OlObjectAnnotationScanner >> emptySymbolTokenId [
	^ 27
]

{ #category : #generated }
OlObjectAnnotationScanner >> errorTokenId [
	^ 28
]

{ #category : #generated }
OlObjectAnnotationScanner >> scan1 [
	self step.
	currentCharacter == $# ifTrue: [ ^ self scan1X1 ].
	currentCharacter == $= ifTrue: [ ^ self scan1X2 ].
	^ self scan1X6
]

{ #category : #generated }
OlObjectAnnotationScanner >> scan1X1 [
	self step.
	currentCharacter == $\ ifTrue: [ ^ self scan3 ].
	(currentCharacter == $!
		or: [ (currentCharacter between: $% and: $&)
				or: [ (currentCharacter between: $* and: $-)
						or: [ currentCharacter == $/
								or: [ (currentCharacter between: $< and: $@) or: [ currentCharacter == $~ ] ] ] ] ])
		ifTrue: [ ^ self scan2 ].
	(currentCharacter isLetter or: [ currentCharacter == $_ ])
		ifTrue: [ ^ self scan4 ].
	^ self reportLastMatch
]

{ #category : #generated }
OlObjectAnnotationScanner >> scan1X2 [
	self recordMatch: #(1 11).
	self step.
	currentCharacter == $\ ifTrue: [ ^ self scan3 ].
	(currentCharacter == $!
		or: [ (currentCharacter between: $% and: $&)
				or: [ (currentCharacter between: $* and: $-)
						or: [ currentCharacter == $/
								or: [ (currentCharacter between: $< and: $@) or: [ currentCharacter == $~ ] ] ] ] ])
		ifTrue: [ ^ self scan2 ].
	^ self reportLastMatch
]

{ #category : #generated }
OlObjectAnnotationScanner >> scan1X3 [
	self recordMatch: #(11).
	self step.
	currentCharacter == $: ifTrue: [ ^ self scan5 ].
	currentCharacter == $h
		ifTrue: [ self recordMatch: #(11).
			self step.
			currentCharacter == $: ifTrue: [ ^ self scan5 ].
			currentCharacter == $o
				ifTrue: [ self recordMatch: #(11).
					self step.
					currentCharacter == $: ifTrue: [ ^ self scan5 ].
					currentCharacter == $w
						ifTrue: [ self recordMatch: #(3 11).
							self step.
							currentCharacter == $: ifTrue: [ ^ self scan5 ] ] ] ].
	(currentCharacter isAlphaNumeric or: [ currentCharacter == $_ ])
		ifTrue: [ ^ self scan4 ].
	^ self reportLastMatch
]

{ #category : #generated }
OlObjectAnnotationScanner >> scan1X4 [
	self recordMatch: #(11).
	self step.
	currentCharacter == $: ifTrue: [ ^ self scan5 ].
	currentCharacter == $a
		ifTrue: [ self recordMatch: #(11).
			self step.
			currentCharacter == $: ifTrue: [ ^ self scan5 ].
			currentCharacter == $m
				ifTrue: [ self recordMatch: #(11).
					self step.
					currentCharacter == $: ifTrue: [ ^ self scan5 ].
					currentCharacter == $e
						ifTrue: [ self recordMatch: #(2 11).
							self step.
							currentCharacter == $: ifTrue: [ ^ self scan5 ] ] ] ].
	(currentCharacter isAlphaNumeric or: [ currentCharacter == $_ ])
		ifTrue: [ ^ self scan4 ].
	^ self reportLastMatch
]

{ #category : #generated }
OlObjectAnnotationScanner >> scan1X5 [
	self recordMatch: #(11).
	self step.
	currentCharacter == $: ifTrue: [ ^ self scan5 ].
	currentCharacter == $i
		ifTrue: [ self recordMatch: #(11).
			self step.
			currentCharacter == $: ifTrue: [ ^ self scan5 ].
			currentCharacter == $d
				ifTrue: [ self recordMatch: #(4 11).
					self step.
					currentCharacter == $: ifTrue: [ ^ self scan5 ] ] ].
	(currentCharacter isAlphaNumeric or: [ currentCharacter == $_ ])
		ifTrue: [ ^ self scan4 ].
	^ self reportLastMatch
]

{ #category : #generated }
OlObjectAnnotationScanner >> scan1X6 [
	currentCharacter == $\ ifTrue: [ ^ self scan3 ].
	currentCharacter == $n ifTrue: [ ^ self scan1X4 ].
	currentCharacter == $s ifTrue: [ ^ self scan1X3 ].
	currentCharacter == $u ifTrue: [ ^ self scan1X5 ].
	currentCharacter == $| ifTrue: [ ^ self recordAndReportMatch: #(5) ].
	(currentCharacter == $!
		or: [ (currentCharacter between: $% and: $&)
				or: [ (currentCharacter between: $* and: $-)
						or: [ currentCharacter == $/
								or: [ (currentCharacter between: $< and: $@) or: [ currentCharacter == $~ ] ] ] ] ])
		ifTrue: [ ^ self scan2 ].
	(currentCharacter isLetter or: [ currentCharacter == $_ ])
		ifTrue: [ ^ self scan4 ].
	^ self reportLastMatch
]

{ #category : #generated }
OlObjectAnnotationScanner >> scan2 [
	[ self recordMatch: #(11).
	self step.
	currentCharacter == $\ ifTrue: [ ^ self scan3 ].
	currentCharacter == $!
		or: [ (currentCharacter between: $% and: $&)
				or: [ (currentCharacter between: $* and: $-)
						or: [ currentCharacter == $/
								or: [ (currentCharacter between: $< and: $@) or: [ currentCharacter == $~ ] ] ] ] ] ]
		whileTrue.
	^ self reportLastMatch
]

{ #category : #generated }
OlObjectAnnotationScanner >> scan3 [
	self step.
	(currentCharacter == $!
		or: [ (currentCharacter between: $% and: $&)
				or: [ (currentCharacter between: $* and: $-)
						or: [ currentCharacter == $/
								or: [ (currentCharacter between: $< and: $@)
										or: [ '\|~' includes: currentCharacter ] ] ] ] ])
		ifTrue: [ ^ self scan2 ].
	^ self reportLastMatch
]

{ #category : #generated }
OlObjectAnnotationScanner >> scan4 [
	[ self recordMatch: #(11).
	self step.
	currentCharacter == $: ifTrue: [ ^ self scan5 ].
	currentCharacter isAlphaNumeric or: [ currentCharacter == $_ ] ] whileTrue.
	^ self reportLastMatch
]

{ #category : #generated }
OlObjectAnnotationScanner >> scan5 [
	self recordMatch: #(11).
	self step.
	(currentCharacter isLetter or: [ currentCharacter == $_ ])
		ifTrue: [ [ self step.
			currentCharacter == $: ifTrue: [ ^ self scan5 ].
			currentCharacter isAlphaNumeric or: [ currentCharacter == $_ ] ] whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
OlObjectAnnotationScanner >> scan6 [
	self step.
	currentCharacter == $=
		ifTrue: [ self recordMatch: #(1 8).
			self step.
			(currentCharacter <= ${ or: [ currentCharacter >= $~ ])
				ifTrue: [ [ self recordMatch: #(8).
					self step.
					currentCharacter <= ${ or: [ currentCharacter >= $~ ] ] whileTrue ].
			^ self reportLastMatch ].
	currentCharacter == $n
		ifTrue: [ (self scanForString: 'ame' match: #(8))
				ifTrue: [ self recordMatch: #(2 8).
					self step ].
			(currentCharacter <= ${ or: [ currentCharacter >= $~ ])
				ifTrue: [ [ self recordMatch: #(8).
					self step.
					currentCharacter <= ${ or: [ currentCharacter >= $~ ] ] whileTrue ].
			^ self reportLastMatch ].
	currentCharacter == $s
		ifTrue: [ (self scanForString: 'how' match: #(8))
				ifTrue: [ self recordMatch: #(3 8).
					self step ].
			(currentCharacter <= ${ or: [ currentCharacter >= $~ ])
				ifTrue: [ [ self recordMatch: #(8).
					self step.
					currentCharacter <= ${ or: [ currentCharacter >= $~ ] ] whileTrue ].
			^ self reportLastMatch ].
	currentCharacter == $u
		ifTrue: [ (self scanForString: 'id' match: #(8))
				ifTrue: [ self recordMatch: #(4 8).
					self step ].
			(currentCharacter <= ${ or: [ currentCharacter >= $~ ])
				ifTrue: [ [ self recordMatch: #(8).
					self step.
					currentCharacter <= ${ or: [ currentCharacter >= $~ ] ] whileTrue ].
			^ self reportLastMatch ].
	currentCharacter == $| ifTrue: [ ^ self recordAndReportMatch: #(5) ].
	(currentCharacter <= ${ or: [ currentCharacter >= $~ ])
		ifTrue: [ [ self recordMatch: #(8).
			self step.
			currentCharacter <= ${ or: [ currentCharacter >= $~ ] ] whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
OlObjectAnnotationScanner >> scan7 [
	self step.
	currentCharacter == $= ifTrue: [ ^ self recordAndReportMatch: #(1) ].
	currentCharacter == $n
		ifTrue: [ (self scanForString: 'ame' match: #(6))
				ifTrue: [ self recordMatch: #(2 6).
					self step ].
			currentCharacter isAlphaNumeric
				ifTrue: [ [ self recordMatch: #(6).
					self step.
					currentCharacter isAlphaNumeric ] whileTrue ].
			^ self reportLastMatch ].
	currentCharacter == $s
		ifTrue: [ (self scanForString: 'how' match: #(6))
				ifTrue: [ self recordMatch: #(3 6).
					self step ].
			currentCharacter isAlphaNumeric
				ifTrue: [ [ self recordMatch: #(6).
					self step.
					currentCharacter isAlphaNumeric ] whileTrue ].
			^ self reportLastMatch ].
	currentCharacter == $u
		ifTrue: [ (self scanForString: 'id' match: #(6))
				ifTrue: [ self recordMatch: #(4 6).
					self step ].
			currentCharacter isAlphaNumeric
				ifTrue: [ [ self recordMatch: #(6).
					self step.
					currentCharacter isAlphaNumeric ] whileTrue ].
			^ self reportLastMatch ].
	currentCharacter == $| ifTrue: [ ^ self recordAndReportMatch: #(5) ].
	currentCharacter isAlphaNumeric
		ifTrue: [ [ self recordMatch: #(6).
			self step.
			currentCharacter isAlphaNumeric ] whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
OlObjectAnnotationScanner >> scanForToken [
	scope == #label ifTrue: [ ^ self scan6 ].
	scope == #uid ifTrue: [ ^ self scan7 ].
	scope == #default ifTrue: [ ^ self scan1 ].
	^ self reportLastMatch
]
