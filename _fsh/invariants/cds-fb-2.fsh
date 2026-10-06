Invariant: cds-fb-2
Description: "If outcome is 'accepted', acceptedSuggestions SHALL be provided"
* severity = #error
* expression = "(outcome = 'accepted') implies acceptedSuggestions.exists()"
