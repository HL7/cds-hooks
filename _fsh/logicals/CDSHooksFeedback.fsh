Logical: CDSHooksFeedback
Parent: CDSHooksElement
Id: CDSHooksFeedback
Title: "CDSHooks Feedback (Logical Definition)"
Description: "This structure is defined to allow the FHIR Validator to validate a CDSHooks Feedback request body."
* ^status = #draft
* ^experimental = true
* . ^short = "The request body for the CDS Hooks feedback endpoint"
* . ^definition = "Feedback that a CDS Client POSTs to a CDS Service's feedback endpoint. The request body is an object containing an array of one or more Feedback entries reporting end-user interaction with cards previously returned by the CDS Service."
* feedback 0..* http://hl7.org/fhir/tools/StructureDefinition/CDSHooksElement "Array of Feedback entries" "An array of Feedback entries reporting end-user interaction with cards previously returned by the CDS Service."
* feedback obeys cds-fb-1 and cds-fb-2
* feedback ^extension.url = "http://hl7.org/fhir/tools/StructureDefinition/json-empty-behavior"
* feedback ^extension.valueCode = #present
* feedback.card 1..1 uuid "Identifier of the card the user acted on" "The card.uuid from the CDS Hooks response. Uniquely identifies the card."
* feedback.card ^extension[+].url = "http://hl7.org/fhir/tools/StructureDefinition/implied-string-prefix"
* feedback.card ^extension[=].valueString = "urn:uuid:"
* feedback.outcome 1..1 code "accepted | overridden" "A value of accepted or overridden."
* feedback.acceptedSuggestions 0..* http://hl7.org/fhir/tools/StructureDefinition/CDSHooksElement "Suggestions accepted by the user" "An array of objects identifying one or more of the user's AcceptedSuggestions. Required for 'accepted' outcomes."
* feedback.acceptedSuggestions.id 1..1 uuid "Identifier of the accepted suggestion" "The card.suggestion.uuid from the CDS Hooks response. Uniquely identifies the suggestion that was accepted."
* feedback.acceptedSuggestions.id ^extension[+].url = "http://hl7.org/fhir/tools/StructureDefinition/implied-string-prefix"
* feedback.acceptedSuggestions.id ^extension[=].valueString = "urn:uuid:"
* feedback.overrideReason 0..1 http://hl7.org/fhir/tools/StructureDefinition/CDSHooksElement "Reason the user overrode the card" "Captures the override reason as a Coding as well as any free-text comment entered by the user."
* feedback.overrideReason obeys cds-fb-3
* feedback.overrideReason.reason 0..1 Coding "The override reason selected by the end user" "The Coding object representing the override reason selected by the end user. Required if the user selected an override reason from the list of reasons provided in the Card (instead of only leaving a userComment)."
* feedback.overrideReason.userComment 0..1 string "Free text user comment" "Free text the clinician provided to further explain why the card was rejected."
* feedback.outcomeTimestamp 1..1 instant "When the user took action on the card" "ISO8601 representation of the date and time in Coordinated Universal Time (UTC) when action was taken on the card, as profiled in section 5.6 of RFC3339 (e.g. 1985-04-12T23:20:50.52Z)."
