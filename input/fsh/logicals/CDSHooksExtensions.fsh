Logical: CDSHooksExtensions
Id: CDSHooksExtensions
Title: "CDSHooks Services Extensions"
Description: "This is a concrete subtype of Base that has extensions (though the format in JSON is different)"
* ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/structuredefinition-fmm"
* ^extension[=].valueInteger = 1
* ^extension[+].url = "http://hl7.org/fhir/tools/StructureDefinition/json-suppress-resourcetype"
* ^extension[=].valueBoolean = true
* ^extension[+].url = "http://hl7.org/fhir/tools/StructureDefinition/extension-style"
* ^extension[=].valueCode = #named-elements
* ^version = "0.0.1"
* ^status = #draft
* ^experimental = true
* . ^short = "Object that has Named Extension Properties"
* . ^definition = "A JSON object that has properties where the names are defined by the extension definitions"
* . ^comment = "Extension structures SHOULD use a strategy for naming that ensures global uniqueness, such as reverse-domain-name notation, e.g. com.cds-hooks.sandbox.myextension-practitionerspecialty. How to handle complex extensions (objects) is not defined"
* extension 0..* Base "An extension of any type" "An extension where the name is defined by the extension definition, and the extension definition is of any type (including primitives, though the 'id' element cannot be represented for primitives)"
* extension ^extension[0].url = "http://hl7.org/fhir/tools/StructureDefinition/extension-style"
* extension ^extension[=].valueCode = #named-elements