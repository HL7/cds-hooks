Logical: CDSHookOrderSignContext
Parent: CDSHookContext
Id: CDSHookOrderSignContext
Title: "CDS Hook Specific Context for order-sign (Logical Definition)"
Description: "This structure is defined to allow the FHIR Validator to validate a CDSHooks Order-Sign context."
* ^status = #draft
* ^experimental = true
* . ^short = "The context for the order-sign hook"
* userId 1..1 url "The id of the current user. Must be in the format [ResourceType]/[id]." "For this hook, the user is expected to be of type Practitioner, PractitionerRole, Patient, or RelatedPerson. Patient or RelatedPerson are appropriate when a patient or their proxy are viewing the record. For example, Practitioner/abc or Patient/123."
* patientId 1..1 id "The FHIR Patient.id of the current patient in context" "The FHIR Patient.id of the current patient in context"
* encounterId 0..1 id "The FHIR Encounter.id of the current encounter in context" "The FHIR Encounter.id of the current encounter in context"
* draftOrders 1..1 Bundle "FHIR Bundle of MedicationRequest, NutritionOrder, ServiceRequest, VisionPrescription with draft status" "FHIR Bundle of MedicationRequest, NutritionOrder, ServiceRequest, VisionPrescription with draft status"
* draftOrders ^extension.url = "http://hl7.org/fhir/tools/StructureDefinition/id-expectation"
* draftOrders ^extension.valueCode = #optional
