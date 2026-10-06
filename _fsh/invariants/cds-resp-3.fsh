Invariant: cds-resp-3
Description: "AppContext only for smart Apps"
* severity = #error
* expression = "(type != 'smart') implies (appContext.empty())"