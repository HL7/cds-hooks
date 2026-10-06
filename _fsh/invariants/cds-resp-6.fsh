Invariant: cds-resp-6
Description: "If suggestions are present, selectionBehavior MUST also be provided."
* severity = #error
* expression = "suggestions.exists() implies selectionBehavior.exists()"