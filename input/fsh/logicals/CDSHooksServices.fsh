Logical: CDSHooksServices
Parent: CDSHooksElement
Id: CDSHooksServices
Title: "CDSHooks Discovery Response (Logical Definition)"
Description: "This structure is defined to allow the FHIR Validator to validate a CDSHooks Discovery response body."
* ^status = #draft
* ^experimental = true
* . ^short = "The response to the discovery endpoint"
* . ^definition = "The response to the discovery endpoint SHALL be an object containing a list of CDS Services"
* services 0..* http://hl7.org/fhir/tools/StructureDefinition/CDSHooksElement "An array of CDS Services" "An array of CDS Services"
* services ^extension.url = "http://hl7.org/fhir/tools/StructureDefinition/json-empty-behavior"
* services ^extension.valueCode = #present
* services ^comment = "If the CDS server hosts no CDS Services, the discovery endpoint should return a 200 HTTP response with an empty array of services. Note that a CDS server can host multiple entries of CDS service with the same id for different hooks. This allows a service to update its advice based on changes in workflow."
* services.hook 1..1 string "The hook this service should be invoked on" "The hook this service should be invoked on"
* services.title 0..1 string "The human-friendly name of this service" "The human-friendly name of this service"
* services.description 1..1 string "The description of this service" "The description of this service"
* services.id 1..1 string "The {id} portion of the URL to this service" "The {id} portion of the URL to this service which is available at {baseUrl}/cds-services/{id}"
* services.prefetch 0..* Base "Key/value pairs of FHIR queries to provide when calling" "An object containing key/value pairs of FHIR queries that this service is requesting the CDS Client to perform and provide on each service call. The key is a string that describes the type of data being requested and the value is a string representing the FHIR query"
* services.prefetch ^extension.url = "http://hl7.org/fhir/tools/StructureDefinition/json-property-key"
* services.prefetch ^extension.valueCode = #key
* services.prefetch.key 1..1 code "Key of FHIR query" "Key of FHIR query - name for client to use when sending prefetched data to the service"
* services.prefetch.value 1..1 string "FHIR query template" "A FHIR query for the CDS Client to perform, which may include prefetch tokens"
* services.usageRequirements 0..1 string "Human-friendly preconditions for the use of this CDS Service" "Human-friendly description of any preconditions for the use of this CDS Service"
* services.version 0..1 string "CDS Hooks specification version implemented" "The version of the CDS Hooks specification implemented (STU1 | STU2 | STU3)"
