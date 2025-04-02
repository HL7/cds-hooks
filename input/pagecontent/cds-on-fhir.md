This section of the CDS Hooks specification discusses the evaluation use case for clinical decision support and how the various knowledge artifacts can be integrated into clinical workflow. The topic focuses on two main scenarios:

1. Using CDS Hooks to evaluate remote clinical decision support
2. Using CDS Hooks to surface clinical decision support behavior

Note that this topic is a very high-level approach to using CDS Hooks to support these two use cases. It is not a normative description of any of the CDS Hooks content. Please refer to the [CDS Hooks](index.html) specification itself for more details.

As with any clinical application, the use of decision support services must consider patient safety, security, and privacy issues. For a more complete discussion of this topic, including decision support-specific considerations, refer to the [Implementer's Safety Checklist](http://hl7.org/fhir/safety.html).

---

### Consuming Decision Support Using CDS Hooks

CDS Hooks is an open source specification focused on user-facing remote clinical decision support. CDS Hooks can use FHIR to represent patient information and recommendations, but is architecturally an independent specification. The basic components of CDS Hooks are:

| **Service** | A decision support service that accepts requests containing patient information, and provides responses |
| **Hook**    | A defined point within the client system's workflow with well-known contextual information provided as part of the request |
| **EHR**     | An electronic health record, or other clinical information system that consumes decision support in the form of services |
| **Card**    | Guidance from decision support services is returned in the form of cards, representing discrete recommendations or suggestions that are presented to the user within the EHR |
{:.grid}
---

#### Configuration

The first phase in consuming a CDS Service using CDS Hooks is to configure the integration from the EHR. The CDS Service publishes a set of endpoints to advertise available functionality using the [*discovery*](index.html#discovery) endpoint. For each endpoint, the service declares the *hook* during which it expects to be invoked, and optionally, any [*prefetch*](index.html#providing-fhir-resources-to-a-cds-service) information that could be provided to the service.

Each [*hook*]({{site.data.links.library-contexts.build.url}}index.html) identifies contextual information that is available within the EHR. For example, the [`order-sign` hook]({{site.data.links.library-contexts.build.url}}order-sign.html) specifies the patient in context, as well as the medications being prescribed. When invoking the service from this hook, the EHR is expected to provide this contextual information as part of the request.

In addition, the CDS Service may specify additional information using a [*prefetch template*](index.html#prefetch-template). Each prefetch template is a FHIR query URL, parameterized by the data available in context, and describing information needed by the CDS Service to perform its processing. By providing this information as part of the request, the EHR alleviates the need for the CDS Service to request the additional information.

The following example illustrates a typical service discovery response:

```json
{
  "services": [
    {
      "hook": "order-sign",
      "prefetch": {
        "patient": "Patient/{% raw  %}{{{% endraw  %}context.patientId}}",
        "labs": "... <FHIR Observation Resources - snipped for brevity>"
      },
      "name": "PlanDefinition_Recommendation_10_Order_Sign",
      "title": "Recommendation #10 - Urine Drug Testing (order-sign)",
      "description": "When prescribing opioids for subacute or chronic pain, clinicians should consider the benefits and risks of toxicology testing to assess for prescribed medications as well as other prescribed and nonprescribed controlled substances.",
      "id": "opioidcds-10-order-sign",
    },
    {
      "hook": "patient-view",
      "prefetch": {
        "patient": "Patient/{% raw  %}{{{% endraw  %}context.patientId}}"
      },
      "title": "Zika Virus Intervention",
      "description": "Identifies possible Zika exposure and offers suggestions for suggested actions for pregnant patients",
      "id": "zika-virus-intervention"
    }
  ]
}
```

#### Evaluation

The second phase is the actual request/response call to the CDS Service. Once the integration has been configured using the above information, the EHR can make requests to decision support services at the appropriate times based on the _hooks_ it supports. To make a request, the EHR prepares a [_request_](index.html#http-request-1) object containing the contextual information required for the hook, as well as any additional prefetch information.

For example, the following request illustrates a call to the CDS service:

``` json
{
  "hookInstance": "d1577c69-dfbe-44ad-ba6d-3e05e953b2ea",
  "fhirServer": "https://example.org/fhir",
  "hook": "order-sign",
  "context":
    {
      "draftOrders": [
        {
          "resourceType": "MedicationRequest",
          "id": "... <FHIR Resource - snipped for brevity>"
        }
      ],
      "patientId": "Patient/Patient-12214",
      "userId": "Practitioner/example"
    },
  "patient": "Patient/Patient-12214",
  "prefetch": {
    "medications": {
      "resource": {
        "resourceType": "Bundle",
        "entry": [
          {
            "fullUrl": "https://example.org/fhir/open/MedicationRequest/medrx002",
            "resource": {
              "resourceType": "MedicationRequest",
              "id": "... <FHIR Resource - snipped for brevity>"
            }
          }
        ]
      }
    }
  }
}
```

The service responds with a set of [_cards_](index.html#cds-service-response) describing any guidance in the form of [_card attributes_](index.html#card-attributes) that should be presented to the user:

``` json
{
  "cards": [
    {
      "summary": "Consider the Benefits and Risks of Conducting a Urine Toxicology Screen",
      "detail": "Consider the benefits and risks of toxicology testing to assess for prescribed medications as well as other prescribed and nonprescribed controlled substances.",
      "indicator": "warning",
      "source": {
          "uri": "https://www.cdc.gov/mmwr/volumes/71/rr/rr7103a1.htm#Recommendation10:~:text=nonprescribed%20controlled%20substances-,(recommendation%20category%3A%20B%3B%20evidence%20type%3A%204).,-Implementation%20Considerations"
      },
      "suggestions":[
        {
          "label": "Request to Perform a Urine Toxicology Screen",
          "actions": [
            {
              "type": "create",
              "description":"Request to perform a urine toxicology screen.",
              "resource": { 
                "resourceType": "ServiceRequest",
                "id": "... <Created FHIR Resource - snipped for brevity>" 
              }
            }
          ]
        }
      ],
      "selectionBehavior": "any",
      "links": [
        {
          "label": "2022 CDC Clinical Practice Guideline for Prescribing Opioids for Pain",
          "url": "https://www.cdc.gov/mmwr/volumes/71/rr/pdfs/rr7103a1-H.pdf",
          "type": "absolute"
        }
      ]
    }
  ]
}
```

At this point, the EHR processes the response and determines the most appropriate mechanism for displaying the results to the end-user. However, it is often the case that the results of the decision support interaction need to be persisted for future reference. The `GuidanceResponse` and `RequestOrchestration` FHIR resources provide a general mechanism that supports this use case.

In general, a CDS Hooks Response can be captured as a single `GuidanceResponse` that represents the overall response from the CDS Service, and a single `RequestOrchestration` containing the cards and suggestions, as illustrated by the following object-level mappings:

| **CDS Hooks Object** | **FHIR Resource Mapping** | **Description** |
| --- | --- | --- |
| Response | `GuidanceResponse` and `RequestOrchestration` | A CDS Hooks Response is 1 to 1 with a GuidanceResponse and an associated `RequestOrchestration` |
| Card | `RequestOrchestration.action` | Each Card in the response is represented as a top level action in the `RequestOrchestration`. The selectionBehavior of the action (i.e. among suggestions on the card) is specified by the selectionBehavior element of the card. |
| Suggestion | `RequestOrchestration.action.action` | Each suggestion on a card is represented as a nested action within the action for the card. The selectionBehavior of the action (i.e. among the actions described in the suggestion) is `all`, because CDS Hooks specifies that when a suggestion is accepted, all the actions on the suggestion are performed. |
| Action | `RequestOrchestration.action.action.action` | Each CDS Hooks Action on a card is represented as a nested action within the `RequestOrchestration` action for the suggestion, and the resource in the CDS Hooks Action populates the resource element of the `RequestOrchestration` action. |
{:.grid}

And the following table lists the element-level mappings:

| **CDS Hooks Element** | **FHIR Resource Mapping** |
| --- | --- |
| Request.hookInstance | `GuidanceResponse.requestId` & `RequestOrchestration.identifier` |
| Request URL | `GuidanceResponse.moduleUri` & `RequestOrchestration.instantiatesUri` |
| Response status | `GuidanceResponse.status` |
| Request Patient | `GuidanceResponse.subject` & `RequestOrchestration.subject` |
| Request time | `GuidanceResponse.occurrenceDateTime` & `RequestOrchestration.authoredOn` |
| Request service | `GuidanceResponse.performer` & `RequestOrchestration.author (as a Device)` |
| Response.card | `RequestOrchestration.action` |
| Response.card.summary | `RequestOrchestration.action.title` |
| Response.card.detail | `RequestOrchestration.action.description` |
| Response.card.indicator | `RequestOrchestration.priority` \| R`equestOrchestration.action.resource.priority`, using the mapping specified [here](http://hl7.org/fhir/conceptmap-cdshooks-indicator.html) |
| Response.card.source | `RequestOrchestration.action.relatedArtifact.where(type = 'documentation')` |
| Response.card.selectionBehavior | `RequestOrchestration.action.selectionBehavior` |
| Response.card.suggestion | `RequestOrchestration.action.action` |
| Response.card.suggestion.label | `RequestOrchestration.action.action.title` |
| Response.card.suggestion.uuid | `RequestOrchestration.action.action.id` |
| Response.card.suggestion.action | `RequestOrchestration.action.action.action` |
| Response.card.suggestion.action.type | `RequestOrchestration.action.action.action.type` |
| Response.card.suggestion.action.description | `RequestOrchestration.action.action.action.description` |
| Response.card.suggestion.action.resource | `RequestOrchestration.action.action.action.resource` |
{:.grid}

#### Surfacing Clinical Decision Support Guidance Using CDS Hooks

In addition to supporting the user-facing remote decision support use case, CDS Hooks can be used to surface clinical decision support behavior represented by FHIR knowledge artifacts. In this use case, a FHIR server functioning as a knowledge provider exposes CDS Hooks Services using the discovery endpoint, and provides guidance using the CDS Service endpoint. To support this, several mappings from FHIR Resources and elements to CDS Hooks services are used:

1.  **Hooks** - Hooks in CDS Hooks are mapped to the `TriggerDefinition` structure in FHIR
2.  **Services** - Services in CDS Hooks are mapped to the `PlanDefinition` resource in FHIR to provide evaluation behavior
3.  **Prefetch** - Prefetch templates in CDS Hooks are mapped to the `DataRequirement` structure in FHIR

#### Representing Hooks in FHIR

A _hook_ in CDS Hooks is a pre-defined point in the workflow of a clinical information system such as an EHR. Each hook defines [_context_](index.html#context), which is the information available as part of the current activity in the system. Each hook represents a point in the workflow that can be augmented by decision support from an external system. Within CDS Hooks, each hook defines the set of available context values, along with whether or not that context value can be used as a prefetch token.

For example, the [`patient-view` hook]({{site.data.links.library-contexts.build.url}}patient-view.html) defines `userId`, `patientId` and `encounterId` as context values and indicates that they are available for use as prefetch tokens (meaning that they can be used to parameterize prefetch templates).

Within FHIR, the concept of a hook can be represented using a combination of `TriggerDefinition` and `ParameterDefinition`:

| **CDS Hooks Element** | **FHIR Mapping** |
| --- | --- |
| Hook.name | `TriggerDefinition.where(type = 'named-event').name` |
| Hook.context.field | `ParameterDefinition.name` |
| Hook.context.priority | `ParameterDefinition.min` & `ParameterDefinition.max` |
| Hook.context.description | `ParameterDefinition.documentation` & `ParameterDefinition.type` & `ParameterDefinition.profile` |
{:.grid}

Note that using `TriggerDefinition` to represent hook information requires that hook details be duplicated everywhere they are used. Another approach would be to use the `EventDefinition` resource to capture the hook information once, and then reuse that by reference wherever it is needed.

#### Representing Services in FHIR

A _service_ in CDS Hooks is a clinical decision support service that can be used to provide guidance to users at pre-defined points in a workflow. The `PlanDefinition` resource can be used to describe the behavior of decision support functionality, which can then be exposed via a CDS Hooks service. In the simplest case, there is a one-to-one correspondence between a `PlanDefinition` and a CDS Service:

| **CDS Hooks Element** | **FHIR Mapping** |
| --- | --- |
| Service.id | `PlanDefinition.url` (without the base) |
| Service.title | `PlanDefinition.title` |
| Service.description | `PlanDefinition.description` |
| Service.hook | `PlanDefinition.action.trigger` |
| Service.prefetch | `PlanDefinition.data-requirement` |
{:.grid}

To support this representation, the [FHIR Clinical Reasoning Module](http://hl7.org/fhir/clinicalreasoning-module.html) defines a [CDSHooksServicePlanDefinition](http://hl7.org/fhir/plandefinition-cdshooks.html) profile, which also supports specifying the CDS Hooks endpoint on which the `PlanDefinition` should be exposed.

The `PlanDefinition/$apply` operation can then be used to provide the behavior of the CDS Hooks service, as described in the Processing CDS Hooks Requests section below.

#### Representing Prefetch in FHIR

In addition to the contextual information defined by the _hook_, services in CDS Hooks can request that additional information be supplied with each request in the form of _prefetch_ templates. These templates are parameterized FHIR query URLs that can be fulfilled by the EHR as part of the request, reducing the number of round-trips between the CDS Service and the EHR's FHIR server.

The concept of prefetch data is represented within FHIR as a `DataRequirement`, which can be transformed to an instance level read or type level search interaction as follows:

| **DataRequirement Element** | **Mapping to FHIR URL** |
| --- | --- |
| type | \[type\]{\[id\] \| ?\[parameters\]} |
| subject | subject={% raw  %}{{{% endraw  %}patientId}} |
| codeFilter | \[path\]{=\|:in}\[code\|valueSet\] |
| dateFilter | \[path\]{eq\|lt\|gt\|ge\|le}\[valueDateTime\|valuePeriod\|valueDuration\] |
| sort | \_sort=\[sort\] |
| limit | \_limit=\[limit\] |
{:.grid}

This prefetch data can be automatically determined from the data requirements of the `PlanDefinition` and provided as part of the service definition to the CDS Hooks discovery response.

#### Processing CDS Hooks Requests

Once the available `PlanDefinition` resources are advertised through the discovery endpoint, a CDS Hooks endpoint can be used to perform the actual evaluation, as illustrated in the following diagram:

``` mermaid
sequenceDiagram
    participant EHR as Electronic Health Record (EHR)
    participant Disc as Discovery Endpoint
    participant CDS as CDS Hooks Service

    EHR->>Disc: GET /cds-services
    Disc-->>EHR: Return service definitions (hooks, prefetch templates, etc...)
    EHR->>EHR: Determine active hook event (e.g., order-sign)
    EHR->>CDS: POST CDS Hooks Request (including context & optional prefetch data)
    CDS->>CDS: Process request via PlanDefinition/$apply
    CDS-->>EHR: Return CDS Cards (recommendations, suggestions, etc...)
    EHR->>User: Display guidance in UI
```

As depicted in the above diagram, an EHR invokes a CDS Hooks request at the appropriate point in the workflow, providing the requested context and data. The CDS Service responds by performing an $apply operation against the specified `PlanDefinition`, and transforming the resulting `RequestOrchestration` into a CDS Hooks response.

Because `PlanDefinition` resources can be used in a broad range of use cases, the [FHIR Clinical Reasoning Module](http://hl7.org/fhir/clinicalreasoning-module.html) defines the [CQL Library](http://hl7.org/fhir/library-cqf.html) and [Computable PlanDefinition](http://hl7.org/fhir/computableplandefinition.html) profiles to describe the special case of a `PlanDefinition` being used as an event-condition-action rule with conditions and other dynamic behavior specified in a CQL Library. This arrangement provides a common and consistent pattern for describing decision support that can be easily integrated using the CDS Hooks specification.