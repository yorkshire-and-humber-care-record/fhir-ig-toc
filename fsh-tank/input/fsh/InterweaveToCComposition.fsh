Alias: $SCT = http://snomed.info/sct

Profile: InterweaveToCComposition
Parent: CareConnect-Composition-1
Id: Interweave-ToC-Composition
Description: "Interweave ToC Composition resource profile."
* ^status = #active

* id 1..1
//* meta.lastUpdated 1..1

// No profile in the examples shown
//* meta.profile 1..*

// Status and Type are already mandatory in CareConnect

// * type = $SCT#312711000000101 "Ambulance Service Patient Summary Report" (exactly)
// * type.text = "Discharge from ambulance clinical care" (exactly)
* type ^short = "Always 312711000000101: Ambulance Service Patient Summary Report"

// Subject is already mandatory in CareConnect
* insert Ruleset-ReferenceWithReferenceAndDisplay(subject)

* encounter 1..1
* insert Ruleset-ReferenceWithReferenceOnly(encounter)
* encounter only Reference(Interweave-ToC-Encounter)

// Date and Title are already mandatory in CareConnect
* title ^short = "Always 'Ambulatory Transfer of Care'"

// NB! Author is mandatory in FHIR... but not actaully provided!
* author ^short = "NOT ACTUALLY PROVIDED"

* confidentiality 1..1

////////////////////////////////////////////////////////////////////////////////////////
// Slices for the document sections
////////////////////////////////////////////////////////////////////////////////////////

// Set up the slicing - it is ordered and closed, because we want exactly these sections in this order
* section ^slicing.discriminator.type = #value
* section ^slicing.discriminator.path = "code"
* section ^slicing.ordered = true
* section ^slicing.rules = #closed

* section contains
    incidentDetails 1..1 and
    patientDemographics 1..1 and
    gpPractice 1..1 and
    presentingComplaints 1..1 and
    history 1..1 and
    allergies 1..1 and
    observations 1..1 and
    treatments 1..1 and
    medications 1..1 and
    information 1..1 and
    mobility 1..1 and
    outcome 1..1

* insert Ruleset-AddCompositionSection(incidentDetails, "Incident Details", 913331000000108, "Incident details")
* insert Ruleset-AddCompositionSection(patientDemographics, "Patient Demographics", 886731000000109, "Patient Demographics")
* insert Ruleset-AddCompositionSection(gpPractice, "GP Practice", 886711000000101, "General practitioner practice")
* insert Ruleset-AddCompositionSection(observations, "Observations", 1102421000000108, "Observations")

* insert Ruleset-AddCompositionDummySection(presentingComplaints, "Presenting Complaints or Issues", 886891000000102, "Presenting complaints or issues")
* insert Ruleset-AddCompositionDummySection(history, "Relevant Past History", 933271000000106, "Relevant past medical\, surgical and mental health history")
* insert Ruleset-AddCompositionDummySection(allergies, "Allergies and Adverse Reaction", 886921000000105, "Allergies and adverse reaction")
* insert Ruleset-AddCompositionDummySection(treatments, "Treatments and Interventions", 1077891000000107, "Treatments and interventions")
* insert Ruleset-AddCompositionDummySection(medications, "Medications and Medical Devices", 933361000000108, "Medications and medical devices")
* insert Ruleset-AddCompositionDummySection(information, "Information and Advice Given", 1052951000000105, "Information and advice given")
* insert Ruleset-AddCompositionDummySection(mobility, "Mobility", 325931000000109, "Assessment")
* insert Ruleset-AddCompositionDummySection(outcome, "Investigation Outcome", 717661000000106, "Outcome")

// Always a reference to the encounter
* section[incidentDetails].entry 1..1
* section[incidentDetails].entry only Reference(Interweave-ToC-Encounter)
* section[incidentDetails].entry ^short = "Reference to the Encounter"

