## Introduction
This profile defines the use of the Encounter resource in Transfer of Care messages.

It contains:

 - **Identifiers** - both the EPR and Incident Ids
 - **Status** - "in-progress" for pre-registration, or "finished" for finalisation
 - **Class** - always "emergency"
 - **Type** - always "Ambulance-based care"
 - **Priority** - always "emergency"
 - **Subject** - a reference to the patient (including their name in "display" text)
 - **Period** - the start and end of the encounter
 - **Hospitalization** - only the "destination" field is used, and this indicates the A&E department being conveyed to. Generally this is self-evident to the recipient - unless there are several A&E departments at one location. (Note that this Location reference is essentially used as an identifier, and the referenced location resource is not included in the bundle.)

*(TBC - does it change between prereg / finalisation??)*
*TBC - is this where cancellation is recorded too?*

>***Please refer to the example to see how this will look in practice***