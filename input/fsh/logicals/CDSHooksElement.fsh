Logical: CDSHooksElement
Id: CDSHooksElement
Title: "CDSHooks Services Base Extensible Element"
Description: "This structure is defined to allow the FHIR Validator to validate a CDSHooks Services Element with Extensions. TODO: This content will be moved to the CDS Hooks specification in the future"
* ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/structuredefinition-fmm"
* ^extension[=].valueInteger = 1
* ^extension[+].url = "http://hl7.org/fhir/tools/StructureDefinition/json-suppress-resourcetype"
* ^extension[=].valueBoolean = true
* ^version = "0.0.1"
* ^status = #draft
* ^experimental = true
* . ^short = "Base Element - defines CDSHooks Extension"
* . ^definition = "Base element for all CDSHooks Element - defines the extension element on all CDSHooks objects"
* extension 0..1 http://hl7.org/fhir/tools/StructureDefinition/CDSHooksExtensions "Object that has Named Extension Properties" "A JSON object that has properties where the names are defined by the extension definitions"
* extension ^comment = "Extension structures SHOULD use a strategy for naming that ensures global uniqueness, such as reverse-domain-name notation, e.g. com.cds-hooks.sandbox.myextension-practitionerspecialty. How to handle complex extensions (objects) is not defined"