// Always a referece to the patient (even if the patient details populated are skeletal)
* section[patientDemographics].entry 1..1
* section[patientDemographics].entry only Reference(Interweave-ToC-Patient)
* section[patientDemographics].entry ^short = "Reference to the Patient"

// A reference to the GP practice (even if not known then a skeletal reference will be provided)
* section[gpPractice].entry 1..1
* section[gpPractice].entry only Reference(Interweave-ToC-GPPractitioner)
* section[gpPractice].entry ^short = "Reference to GP Practitioner (may contain empty details if not known)"

// The observations, if provided, will reference the set of vital signs observations
// (Note - these are references, so there is nothing to actaully slice on - so can't further define this here)
* section[observations].entry 0..*
* section[observations].entry only Reference(CareConnect-Observation-1)
* section[observations].entry ^short = "References to vital signs and NEWS2 score observations (if provided)"



////////////////////////////////////////////////////////////////////////////////////////
// Remove fields we don't need
////////////////////////////////////////////////////////////////////////////////////////

* insert Ruleset-RemoveUnwantedHeaderFields
// Put back text, which does actually seem to be provided
* text ^short = "Text summary of the resource, for human interpretation"

// Extensions
* extension[Extension-CareConnect-CareSettingType-1] 0..0

// Other fields
* identifier 0..0
* category 0..0   // class in STU3
* attester 0..0
* custodian 0..0
* relatesTo 0..0
* event 0..0




////////////////////////////////////////////////////////////////////////////////////////
// Examples
////////////////////////////////////////////////////////////////////////////////////////

Instance: InterweaveToCCompositionExamplePreReg
InstanceOf: InterweaveToCComposition
Description: "Interweave Encounter Transfer of Care example - Pre Registration"

//(Note - important to put our profile first, or else the website won't recognise it!)
//* meta.lastUpdated = "2022-02-01T09:37:00.441319+00:00"
* meta.profile[0] = "https://fhir-toc.yhcr.nhs.uk/StructureDefinition/Interweave-ToC-Composition"
* meta.profile[1] = "https://fhir.hl7.org.uk/STU3/StructureDefinition/CareConnect-Composition-1"

* text.status = #generated
* text.div = "<div xmlns='http://www.w3.org/1999/xhtml'>\n    <p>Yorkshire Ambulance Service Transfer of Care for JOHN SMITH, NHS Number: 1234567890</p>\n    </div>"

//***********************************************************
* status = #preliminary
//***********************************************************

* type = $SCT#312711000000101 "Ambulance Service Patient Summary Report" 
* type.text = "Discharge from ambulance clinical care"

* subject = Reference(InterweaveToCPatientExample) 
* subject.display = "FRED BLOGGS"
* encounter = Reference(InterweaveToCEncounterExample)

* date = "2022-02-01T09:37:00Z"
* title = "Ambulatory Transfer of Care"

// NB! Author is mandatory in FHIR... but not actaully provided!
* author.reference = "NOT ACTUALLY PROVIDED"
* confidentiality = #N

// And now the sections:

* insert Ruleset-AddCompositionSectionExample("Incident Details", 913331000000108, "Incident details")
* section[=].entry = Reference(InterweaveToCEncounterExample)

* insert Ruleset-AddCompositionSectionExample("Patient Demographics", 886731000000109, "Patient Demographics")
* section[=].entry = Reference(InterweaveToCPatientExample)

* insert Ruleset-AddCompositionSectionExample("GP Practice", 886711000000101, "General practitioner practice")
* section[=].entry = Reference(InterweaveToCGPPractitionerExampleFinalise)

* insert Ruleset-AddCompositionDummySectionExample("Presenting Complaints or Issues", 886891000000102, "Presenting complaints or issues")
* insert Ruleset-AddCompositionDummySectionExample("Relevant Past History", 933271000000106, "Relevant past medical\, surgical and mental health history")
* insert Ruleset-AddCompositionDummySectionExample("Allergies and Adverse Reaction", 886921000000105, "Allergies and adverse reaction")

