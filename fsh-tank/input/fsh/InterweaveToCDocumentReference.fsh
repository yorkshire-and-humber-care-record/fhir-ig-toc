Alias: $SCT = http://snomed.info/sct

Profile: InterweaveToCDocumentReference
Parent: CareConnect-DocumentReference-1
Id: Interweave-ToC-DocumentReference
Description: "Interweave ToC DocumentReference resource profile."
* ^status = #active

* id 1..1
* meta.lastUpdated 1..1
// Hmm, no profile this time!
//* meta.profile 1..*
// But we do have a version id!
* meta.versionId 1..1

// Tags
//  There is a tag to describe the document source
* meta.tag ^slicing.discriminator.type = #value
* meta.tag ^slicing.discriminator.path = "system"
* meta.tag ^slicing.ordered = false
* meta.tag ^slicing.rules = #open
* meta.tag contains
    DocSource 0..1 

* meta.tag[DocSource] ^short = "The source of the document within ambulance service internal systems"
* meta.tag[DocSource].system =  "https://fhir.yas.nhs.uk/Source" (exactly)
* meta.tag[DocSource].code 1..1
* meta.tag[DocSource].code ^short = "A code for the internal system supplying the document"
* meta.tag[DocSource].display 1..1
* meta.tag[DocSource].display ^short = "Name of the internal system supplying the document"


// Identifier:
// Identifer from the YAS EPR
* identifier ^slicing.discriminator.type = #value
* identifier ^slicing.discriminator.path = "system"
* identifier ^slicing.ordered = false
* identifier ^slicing.rules = #open

* identifier contains
    YasEprIdentifier 1..1

// This "system" is actaully not valid FHIR! must be an absolute reference
* identifier[YasEprIdentifier].system 1..1
* identifier[YasEprIdentifier].system = "YASEPR" (exactly)
* identifier[YasEprIdentifier].use 1..1
* identifier[YasEprIdentifier].use = #usual (exactly)
* identifier[YasEprIdentifier].value 1..1
* identifier[YasEprIdentifier].value ^short = "The EPR Identifier"
// Period assumed to match that of the entity
* identifier[YasEprIdentifier].period 0..0

// Status and docStatus
// Status is already mandatory in FHIR (challenge may be accurately populating it with anything other than "current")
// Add docStatus for useful additional information about the document (will normally just be "final")
* status 1..1
* status ^short = "Always 'current'"
* docStatus 1..1
* docStatus ^short = "Always 'final'"

// Type - this already is a mandatory field in FHIR!
* type ^short = "Always YAS Electronic Care Record"

// Subject - mandatory, and must refer to a patient
* subject 1..1
* subject ^short = "The patient who is the subject of the document"
* subject only Reference(CareConnect-Patient-1)
* insert Ruleset-ReferenceWithReferenceAndDisplay(subject)

//Indexed (called "date"in R4) is already a mandatory field

// No Author, but both Authenticator and Custodian. Both pointing at the Ambulance Service
* authenticator 1..1
* authenticator only Reference(CareConnect-Organization-1)
* insert Ruleset-ReferenceWithReferenceAndDisplay(authenticator)
* authenticator ^short = "The Ambulance Service involved"

* custodian 1..1
* custodian only Reference(CareConnect-Organization-1)
* insert Ruleset-ReferenceWithReferenceAndDisplay(custodian)
* custodian ^short = "The Ambulance Service involved"


// And finally the actual content. This and the attachment are already mandatory in FHIR, abut enforce some other fields.
// The data is embedded
* content.attachment.contentType 1..1
* content.attachment.contentType = #application/pdf (exactly)
* content.attachment.language 1..1
* content.attachment.data 1..1
* content.attachment.size 1..1
* content.attachment.title 1..1
* content.attachment.creation 1..1
// And URL - although not sure why as content is embedded already
//* content.attachment.url 1..1
* content.attachment.url ^short = "Unlikely to be needed as the content is embedded"

////////////////////////////////////////////////////////////////////////////////////////
// Remove fields we don't need
////////////////////////////////////////////////////////////////////////////////////////

//* insert Ruleset-RemoveUnwantedHeaderFields
* implicitRules 0..0
* language 0..0
* meta.id 0..0
* meta.security 0..0
//* meta.versionId 0..0
//* meta.tag 0..0
* text ^short = "Do NOT rely on this field. (Some examples on this site may automaticaly generate it, but not included in the actual messages)"
* contained 0..0

* masterIdentifier 0..0

* insert Ruleset-RemoveUnwantedIdentifierFieldsKeepUse
* insert Ruleset-RemoveUnwantedIdentifierFieldsForSliceKeepUse(YasEprIdentifier)

