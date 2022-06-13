# Overview

The Ambulance Transfer of Care messaging consists of three types of message which are sent from the Ambulance to the hospital Emergency Department where the patient is being conveyed:

1. **Pre-registration** - sent whilst the ambulance is in transit, once the destination Emergency Department has been decided. This alerts the ED to the incoming patient, and (optionally) allows pre-registration of patient demographics - including capturing the linkage to the ambulance Incident and/or Electronic Patient Record identifiers

2. **Cancellation** - this is used more rarely, and enables a pre-registration to be cancelled. For example if the Ambulance is diverted to a different ED. The message is identical to the pre-registration message, other than the Encounter status

3. **Finalisation** - this is sent after the patient has been handed over to the ED. It updates the pre-registration information with additional details which may have been captured since then, including Vital Signs observations. Most importantly, it also attaches a PDF with the full handover summary. Within a hospital's systems this is typically attached to the patient record, thus avoiding the need for manual handover of paperwork.


Each message consists of a FHIR Bundle of type "message" which contains:
 - **[Message Header](StructureDefinition-Interweave-ToC-MessageHeader.html)** - basic metadata and routing information about the sender, receiver and contents
 - **[Organizations](StructureDefinition-Interweave-ToC-Organization.html)** - to represent the sender and receiver (Ambulance Service and ED)
 - **[Document Reference](StructureDefinition-Interweave-ToC-DocumentReference.html)** ***(Finalisation only)*** - a document reference containing the embeded PDF
 - Bundle of type "document" which contains a **[Composition](StructureDefinition-Interweave-ToC-Composition.html)** including:
   - Subject - reference to the **[Patient](StructureDefinition-Interweave-ToC-Patient.html)**
   - Encounter - reference to the **[Encounter](StructureDefinition-Interweave-ToC-Encounter.html)**
   - Section: Incident Details - reference to the **[Encounter](StructureDefinition-Interweave-ToC-Encounter.html)**
   - Section: Patient Demographics - reference to the **[Patient](StructureDefinition-Interweave-ToC-Patient.html)**
   - Section: GP Practice - reference to the **[GP Practitioner](StructureDefinition-Interweave-ToC-GPPRactitioner.html)**
   - Section: **Observations** ***(Finalisation only)*** - reference to a set of vital signs plus NEWS2 score (see [Composition](StructureDefinition-Interweave-ToC-Composition.html) for further details)

   Plus bundled FHIR Resources for each of the above mentioned references.

   
***The following complete examples may be useful:***
 - [Pre-registration message](ToCFullExample-PreReg.txt)
 - [Finalisation message](ToCFullExample-Finalise.txt)
 - [PDF document](ExampleToC-full.pdf)


The diagram below further illustrates this structure:

   <img src=".\ToCMessageStructure.png" alt="Intro Text" style="clear:both; float:none">




