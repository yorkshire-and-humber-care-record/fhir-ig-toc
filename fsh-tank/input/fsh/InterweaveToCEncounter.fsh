Alias: $SCT = http://snomed.info/sct

Profile: InterweaveToCEncounter
Parent: CareConnect-Encounter-1
Id: Interweave-ToC-Encounter
Description: "Interweave ToC Encounter resource profile."
* ^status = #active

* id 1..1
* meta.lastUpdated 1..1
* meta.profile 0..*
* text 0..1


// Identifiers - EPR and Incident Ids
* identifier ^slicing.discriminator.type = #value
* identifier ^slicing.discriminator.path = "system"
* identifier ^slicing.ordered = false
* identifier ^slicing.rules = #open

* identifier contains
    YasEprIdentifier 0..1 and
    YasIncidentIdentifier 1..1

* identifier[YasEprIdentifier].system 1..1
* identifier[YasEprIdentifier].system = "http://ns.yhcr.nhs.uk/yas/epr-id" (exactly)
* identifier[YasEprIdentifier].use 1..1
* identifier[YasEprIdentifier].use = #usual (exactly)
* identifier[YasEprIdentifier].value 1..1
* identifier[YasEprIdentifier].value ^short = "The EPR Identifier"
// Period assumed to match that of the entity
* identifier[YasEprIdentifier].period 0..0

* identifier[YasIncidentIdentifier].system 1..1
* identifier[YasIncidentIdentifier].system = "http://ns.yhcr.nhs.uk/yas/incident-id" (exactly)
* identifier[YasIncidentIdentifier].use 1..1
* identifier[YasIncidentIdentifier].use = #usual (exactly)
* identifier[YasIncidentIdentifier].value 1..1
* identifier[YasIncidentIdentifier].value ^short = "The Incident Identifier"
// Period assumed to match that of the entity
* identifier[YasIncidentIdentifier].period 0..0


// Status: Already mandatory in FHIR


// Class: Make mandatory, and tighten the coding.
* class from http://hl7.org/fhir/ValueSet/v3-ActEncounterCode (required)
* class ^short = "Classification of the encounter. EXTENSIBLE on request, eg to cover other care settings"
* insert Ruleset-RawCodingWithSystemCodeDisplay(class)

* classHistory 0..0

// Type: Make mandatory, and tighten coding based on the Care Connect list (use the SNOMED code for Ambulance-based care)
* type 1..1
* type from CareConnect-EncounterType-1 (required)
* insert Ruleset-CodingWithSystemCodeDisplay(type)
* type.coding[snomedCT] 1..1
* type.coding[snomedCT] from CareConnect-EncounterType-1 (required)
//* type.coding = $SCT#11424001 "Ambulance-based care" (exactly)


// Priority: Will normally (always?) be "Emergency"
* priority 1..1
* priority from http://hl7.org/fhir/ValueSet/v3-ActPriority (required)
* insert Ruleset-CodingWithSystemCodeDisplay(priority)

// Subject: Must be linked to a patient
* subject 1..1 
// We only want Patients - not Groups
* subject only Reference(CareConnect-Patient-1)
* insert Ruleset-ReferenceWithReferenceAndDisplay(subject)


// Period: Mandatory. When the encounter occurred is vital to know.
* period 1..1
* period.start 1..1
* period.end 0..1


// Hospitalization - shows where the patient was conveyed to
* hospitalization 1..1

// Remove unneeded CareConnect extensions
* hospitalization.extension[Extension-CareConnect-AdmissionMethod-1] 0..0
* hospitalization.extension[Extension-CareConnect-DischargeMethod-1] 0..0

// Destination: The A&E department conveyed to
* hospitalization.destination 1..1
* hospitalization.destination ^short = "The A&E Department conveyed to."
* insert Ruleset-ReferenceWithReferenceAndIdAndDisplay(hospitalization.destination)

// Location: Mandatory - where the patient was seen.
* location 1..1
* location.location 1..1
* insert Ruleset-ReferenceWithReferenceAndDisplay(location.location)
* location.status 1..1
* location.period 0..0


