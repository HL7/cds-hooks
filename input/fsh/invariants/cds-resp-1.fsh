Invariant: cds-resp-1
Description: "only one action can be suggested if selectionBehavior = at-most-one"
* severity = #error
* expression = "(selectionBehavior = 'at-most-one') implies suggestions.where(isRecommended).count() <= 1"