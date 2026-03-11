Logical: CDSHookContext
Id: CDSHookContext
Title: "CDS Hook Specific Context (Logical Definition)"
Description: "This structure is defined to allow the FHIR Validator to validate a CDSHooks Request Context."
* ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/structuredefinition-fmm"
* ^extension[=].valueInteger = 1
* ^extension[+].url = "http://hl7.org/fhir/tools/StructureDefinition/json-suppress-resourcetype"
* ^extension[=].valueBoolean = true
* ^version = "0.0.1"
* ^status = #draft
* ^experimental = true
* . ^short = "The context (hook specific)"
* . ^definition = "The context (hook specific)"