* insert Ruleset-AddCompositionSectionExample("Observations", 1102421000000108, "Observations")
//**************************************************
* section[=].emptyReason.coding = http://hl7.org/fhir/list-empty-reason#unavailable "Unavailable"
//**************************************************

* insert Ruleset-AddCompositionDummySectionExample("Treatments and Interventions", 1077891000000107, "Treatments and interventions")
* insert Ruleset-AddCompositionDummySectionExample("Medications and Medical Devices", 933361000000108, "Medications and medical devices")
* insert Ruleset-AddCompositionDummySectionExample("Information and Advice Given", 1052951000000105, "Information and advice given")
* insert Ruleset-AddCompositionDummySectionExample("Mobility", 325931000000109, "Assessment")
* insert Ruleset-AddCompositionDummySectionExample("Investigation Outcome", 717661000000106, "Outcome")






Instance: InterweaveToCCompositionExampleFinalise
InstanceOf: InterweaveToCComposition
Description: "Interweave Encounter Transfer of Care example - Finalise"

//(Note - important to put our profile first, or else the website won't recognise it!)
//* meta.lastUpdated = "2022-02-01T09:37:00.441319+00:00"
* meta.profile[0] = "https://fhir-toc.yhcr.nhs.uk/StructureDefinition/Interweave-ToC-Composition"
* meta.profile[1] = "https://fhir.hl7.org.uk/STU3/StructureDefinition/CareConnect-Composition-1"

* text.status = #generated
* text.div = "<div xmlns='http://www.w3.org/1999/xhtml'>\n    <p>Yorkshire Ambulance Service Transfer of Care for JOHN SMITH, NHS Number: 1234567890</p>\n    </div>"

//***********************************************************
* status = #final
//***********************************************************

* type = $SCT#312711000000101 "Ambulance Service Patient Summary Report" 
* type.text = "Discharge from ambulance clinical care"

* subject = Reference(InterweaveToCPatientExample) 
* subject.display = "FRED BLOGGS"
* encounter = Reference(InterweaveToCEncounterExample)

* date = "2022-02-01T09:37:00Z"
* title = "Ambulatory Transfer of Care"

// NB! Author is mandatory in FHIR... but not actaully provided!
* author.reference = "NOT ACTUALLY PROVIDED"
* confidentiality = #N

// And now the sections:

* insert Ruleset-AddCompositionSectionExample("Incident Details", 913331000000108, "Incident details")
* section[=].entry = Reference(InterweaveToCEncounterExample)

* insert Ruleset-AddCompositionSectionExample("Patient Demographics", 886731000000109, "Patient Demographics")
* section[=].entry = Reference(InterweaveToCPatientExample)

* insert Ruleset-AddCompositionSectionExample("GP Practice", 886711000000101, "General practitioner practice")
* section[=].entry = Reference(InterweaveToCGPPractitionerExampleFinalise)

* insert Ruleset-AddCompositionDummySectionExample("Presenting Complaints or Issues", 886891000000102, "Presenting complaints or issues")
* insert Ruleset-AddCompositionDummySectionExample("Relevant Past History", 933271000000106, "Relevant past medical\, surgical and mental health history")
* insert Ruleset-AddCompositionDummySectionExample("Allergies and Adverse Reaction", 886921000000105, "Allergies and adverse reaction")

* insert Ruleset-AddCompositionSectionExample("Observations", 1102421000000108, "Observations")
* section[=].entry[+].reference = "Observation/BloodPressure-guid-here"
* section[=].entry[+].reference = "Observation/BodyTemperature-guid-here"
* section[=].entry[+].reference = "Observation/ACVPU-guid-here"
* section[=].entry[+].reference = "Observation/HeartRate-guid-here"
* section[=].entry[+].reference = "Observation/InspiredOxygen-guid-here"
* section[=].entry[+].reference = "Observation/OxygenSaturation-guid-here"
* section[=].entry[+].reference = "Observation/RespiratoryRate-guid-here"
* section[=].entry[+].reference = "Observation/NEWS2-guid-here"

