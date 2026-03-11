Logical: CDSHooksServices
Parent: CDSHooksElement
Id: CDSHooksServices
Title: "CDSHooks Services Request (Logical Definition)"
Description: "This structure is defined to allow the FHIR Validator to validate a CDSHooks Services response body. TODO: This content will be moved to the CDS Hooks specification in the future"
* ^status = #draft
* ^experimental = true
* . ^short = "The response to the discovery endpoint"
* . ^definition = "The response to the discovery endpoint"
* services 0..* http://hl7.org/fhir/tools/StructureDefinition/CDSHooksElement "A list of CDS services" "A list of CDS services"
* services ^comment = "If the CDS server hosts no CDS services, the discovery endpoint should return a 200 HTTP response with an empty array of services"
* services.hook 1..1 string "The hook this Services should be invoked on" "The hook this Services should be invoked on"
* services.title 0..1 string "The human-friendly name of this Services (Recommended)" "The human-friendly name of this Services (Recommended)"
* services.id 1..1 code "{baseUrl}/cds-services/{id}" "The {id} portion of the URL to this service which is available at ```{baseUrl}/cds-services/{id}```"
* services.description 1..1 string "The description of this Services" "The description of this Services"
* services.usageRequirements 0..1 string "Human-friendly preconditions for this CDS Services" "Human-friendly description of any preconditions for the use of this CDS Services"
* services.prefetch 0..* Base "Key/value pairs of FHIR queries to provide when calling" "An object containing key/value pairs of FHIR queries that this Services is requesting the CDS Client to perform and provide on each Services call. The key is a string that describes the type of data being requested and the value is a string representing the FHIR query"
* services.prefetch ^extension.url = "http://hl7.org/fhir/tools/StructureDefinition/json-property-key"
* services.prefetch ^extension.valueCode = #key
* services.prefetch.key 1..1 code "Key of FHIR query" "Key of FHIR query - name for client to use when sending to Services"
* services.prefetch.value 1..1 string "FHIR query to execute" "Value of FHIR query - FHIR Query for client to perform"
