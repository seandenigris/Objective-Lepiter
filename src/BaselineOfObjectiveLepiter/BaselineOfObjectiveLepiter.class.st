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
			baseline: 'Magritte' with: [
				spec repository: 'github://seandenigris/Magritte' ];
			baseline: 'Mocketry' with: [
				spec repository: 'github://dionisiydk/Mocketry' ].
		spec package: 'ObjectiveLepiter' with: [
				spec requires: #('Magritte' 'Mocketry' ). ]. ].
]