////////////////////////////////////////////////////////////////////////////////////////
// Remove fields we don't need
////////////////////////////////////////////////////////////////////////////////////////

* insert Ruleset-RemoveUnwantedHeaderFields

//  Remove Care Connect extensions which we don't need
* extension[Extension-CareConnect-OutcomeOfAttendance-1] 0..0
* extension[Extension-CareConnect-EmergencyCareDischargeStatus-1] 0..0

* insert Ruleset-RemoveUnwantedIdentifierFieldsKeepUse
* insert Ruleset-RemoveUnwantedIdentifierFieldsForSliceKeepUse(YasEprIdentifier)
* insert Ruleset-RemoveUnwantedIdentifierFieldsForSliceKeepUse(YasIncidentIdentifier)

* statusHistory 0..0
* episodeOfCare 0..0
* basedOn 0..0  //incomingReferral in STU3
* participant 0..0
* appointment 0..0
* length 0..0
* reasonCode 0..0  // reason in STU3
* diagnosis 0..0
* account 0..0
* serviceProvider 0..0
* partOf 0..0

* hospitalization.id 0..0
* hospitalization.preAdmissionIdentifier 0..0
* hospitalization.origin 0..0
* hospitalization.admitSource 0..0
* hospitalization.reAdmission 0..0
* hospitalization.dietPreference 0..0
* hospitalization.specialCourtesy 0..0
* hospitalization.specialArrangement 0..0
* hospitalization.dischargeDisposition 0..0


////////////////////////////////////////////////////////////////////////////////////////
// Examples
////////////////////////////////////////////////////////////////////////////////////////

Instance: InterweaveToCEncounterExample
InstanceOf: InterweaveToCEncounter
Description: "Interweave Encounter Transfer of Care example"

//(Note - important to put our profile first, or else the website won't recognise it!)
//* meta.lastUpdated = "2022-02-01T09:37:00Z"
* meta.lastUpdated = "2022-02-01T09:37:00.441319+00:00"
* meta.profile[0] = "https://fhir-toc.yhcr.nhs.uk/StructureDefinition/Interweave-ToC-Encounter"
* meta.profile[1] = "https://fhir.hl7.org.uk/STU3/StructureDefinition/CareConnect-Encounter-1"

* text.status = #generated
* text.div = "<div xmlns='http://www.w3.org/1999/xhtml'>The ePRID: 658430 has an associated incident number: 12345678 . ** The incident number should NEVER be used to match to directly match to a patient record. Only the ePR ID has a single definite reference to a single YAS patient record. **</div>"

* identifier[0].use = #usual
* identifier[0].system = "http://ns.yhcr.nhs.uk/yas/epr-id"
* identifier[0].value = "658430"

* identifier[1].use = #usual
* identifier[1].system = "http://ns.yhcr.nhs.uk/yas/incident-id"
* identifier[1].value = "12345678"

* status = #finished

* class = http://hl7.org/fhir/v3/ActCode#EMER "emergency"
* type.coding[0] = $SCT#11424001 "Ambulance-based care" 
* priority.coding[0] = http://hl7.org/fhir/v3/ActPriority#EM "emergency"


* subject = Reference(InterweaveToCPatientExample) 
* subject.display = "FRED BLOGGS"

* period.start = "2022-02-01T09:00:00.441319+00:00" 
* period.end = "2022-02-01T09:37:00.441319+00:00"


// ***********TODO This location reference is not included in the bundle (and may not even exist?) It is just a recognisable ID...
* hospitalization.destination.reference = "https://yhcr.nhs.uk/FHIR/Location/18978a5f-f1ff-49ae-a8c9-0b671ac4a4c3"
* hospitalization.destination.identifier.use = #official
* hospitalization.destination.identifier.value = "YHCR.18978a5f-f1ff-49ae-a8c9-0b671ac4a4c3"
* hospitalization.destination.display = "LEEDS GENERAL INFIRMARY - ED"

* location[0].location = Reference(InterweaveToCLocationExample)
* location[0].location.display = "1 Acacia Avenue  York YO21 1AB"
* location[0].status = #active




