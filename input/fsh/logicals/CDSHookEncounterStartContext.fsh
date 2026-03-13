Logical: CDSHookEncounterStartContext
Parent: CDSHookContext
Id: CDSHookEncounterStartContext
Title: "CDS Hooks Specific Context for encounter-start (Logical Definition)"
Description: "This structure is defined to allow the FHIR Validator to validate a CDSHooks encounter-start context."
* ^status = #draft
* ^experimental = true
* . ^short = "The context for the encounter-start hook"
* userId 1..1 url "The id of the current user. Must be in the format [ResourceType]/[id]." "For this hook, the user is expected to be of type Practitioner, PractitionerRole, Patient, or RelatedPerson. Patient or RelatedPerson are appropriate when a patient or their proxy are viewing the record. For example, Practitioner/abc or Patient/123."
* patientId 1..1 id "The FHIR Patient.id of the current patient in context" "The FHIR Patient.id of the current patient in context"
* encounterId 0..1 id "The FHIR Encounter.id of the current encounter in context" "The FHIR Encounter.id of the current encounter in context"