* category 0..0  //class in R3
* subject.id 0..0
* subject.identifier 0..0
// * created 0..0 - not in R4! Scripting will add this back for R3 during build
* author 0..0
* relatesTo 0..0
* description 0..0
* securityLabel 0..0
* context 0..0

* content.id 0..0
* content.format 0..0


////////////////////////////////////////////////////////////////////////////////////////
// Examples
////////////////////////////////////////////////////////////////////////////////////////

//******************* NB ************************************
//This example does not have a "type" or "indexed" - this represents the current implementation BUT is not valid FHIR!
//***********************************************************/

Instance: InterweaveToCDocumentReferenceExample
InstanceOf: InterweaveToCDocumentReference
Description: "Interweave Document Reference Transfer of Care example"


* meta.lastUpdated = "2022-02-01T09:37:00.441319+00:00"
* meta.profile[0] = "https://fhir-toc.yhcr.nhs.uk/StructureDefinition/Interweave-ToC-DocumentReference"
* meta.versionId = "1"

* insert Ruleset-BlankExampleText

* identifier[0].use = #usual
* identifier[0].system = "YASEPR"
* identifier[0].value = "91b12282-c8e6-4884-b635-8892a2a8463c"

* status = http://hl7.org/fhir/document-reference-status#current 
* docStatus = http://hl7.org/fhir/composition-status#final 

* type = http://loinc.org#29751-5 "Critical care records"
* type.text = "YAS electronic care record"

* date = "2022-02-01T09:37:00.441319+00:00" //indexed in STU3

* subject = Reference(InterweaveToCPatientExample) 
* subject.display = "Mr Fred BLOGGS"

* authenticator = Reference(InterweaveToCAmbulanceOrganizationExample)
* authenticator.display = "Yorkshire Ambulance Service NHS Trust"

* custodian = Reference(InterweaveToCAmbulanceOrganizationExample)
* custodian.display = "Yorkshire Ambulance Service NHS Trust"


// And finally the actual content. 
* content.attachment.contentType = #application/pdf
* content.attachment.language = #en-GB
* content.attachment.data = "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IG9iag0KPDwgL1R5cGUgL0NhdGFsb2cgL1BhZ2VzIDUgMCBSID4+DQplbmRvYmoNCjEzIDAgb2JqDQo8PCAvVGl0bGUgPGZlZmYwMDY1MDA1MDAwNTIwMDYxMDAzNDAwNTAwMDQ0MDA0Nj4NCi9BdXRob3IgPD4NCi9TdWJqZWN0IDw+DQovQ3JlYXRvciAoTWljcm9zb2Z0IFJlcG9ydGluZyBTZXJ2aWNlcyAxMC4wLjAuMCkNCi9Qcm9kdWNlciAoTWljcm9zb2Z0IFJlcG9ydGluZyBTZXJ2aWNlcyBQREYgUmVuZGVyaW5nIEV4dGVuc2lvbiAxMC4wLjAuMCkNCi9DcmVhdGlvbkRhdGUgKEQ6MjAyMjAzMzAxMjIyMDErMDEnMDAnKQ0KPj4NCmVuZG9iag0KeHJlZg0KMCAxNA0KMDAwMDAwMDAwMCA2NTUzNSBmDQowMDAwMDAwMDEwIDAwMDAwIG4NCjAwMDAwMDM1MDkgMDAwMDAgbg0KMDAwMDAxMjQxNSAwMDAwMCBuDQowMDAwMDAwMDY1IDAwMDAwIG4NCjAwMDAwMTI1MTUgMDAwMDAgbg0KMDAwMDAwNjc1NiAwMDAwMCBuDQowMDAwMDAzNjc1IDAwMDAwIG4NCjAwMDAwMDk3NDcgMDAwMDAgbg0KMDAwMDAwNjkyMiAwMDAwMCBuDQowMDAwMDEyMjQ3IDAwMDAwIG4NCjAwMDAwMDk5MTMgMDAwMDAgbg0KMDAwMDAxMjU5NiAwMDAwMCBuDQowMDAwMDEyNjQ5IDAwMDAwIG4NCnRyYWlsZXIgPDwgL1NpemUgMTQgL1Jvb3QgMTIgMCBSIC9JbmZvIDEzIDAgUiA+Pg0Kc3RhcnR4cmVmDQoxMjkxMg0KJSVFT0Y="
* content.attachment.url = "https://erpweb.yas.nhs.uk/Live/endpointservices/api/v2/documentreference/documents/91b12282-c8e6-4884-b635-8892a2a8463c"
* content.attachment.size = 13277
* content.attachment.title = "YASePR Transfer of Care Record"
* content.attachment.creation = "2022-02-01"
