Invariant: cds-fb-3
Description: "An overrideReason must contain a reason, a userComment, or both"
* severity = #error
* expression = "reason.exists() or userComment.exists()"
