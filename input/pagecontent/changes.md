### Change Log

CDS Hooks is an HL7 published specification for clinical decision support. Releases of the specification have been formally published through HL7.

Hook definitions are linked from CDS Hooks the specification. Note that hook definitions are not part of the CDS Hooks specification, they are independent specifications that follow the Hook Maturity Model. Hooks are published by HL7. Published and balloted hooks can be found at the current url. Hook version history is documented in each hook specification. 

#### CDS Hooks 2.0.1
CDS Hooks 2.0.1 is an errata release which makes no substantive changes from the CDS Hooks 2.0.0 release, but rather changes the publications look & feel by moving from a bespoke, project-specific publishing mechanism to the typical HL7 FHIR IG Publisher infrastructure. 

#### CDS Hooks 2.0.0 Release

The 2.0 Release added new a number of enhancements, including: 
* System actions
* Feedback support and override reasons
* Add isRecommended and topic elements
* Permit UserId Practitioner Role
* Add Coding type to simplify usage from object-oriented languages

Additionally, the following fixes or clarifications were made:
* [505](https://github.com/cds-hooks/docs/pull/505): Add optional card.source.topic to allow CDS Service to identify a high-level category
* [513](https://github.com/cds-hooks/docs/pull/513): CDS Service can suggest override reasons for user's to explain why guidance isn't taken
* [519](https://github.com/cds-hooks/docs/pull/519): CDS Client provides feedback to Service following user interaction (fka analytics endpoint)
* [FHIR-28663](https://jira.hl7.org/browse/FHIR-28663): Permit pagination in prefetch
* [FHIR-34274](https://jira.hl7.org/browse/FHIR-34274): Clarify how OperationOutcome should be used in prefetch
* [FHIR-28655](https://jira.hl7.org/browse/FHIR-28655): Production FHIR servers are required to use https

In addition, numerous clarifications, corrections, and non-substantive updates were made to the specification based on ballot and implementer feedback. For a complete list of changes applied, see the issues under the [HL7 Jira's 2020-Sep CDS Hooks ballot](https://jira.hl7.org/issues/?jql=project%20%3D%20FHIR%20AND%20Specification%20%3D%20%22CDS%20Hooks%20(FHIR)%20%5BFHIR-cds-hooks%5D%22%20AND%20issueFunction%20in%20inBallot(2020-Sep)%20ORDER%20BY%20issue) or the repository commit log.

#### CDS Hooks 1.0.0

Changes since the 2018 May Ballot Version, include:

#[187](https://github.com/cds-hooks/docs/pull/187): Conformance requirements for JWT signing algorithms
#[232](https://github.com/cds-hooks/docs/pull/232): Moved user from the request to hook context definitions
#[259](https://github.com/cds-hooks/docs/pull/259): Removed the analytics endpoint pending further implementation experience
#[320](https://github.com/cds-hooks/docs/pull/320): Added a new required selectionBehavior field to cards
#[340](https://github.com/cds-hooks/docs/pull/340): Changed 'hard-stop' indicator value to 'critical'

In addition, numerous clarifications, corrections, and non-substantive updates were made to the specification based on ballot and implementer feedback. For a complete list of changes applied, see the issues under the [Github 1.0 Milestone](https://github.com/cds-hooks/docs/issues?q=is%3Aissue+is%3Aclosed+milestone%3A1.0) or the repository commit log.

This was the first STU release  for the CDS Hooks specification. For a complete history of changes, see the repository commit log.
