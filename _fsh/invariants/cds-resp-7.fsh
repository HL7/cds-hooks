Invariant: cds-resp-7
Description: "actionSelectionBehavior must be 'all', 'any', or 'at-most-one'"
* severity = #error
* expression = "actionSelectionBehavior.empty() or actionSelectionBehavior = 'all' or actionSelectionBehavior = 'any' or actionSelectionBehavior = 'at-most-one'"
