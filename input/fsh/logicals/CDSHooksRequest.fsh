Logical: CDSHooksRequest
Parent: CDSHooksElement
Id: CDSHooksRequest
Title: "CDSHooks Request (Logical Definition)"
Description: "This structure is defined to allow the FHIR Validator to validate a CDSHooks Request Body."
* ^status = #draft
* ^experimental = true
* obeys cds-r-1
* . ^short = "A request for decision support"
* . ^definition = "The data structure that used when invoking a CDS Hook service"
* hook 1..1 code "The hook that triggered this CDS Service call" "The hook that triggered this CDS Service call"
* hookInstance 1..1 uuid "A UUID for this particular hook call" "While working in the CDS Client, a user can perform multiple actions in series or in parallel. For example, a clinician might prescribe two drugs in a row; each prescription action would be assigned a unique hookInstance. This allows a CDS Service to uniquely identify each hook invocation"
* hookInstance ^extension[0].url = "http://hl7.org/fhir/tools/StructureDefinition/implied-string-prefix"
* hookInstance ^extension[=].valueString = "urn:uuid:"
* hookInstance ^comment = "Note: the hookInstance is globally unique and should contain enough entropy to be un-guessable."
* fhirServer 0..1 url "The base URL of the CDS Client's FHIR server" "The base URL of the CDS Client's FHIR server. If fhirAuthorization is provided, this field is REQUIRED. The scheme MUST be https when production data is exchanged"
* fhirAuthorization 0..1 http://hl7.org/fhir/tools/StructureDefinition/CDSHooksElement "Authorization info for service to use when querying" "A structure holding an OAuth 2.0 bearer access token granting the CDS Service access to FHIR resources, along with supplemental information relating to the token"
* fhirAuthorization obeys cds-r-2
* fhirAuthorization.accessToken 1..1 string "OAuth 2.0 access token giving access to FHIR server" "This is the OAuth 2.0 access token that provides access to the FHIR server"
* fhirAuthorization.accessToken ^extension[+].url = "http://hl7.org/fhir/tools/StructureDefinition/json-name"
* fhirAuthorization.accessToken ^extension[=].valueString = "access_token"
* fhirAuthorization.tokenType 1..1 code "Bearer" "The type of token provided.  (Present to support future extensibility)"
* fhirAuthorization.tokenType = #Bearer (exactly)
* fhirAuthorization.tokenType ^extension[+].url = "http://hl7.org/fhir/tools/StructureDefinition/json-name"
* fhirAuthorization.tokenType ^extension[=].valueString = "token_type"
* fhirAuthorization.expiresIn 1..1 integer "The lifetime in seconds of the access token" "The lifetime in seconds of the access token."
* fhirAuthorization.expiresIn ^extension[+].url = "http://hl7.org/fhir/tools/StructureDefinition/json-name"
* fhirAuthorization.expiresIn ^extension[=].valueString = "expires_in"
* fhirAuthorization.scope 1..1 string "Scopes granted by access token" "The scopes the access token grants the CDS Service"
* fhirAuthorization.subject 1..1 string "OAuth 2.0 client identifier of the CDS Service" "The OAuth 2.0 client identifier of the CDS Service, as registered with the CDS Client's authorization server"
* fhirAuthorization.patient 0..1 id "FHIR id of the patient" "The FHIR id of the patient."
* context 1..1 http://hl7.org/fhir/tools/StructureDefinition/CDSHookContext "Contextual data always needed for this hook type" "Hook-specific contextual data that the CDS service will need"
* context ^extension[+].url = "http://hl7.org/fhir/tools/StructureDefinition/type-specifier"
* context ^extension[=].extension[0].url = "condition"
* context ^extension[=].extension[=].valueString = "%resource.hook = 'appointment-book'"
* context ^extension[=].extension[+].url = "type"
* context ^extension[=].extension[=].valueCode = #http://hl7.org/fhir/tools/StructureDefinition/CDSHookAppointmentBookContext
* context ^extension[+].url = "http://hl7.org/fhir/tools/StructureDefinition/type-specifier"
* context ^extension[=].extension[0].url = "condition"
* context ^extension[=].extension[=].valueString = "%resource.hook = 'encounter-start'"
* context ^extension[=].extension[+].url = "type"
* context ^extension[=].extension[=].valueCode = #http://hl7.org/fhir/tools/StructureDefinition/CDSHookEncounterStartContext
* context ^extension[+].url = "http://hl7.org/fhir/tools/StructureDefinition/type-specifier"
* context ^extension[=].extension[0].url = "condition"
* context ^extension[=].extension[=].valueString = "%resource.hook = 'encounter-discharge'"
* context ^extension[=].extension[+].url = "type"
* context ^extension[=].extension[=].valueCode = #http://hl7.org/fhir/tools/StructureDefinition/CDSHookEncounterDischargeContext
* context ^extension[+].url = "http://hl7.org/fhir/tools/StructureDefinition/type-specifier"
* context ^extension[=].extension[0].url = "condition"
* context ^extension[=].extension[=].valueString = "%resource.hook = 'patient-view'"
* context ^extension[=].extension[+].url = "type"
* context ^extension[=].extension[=].valueCode = #http://hl7.org/fhir/tools/StructureDefinition/CDSHookPatientViewContext
* context ^extension[+].url = "http://hl7.org/fhir/tools/StructureDefinition/type-specifier"
* context ^extension[=].extension[0].url = "condition"
* context ^extension[=].extension[=].valueString = "%resource.hook = 'order-dispatch'"
* context ^extension[=].extension[+].url = "type"
* context ^extension[=].extension[=].valueCode = #http://hl7.org/fhir/tools/StructureDefinition/CDSHookOrderDispatchContext
* context ^extension[+].url = "http://hl7.org/fhir/tools/StructureDefinition/type-specifier"
* context ^extension[=].extension[0].url = "condition"
* context ^extension[=].extension[=].valueString = "%resource.hook = 'order-sign'"
* context ^extension[=].extension[+].url = "type"
* context ^extension[=].extension[=].valueCode = #http://hl7.org/fhir/tools/StructureDefinition/CDSHookOrderSignContext
* context ^extension[+].url = "http://hl7.org/fhir/tools/StructureDefinition/type-specifier"
* context ^extension[=].extension[0].url = "condition"
* context ^extension[=].extension[=].valueString = "%resource.hook = 'order-select'"
* context ^extension[=].extension[+].url = "type"
* context ^extension[=].extension[=].valueCode = #http://hl7.org/fhir/tools/StructureDefinition/CDSHookOrderSelectContext
* prefetch 0..* Base "Additional information requested by service for this hook type" "An object containing key/value pairs of FHIR queries that this Request is requesting the CDS Client to perform and provide on each Request call. The key is a string that describes the type of data being requested and the value is a string representing the FHIR query"
* prefetch ^extension[0].url = "http://hl7.org/fhir/tools/StructureDefinition/json-property-key"
* prefetch ^extension[=].valueCode = #key
* prefetch.key 1..1 code "Key of FHIR query" "Name of the FHIR query/read from the CDS Hooks Services object provided by the server"
* prefetch.value 1..1 Resource "Results of query/read" "What was found by executing the search or read requested by the CDS Hooks Service in the context of this particular hook invocation"
* prefetch.value ^extension[+].url = "http://hl7.org/fhir/tools/StructureDefinition/json-nullable"
* prefetch.value ^extension[=].valueBoolean = true
* prefetch.value ^extension[+].url = "http://hl7.org/fhir/tools/StructureDefinition/id-expectation"
* prefetch.value ^extension[=].valueCode = #optional
