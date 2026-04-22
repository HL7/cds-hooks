Invariant: cds-r-2
Description: "If the granted SMART scopes include patient scopes (i.e. 'patient/'), the patient field SHOULD be populated to identify the FHIR id of that patient."
* severity = #warning
* expression = "scope.contains('patient/') implies patient.exists()"