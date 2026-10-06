Invariant: cds-resp-5
Description: "All suggestion actions must have a description"
* severity = #error
* expression = "actions.all(description.exists())"