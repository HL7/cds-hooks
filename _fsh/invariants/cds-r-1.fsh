Invariant: cds-r-1
Description: "if fhirAuthorization details are provided, a fhirServer SHALL be specified"
* severity = #error
* expression = "fhirAuthorization.exists() implies fhirServer.exists()"