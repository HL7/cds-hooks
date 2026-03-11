Logical: CDSHooksResponse
Parent: CDSHooksElement
Id: CDSHooksResponse
Title: "CDSHooks Response (Logical Definition)"
Description: "This structure is defined to allow the FHIR Validator to validate a CDSHooks Response body."
* ^status = #draft
* ^experimental = true
* . ^short = "The response to the discovery endpoint"
* . ^definition = "The response to the discovery endpoint"
* cards 0..* http://hl7.org/fhir/tools/StructureDefinition/CDSHooksElement "CDS responses to show user" "An array of Cards. Cards can provide a combination of information (for reading), suggested actions (to be applied if a user selects them), and links (to launch an app if the user selects them)."
* cards obeys cds-resp-1 and cds-resp-6
* cards ^extension.url = "http://hl7.org/fhir/tools/StructureDefinition/json-empty-behavior"
* cards ^extension.valueCode = #present
* cards ^comment = "The CDS Client decides how to display cards, but this specification recommends displaying suggestions using buttons, and links using underlined text."
* cards.uuid 0..1 uuid "Unique identifier of the card (for logging/feedback)" "Unique identifier of the card. MAY be used for auditing and logging cards and SHALL be included in any subsequent calls to the CDS service's feedback endpoint."
* cards.uuid ^extension.url = "http://hl7.org/fhir/tools/StructureDefinition/implied-string-prefix"
* cards.uuid ^extension.valueString = "urn:uuid:"
* cards.summary 1..1 string "Summary message for display to the user (<140 char)" "One-sentence, <140-character summary message for display to the user inside of this card."
* cards.detail 0..1 markdown "Optional detailed information to display (GitHub Flavored Markdown)" "Optional detailed information to display; if provided MUST be represented in (GitHub Flavored) Markdown. (For non-urgent cards, the CDS Client MAY hide these details until the user clicks a link like 'view more details...')."
* cards.indicator 0..1 code "info, warning, critical - Urgency/importance of what this card conveys" "Urgency/importance of what this card conveys. Allowed values, in order of increasing urgency, are: info, warning, critical."
* cards.indicator from http://hl7.org/fhir/tools/ValueSet/CDSIndicator (required)
* cards.indicator ^comment = "The CDS Client MAY use this field to help make UI display decisions such as sort order or coloring."
* cards.source 1..1 http://hl7.org/fhir/tools/StructureDefinition/CDSHooksElement "The primary source of guidance for the content the card represents." "The source should be the primary source of guidance for the decision support the card represents."
* cards.source.label 1..1 string "Short, human-readable label to display for the source." "A short, human-readable label to display for the source of the information displayed on this card. If a url is also specified, this MAY be the text for the hyperlink."
* cards.source.url 0..1 url "Link for when user clicks for more information about the source" "An optional absolute URL to load (via GET, in a browser context) when a user clicks on this link to learn more about the organization or data set that provided the information on this card."
* cards.source.url ^comment = "Note that this URL should not be used to supply a context-specific 'drill-down' view of the information on this card. For that, use card.link.url instead."
* cards.source.icon 0..1 url "absolute URL to an icon for the source (<100x100 PNG))" "An absolute URL to an icon for the source of this card. The icon returned by this URL SHOULD be a 100x100 pixel PNG image without any transparent regions. The CDS Client may ignore or scale the image during display as appropriate for user experience."
* cards.source.topic 0..1 Coding "Describes the content of the card" "A topic describes the content of the card by providing a high-level categorization that can be useful for filtering, searching or ordered display of related cards in the CDS client's UI. This specification does not prescribe a standard set of topics"
* cards.source.topic ^comment = "This specification does not prescribe a standard set of topics"
* cards.suggestions 0..* http://hl7.org/fhir/tools/StructureDefinition/CDSHooksElement "Suggest a set of changes in the context of the current activity" "Allows a service to suggest a set of changes in the context of the current activity (e.g. changing the dose of a medication currently being prescribed, for the order-sign activity)."
* cards.suggestions obeys cds-resp-5
* cards.suggestions ^condition[0] = "cds-resp-1"
* cards.suggestions ^condition[+] = "cds-resp-6"
* cards.suggestions.label 1..1 string "Human-readable label to display for this suggestion" "Human-readable label to display for this suggestion"
* cards.suggestions.label ^comment = "e.g. the CDS Client might render this as the text on a button tied to this suggestion"
* cards.suggestions.uuid 0..1 uuid "Unique identifier, used for auditing and logging suggestions" "Unique identifier, used for auditing and logging suggestions"
* cards.suggestions.uuid ^extension.url = "http://hl7.org/fhir/tools/StructureDefinition/implied-string-prefix"
* cards.suggestions.uuid ^extension.valueString = "urn:uuid:"
* cards.suggestions.isRecommended 0..1 boolean "Which suggestion is most preferred of a set" "When there are multiple suggestions, allows a service to indicate that a specific suggestion is recommended from all the available suggestions on the card"
* cards.suggestions.isRecommended ^comment = "CDS Hooks clients may choose to influence their UI based on this value, such as pre-selecting, or highlighting recommended suggestions. Multiple suggestions MAY be recommended, if card.selectionBehavior is any."
* cards.suggestions.actions 0..* http://hl7.org/fhir/tools/StructureDefinition/CDSHooksElement "Defines a suggested action (all apply)" "Defines a suggested action. Within a suggestion, all actions are logically AND'd together, such that a user selecting a suggestion selects all of the actions within it"
* cards.suggestions.actions obeys cds-resp-2
* cards.suggestions.actions ^comment = "When a suggestion contains multiple actions, the actions SHOULD be processed as per FHIR's rules for processing transactions with the CDS Client's fhirServer as the base url for the inferred full URL of the transaction bundle entries. (Specifically, deletes happen first, then creates, then updates)."
* cards.suggestions.actions.type 1..1 code "create, update, delete - type of action performed" "The type of action being performed. Allowed values are: create, update, delete."
* cards.suggestions.actions.type from http://hl7.org/fhir/tools/ValueSet/CDSActionType (required)
* cards.suggestions.actions.description 0..1 string "Human-readable description of the suggested action" "Human-readable description of the suggested action that MAY be presented to the end-user."
* cards.suggestions.actions.description ^condition[0] = "cds-resp-5"
* cards.suggestions.actions.resource 0..1 Resource "FHIR resource to create/update" "When the type attribute is create, the resource attribute SHALL contain a new FHIR resource to be created. For update, this holds the updated resource in its entirety and not just the changed fields."
* cards.suggestions.actions.resource ^comment = "Use of this field to communicate a string of a FHIR id for delete suggestions is DEPRECATED and resourceId SHOULD be used instead."
* cards.suggestions.actions.resourceId 0..1 url "A relative reference to the relevant resource." "A relative reference to the relevant resource. SHOULD be provided when the type attribute is delete."
* cards.suggestions.actions.resourceId ^comment = ""
* cards.selectionBehavior 0..1 code "at-most-one | any" "Describes the intended selection behavior of the suggestions in the card. Allowed values are: at-most-one, indicating that the user may choose none or at most one of the suggestions; any, indicating that the end user may choose any number of suggestions including none of them and all of them"
* cards.selectionBehavior from http://hl7.org/fhir/tools/ValueSet/CDSSelectionBehavior (required)
* cards.selectionBehavior ^comment = "CDS Clients that do not understand the value MUST treat the card as an error."
* cards.selectionBehavior ^condition[+] = "cds-resp-1"
* cards.selectionBehavior ^condition[+] = "cds-resp-6"
* cards.overrideReasons 0..* Coding "Feedback from user on card - why not acted on" "Override reasons can be selected by the end user when overriding a card without taking the suggested recommendations. The CDS service MAY return a list of override reasons to the CDS client."
* cards.overrideReasons obeys cds-resp-4
* cards.overrideReasons ^comment = "The CDS Client SHOULD present these reasons to the clinician when they dismiss a card. A CDS Client MAY augment the override reasons presented to the user with its own reasons"
* cards.links 0..* http://hl7.org/fhir/tools/StructureDefinition/CDSHooksElement "Link to app or additional information" "Allows a service to suggest a link to an app that the user might want to run for additional information or to help guide a decision."
* cards.links obeys cds-resp-3
* cards.links.label 1..1 string "Human-readable label to display for this link" "Human-readable label to display for this link (e.g. the CDS Client might render this as the underlined text of a clickable link)."
* cards.links.url 1..1 url "URL to load" "URL to load (via GET, in a browser context) when a user clicks on this link. Note that this MAY be a 'deep link' with context embedded in path segments, query parameters, or a hash."
* cards.links.type 0..1 code "absolute | smart" "The type of the given URL. There are two possible values for this field. A type of absolute indicates that the URL is absolute and should be treated as-is. A type of smart indicates that the URL is a SMART app launch URL and the CDS Client should ensure the SMART app launch URL is populated with the appropriate SMART launch parameters"
* cards.links.type from http://hl7.org/fhir/tools/ValueSet/CDSLinkType (required)
* cards.links.appContext 0..1 string "Information to share when launching SMART app" "An optional field that allows the CDS Service to share information from the CDS card with a subsequently launched SMART app. The appContext field should only be valued if the link type is smart and is not valid for absolute links. The appContext field and value will be sent to the SMART app as part of the OAuth 2.0 access token response, alongside the other SMART launch parameters when the SMART app is launched. Note that appContext could be escaped JSON, base64 encoded XML, or even a simple string, so long as the SMART app can recognize it."
* cards.links.appContext ^comment = "CDS Client support for appContext requires additional coordination with the authorization server that is not described or specified in CDS Hooks nor SMART."
* systemActions 0..* contentReference #CDSHooksResponse.cards.suggestions.actions "Actions to auto-apply" "An array of Actions that the CDS Service proposes to auto-apply"
* systemActions ^extension.url = "http://hl7.org/fhir/tools/StructureDefinition/json-empty-behavior"
* systemActions ^extension.valueCode = #absent
* systemActions ^comment = "Each action follows the schema of a card-based suggestion.action. The CDS Client decides whether to auto-apply actions."
