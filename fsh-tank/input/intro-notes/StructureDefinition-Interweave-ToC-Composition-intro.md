## Introduction
This profile defines the use of the Composition resource in Transfer of Care messages. 

This resource is always provided, and contains a set of references to structured information from the Ambulance Service Electronic Patient Record.

It contains the following header fields:

 - **Status** - "preliminary" for pre-registration, or "final" for finalisation
 - **Type** - always SNOMED 312711000000101: "Ambulance Service Patient Summary Report" 
 - **Subject** - a reference to the patient (including their name in "display" text)
 - **Encounter** - a reference to the encounter
 - **Date** - the date and time generated
 - **Title** - always "Ambulatory Transfer of Care"
 - **Confidentiality** - always "N"ormal

  - *Note that the **Author** is a mandatory field in FHIR, but is not actually provided in the current messages*


The composition then contains the following sections:

1. **Incident Details** (SNOMED 913331000000108: Incident details) - **Always a reference to [Encounter](StructureDefinition-Interweave-ToC-Encounter.html)**

2. **Patient Demographics** (SNOMED 886731000000109: Patient Demographics)  - **Always a reference to [Patient](StructureDefinition-Interweave-ToC-Patient.html)**

3. **GP Practice** (SNOMED 886711000000101: General practitioner practice) - **Always a reference to [GP Practitioner](StructureDefinition-Interweave-ToC-GPPractitioner.html)**

4. **Presenting Complaints or Issues** (SNOMED 886891000000102: Presenting complaints or issues) - *not populated*

5. **Relevant Past History** (SNOMED 933271000000106: Relevant past medical, surgical and mental health history) - *not populated*

6. **Allergies and Adverse Reaction** (SNOMED 886921000000105: Allergies and adverse reaction) - *not populated*

7. **Observations** (SNOMED 1102421000000108: Observations)  - **Reference to Observations - vital signs and NEWS2**


   Where Observations are available a set of vital signs and NEWS2 scores will be provided, in accordance with the following CareConnect Observation profiles:
   - [BloodPressure](https://fhir.hl7.org.uk/STU3/StructureDefinition/CareConnect-BloodPressure-Observation-1)
   - [BodyTemperature](https://fhir.hl7.org.uk/STU3/StructureDefinition/CareConnect-BodyTemperature-Observation-1)
   - [ACVPU](https://fhir.hl7.org.uk/STU3/StructureDefinition/CareConnect-ACVPU-Observation-1)
   - [HeartRate](https://fhir.hl7.org.uk/STU3/StructureDefinition/CareConnect-HeartRate-Observation-1)
   - [InspiredOxygen](https://fhir.hl7.org.uk/STU3/StructureDefinition/CareConnect-InspiredOxygen-Observation-1)
   - [OxygenSaturation](https://fhir.hl7.org.uk/STU3/StructureDefinition/CareConnect-OxygenSaturation-Observation-1)
   - [RespiratoryRate](https://fhir.hl7.org.uk/STU3/StructureDefinition/CareConnect-RespiratoryRate-Observation-1)
   - [NEWS2](https://fhir.nhs.uk/STU3/StructureDefinition/CareConnect-NEWS2-Observation-1)


8. **Treatments and Interventions** (SNOMED 1077891000000107: Treatments and interventions) - *not populated*

9. **Medications and Medical Devices** (SNOMED 933361000000108: Medications and medical devices) - *not populated*

10. **Information and Advice Given** (SNOMED 1052951000000105: Information and advice given) - *not populated*

11. **Mobility** (SNOMED 325931000000109: Assessment) - *not populated*

12. **Investigation Outcome** (SNOMED 717661000000106: Outcome) - *not populated*



***Additional Notes:***
 - No text is provided with any of the sections. Textual information can be found in the PDF. The purpose of this composition is to provide references to structured data
 - References are provided as indicated - to the Encounter, Patient, GP, and Observations. 
   - Information about the Encounter is always available
   - References to the Patient and GP are always provided, but note that the contents of these resources may be skeletal - depending on what has been possible to ascertain
   - Observations are provided at Finalisation only, see below for further details of these
 - All other sections are empty, and contain an EmptyReason of "Unknown". (Future development may add additional datasets, at which time this specification will be updated)



>***Please refer to the examples to see how this will look in practice***