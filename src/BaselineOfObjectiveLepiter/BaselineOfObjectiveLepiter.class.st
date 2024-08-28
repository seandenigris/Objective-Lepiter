"
# Icons
We use the following icons from [Noun Project](https://thenounproject.com/browse/icons/term/inventory/):
- identification by Numeralia Vita Zein
"
Class {
	#name : #BaselineOfObjectiveLepiter,
	#superclass : #BaselineOf,
	#category : #BaselineOfObjectiveLepiter
}

{ #category : #baseline }
BaselineOfObjectiveLepiter >> baseline: spec [
	<baseline>

	spec for: #'common' do: [
		spec 
			baseline: #'DynabookFoundation' with: [
				spec repository: 'github://seandenigris/Dynabook-Foundation' ];
			baseline: #'Magritte' with: [
				spec repository: 'github://seandenigris/Magritte' ];
			baseline: #'Mocketry' with: [
				spec repository: 'github://dionisiydk/Mocketry' ];
			baseline: #'PharoEnhancements' with: [
				spec repository: 'github://seandenigris/Pharo-Enhancements' ].
		spec package: #'ObjectiveLepiter' with: [
				spec requires: #(#'DynabookFoundation' #'Magritte' #'Mocketry' #'PharoEnhancements'). ]. ].
]
