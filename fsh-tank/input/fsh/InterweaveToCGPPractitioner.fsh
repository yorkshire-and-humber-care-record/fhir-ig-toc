Profile: InterweaveToCGPPractitioner
Parent: CareConnect-Practitioner-1
Id: Interweave-ToC-GPPractitioner
Description: "Interweave ToC GP Practitioner resource profile."
* ^status = #active


// This is a "practitioner" resource that is used to represent the patient's GP
// (In my opinion the "organization" resource should have been used instead and is a better fit)

// This is all optional, as pre-registration some of it is included but with blanks.
// (This is actually invalid FHIR, and the correct approach is to omit the field entirely)
// (And why send the Practitioner at all if not known?)
// Assume however that it may not always be possible to discover the patient's GP

* id 1..1
// Last updated is for some reason not provided with this resource
// * meta.lastUpdated 1..1
* meta.profile 0..*


// Identifier - add a slice for the ODS code of the GP Practice - if known
// (Yes... this is certainly a clue that the Organization resource might be more appropriate for this task!)
* identifier contains
    ODSOrganizationCode 0..1

* identifier[ODSOrganizationCode].system 1..1 
* identifier[ODSOrganizationCode].system = "https://fhir.nhs.uk/Id/ods-organization-code" (exactly)
* identifier[ODSOrganizationCode].value 1..1 
* identifier[ODSOrganizationCode] ^short = "The ODS Code of the GP Practice"
* identifier[ODSOrganizationCode].value ^short = "The ODS Code of the GP Practice"



// Probably always true? For some reason used here but not on other resources?
* active 1..1

// Name leave optional
// May not always be included! (As it is really representing the GP Practice organisat!)
// But may be included if known

// Work phone number of the GP practice, if known. (In practice may contain blanks)
* telecom 0..1
* telecom ^short = "Work phone number for the GP Practice"
* telecom.system 1..1
* telecom.value 1..1
* telecom.use 1..1

// Address: the work address of the GP Practice, if known. (In practice may contain blanks)
// (This uses the fields in a very strange way - incomplete information in "text", plus a postcode)
* address 0..1
* address ^short = "Work address for the GP Practice"
* address.use 1..1
* address.type 1..1
* address.text 1..1
* address.postalCode 1..1




////////////////////////////////////////////////////////////////////////////////////////
// Remove fields we don't need
////////////////////////////////////////////////////////////////////////////////////////

* insert Ruleset-RemoveUnwantedHeaderFields

// Extensions
* extension[Extension-CareConnect-NHSCommunication-1] 0..0

// Other fields
* identifier[sdsUserID] 0..0
* identifier[sdsRoleProfileID] 0..0

* insert Ruleset-RemoveUnwantedIdentifierFields
* insert Ruleset-RemoveUnwantedIdentifierFieldsForSlice(ODSOrganizationCode)

* gender 0..0
* birthDate 0..0
* photo 0..0
* qualification 0..0

* insert Ruleset-RemoveUnwantedTelcomFields

* address.id 0..0
* address.line 0..0
* address.city 0..0
* address.district 0..0
* address.state 0..0
* address.country 0..0
* address.period 0..0

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Examples
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

Instance: InterweaveToCGPPractitionerExampleFinalise
InstanceOf: InterweaveToCGPPractitioner
Description: "Interweave GP Practitioner Transfer of Care example (finalise)"

* meta.lastUpdated = "2022-02-01T09:37:00.441319+00:00"
* meta.profile[0] = "https://fhir-toc.yhcr.nhs.uk/StructureDefinition/Interweave-ToC-GPPractitioner"
* meta.profile[1] = "https://fhir.hl7.org.uk/STU3/StructureDefinition/CareConnect-Practitioner-1"

* insert Ruleset-BlankExampleText

* identifier[0].system = "https://fhir.nhs.uk/Id/ods-organization-code"
* identifier[0].value = "B81004"

* active = true

* telecom[0].system = #phone "Phone"
* telecom[0].use = #work "Work"
* telecom[0].value = "01234 123412"

* address[0].use = #work
* address[0].type = #physical
* address[0].text = "THE SURGERY 37 EASTGATE HORNSEA"
* address[0].postalCode = "HU18 1LP"



Instance: InterweaveToCGPPractitionerExamplePreReg
InstanceOf: InterweaveToCGPPractitioner
Description: "Interweave GP Practitioner Transfer of Care example (prereg)"

* meta.lastUpdated = "2022-02-01T09:37:00.441319+00:00"
* meta.profile[0] = "https://fhir-toc.yhcr.nhs.uk/StructureDefinition/Interweave-ToC-GPPractitioner"
* meta.profile[1] = "https://fhir.hl7.org.uk/STU3/StructureDefinition/CareConnect-Practitioner-1"

* insert Ruleset-BlankExampleText

// No identifier (if not known)

* active = true

// Blanks if not known 
// (NB This is not valid FHIR! Would be better to omit entirely, but this is the current implementation)
* telecom[0].system = #phone "Phone"
* telecom[0].use = #work "Work"
* telecom[0].value = ""

* address[0].use = #work
* address[0].type = #physical
* address[0].text = ""
* address[0].postalCode = ""