* insert Ruleset-AddCompositionDummySectionExample("Treatments and Interventions", 1077891000000107, "Treatments and interventions")
* insert Ruleset-AddCompositionDummySectionExample("Medications and Medical Devices", 933361000000108, "Medications and medical devices")
* insert Ruleset-AddCompositionDummySectionExample("Information and Advice Given", 1052951000000105, "Information and advice given")
* insert Ruleset-AddCompositionDummySectionExample("Mobility", 325931000000109, "Assessment")
* insert Ruleset-AddCompositionDummySectionExample("Investigation Outcome", 717661000000106, "Outcome")




////////////////////////////////////////////////////////////////////////////////////////
// Helper Rulesets for adding composition sections
////////////////////////////////////////////////////////////////////////////////////////
RuleSet: Ruleset-AddCompositionSection(sliceName, sectionTitle, sectionSctCode, sectionCodeDescription)

* section[{sliceName}] ^short = {sectionTitle}

* section[{sliceName}].title 1..1
* section[{sliceName}].title  = {sectionTitle} (exactly)

* section[{sliceName}].code 1..1
* section[{sliceName}].code = $SCT#{sectionSctCode} {sectionCodeDescription} (exactly)

* section[{sliceName}].mode 1..1
* section[{sliceName}].mode = #snapshot (exactly)

* section[{sliceName}].orderedBy 0..0  //Not used
* section[{sliceName}].section 0..0  //No subsections

* section[{sliceName}].text.status = #empty (exactly)
* section[{sliceName}].text ^short = "NOT POPULATED"



RuleSet: Ruleset-AddCompositionDummySection(sliceName, sectionTitle, sectionSctCode, sectionCodeDescription)

* section[{sliceName}] ^short = {sectionTitle}

* section[{sliceName}].title 1..1
* section[{sliceName}].title  = {sectionTitle} (exactly)

* section[{sliceName}].code 1..1
* section[{sliceName}].code = $SCT#{sectionSctCode} {sectionCodeDescription} (exactly)

* section[{sliceName}].mode 1..1
* section[{sliceName}].mode = #snapshot (exactly)

* section[{sliceName}].orderedBy 0..0  //Not used
* section[{sliceName}].section 0..0  //No subsections

* section[{sliceName}].text.status = #empty (exactly)
* section[{sliceName}].text ^short = "NOT POPULATED"

// And then, to make it dummy...

* section[{sliceName}].entry 0..0

* section[{sliceName}].emptyReason 1..1
* section[{sliceName}].emptyReason ^short = "Unavailable"
* section[{sliceName}].emptyReason.coding = http://hl7.org/fhir/list-empty-reason#unavailable "Unavailable" (exactly)



RuleSet: Ruleset-AddCompositionSectionExample(sectionTitle, sectionSctCode, sectionCodeDescription)

* section[+].title  = {sectionTitle}
* section[=].code = $SCT#{sectionSctCode} {sectionCodeDescription}
* section[=].mode = #snapshot
* section[=].text.status = #empty
* section[=].text.div = "<div xmlns=\"http://www.w3.org/1999/xhtml\">Text Not Provided</div>"


RuleSet: Ruleset-AddCompositionDummySectionExample(sectionTitle, sectionSctCode, sectionCodeDescription)

* section[+].title  = {sectionTitle}
* section[=].code = $SCT#{sectionSctCode} {sectionCodeDescription}
* section[=].mode = #snapshot
* section[=].text.status = #empty
* section[=].text.div = "<div xmlns=\"http://www.w3.org/1999/xhtml\">Text Not Provided</div>"

// And then, to make it dummy...
* section[=].emptyReason.coding = http://hl7.org/fhir/list-empty-reason#unavailable "Unavailable"
