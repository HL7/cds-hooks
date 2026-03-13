Invariant: ord-1
Description: "Must be in the format {type}/{id}"
* severity = #error
* expression = "$this.matches('^[\\\\d\\\\w]+\\\\/[\\\\d\\\\w-.]+$')"