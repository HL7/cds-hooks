Invariant: cds-resp-4
Description: "the CDS Service MUST populate a display value for each reason's Coding"
* severity = #error
* expression = "all(display.exists())"