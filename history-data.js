var pageJSON = `{
	"package-id": "hl7.fhir.uv.cds-hooks",
	"title": "CDS Hooks",
	"canonical": "https://cds-hooks.hl7.org/",
	"introduction": "The CDS Hooks … remote clinical decision support can be requested per the CDS Hooks Specification, which can be found at: https://cds-hooks.hl7.org.",
	"category": "CDS",
	"list": [
		{
			"version": "current",
			"desc": "Continuous Integration Build (latest in version control)",
			"path": "http://build.fhir.org/ig/HL7/cds-hooks",
			"status": "ci-build",
			"sequence": "ci-build"
		},
		{
			"version": "2.0.1",
			"path": "https://cds-hooks.hl7.org/STU2",
			"status": "trial-use",
			"sequence": "STU2",
			"fhirversion": "4.0.1",
			"date": "2025-01-30",
			"desc": "CDS Hooks STU2 Errata Publication",
			"changes": "Move specification from bespoke to HL7 FHIR publishing mechanism.",
			"current": true
		},
		{
			"version": "2.0.0",
			"path": "https://cds-hooks.hl7.org/2.0",
			"status": "trial-use",
			"sequence": "STU2",
			"fhirversion": "4.0.1",
			"date": "2022-09-16",
			"desc": "CDS Hooks STU2",
			"changes": "The 2.0 Release added new a number of enhancements, including: system actions, seedback support and override reasons. See the Change Log for full details."
		},
		{
			"version": "1.1.0",
			"path": "https://cds-hooks.hl7.org/ballots/2020Sep/",
			"status": "trial-use",
			"sequence": "STU2",
			"fhirversion": "4.0.1",
			"date": "2020-09-01",
			"desc": "CDS Hooks STU2 Ballot v1.1",
			"changes": "CDS Hooks v1.1 was published as 2.0.0. See Change Log."
		},
		{
			"version": "1.0.0",
			"status": "trial-use",
			"sequence": "STU1",
			"fhirversion": "4.0.1",
			"path": "https://cds-hooks.hl7.org/1.0/",
			"date": "2019-04-24",
			"desc": "Initial publication of CDS Hooks specification."
		},
		{
			"version": "1.0.0-ballot-201805",
			"status": "ballot",
			"sequence": "STU1",
			"fhirversion": "4.0.1",
			"path": "https://cds-hooks.hl7.org/ballots/2018May/",
			"date": "2018-05-01",
			"current": false,
			"desc": ""
		}
	]
}`;
