Invariant: cds-resp-2
Description: "A resourceId not a resource must be provided when type = delete"
* severity = #warning
* expression = "(type = 'delete') implies (resourceId.exists() and resource.empty())"