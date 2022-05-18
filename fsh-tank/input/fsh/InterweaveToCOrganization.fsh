Profile: InterweaveToCOrganization
Parent: CareConnect-Organization-1
Id: Interweave-ToC-Organization
Description: "Interweave ToC Organization resource profile."
* ^status = #active


* id 1..1
* meta.lastUpdated 1..1
* meta.profile 0..*

//tag: fhir.yas.nhs.uk/Source

// Identifier (ODS) - CareConnect already defines a special identifier for ODS Code
* identifier[odsOrganisationCode] 1..1
* identifier[odsOrganisationCode].system 1..1
* identifier[odsOrganisationCode].value 1..1
* identifier[odsOrganisationCode] ^short = "The ODS Code of the Ambulance Service"

// Type - either "Healthcare Provider" from the standard Care Connect list OR "NHS Trust" from an entirely made up list!
// ******************TODO - actually it seems to be inconsistent what is in here, sometimes NHS Trust for the Ambulance too*****

* type 1..1
//* type from http://hl7.org/fhir/ValueSet/organization-type (required)
* insert Ruleset-CodingWithSystemCodeDisplay(type)
* type ^short = "Either 'Healthcare Provider' for the Ambulance Service, or 'NHS Trust' for the hospital"

* name 1..1

* telecom 0..1
* telecom ^short = "Work phone number of the organisation"
* address 1..1
* address ^short = "Work address of the organisation"

////////////////////////////////////////////////////////////////////////////////////////
// Remove fields we don't need
////////////////////////////////////////////////////////////////////////////////////////

* insert Ruleset-RemoveUnwantedHeaderFields

// Extensions
* extension[Extension-CareConnect-MainLocation-1] 0..0
* extension[http://hl7.org/fhir/StructureDefinition/organization-period] 0..0

// Other fields
* identifier[odsSiteCode] 0..0

* insert Ruleset-RemoveUnwantedIdentifierFields
* insert Ruleset-RemoveUnwantedIdentifierFieldsForSlice(odsOrganisationCode)

* alias 0..0
* partOf 0..0
* contact 0..0
* endpoint 0..0

* insert Ruleset-RemoveUnwantedTelcomFields


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Examples
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
Instance: InterweaveToCAmbulanceOrganizationExample
InstanceOf: InterweaveToCOrganization
Description: "Interweave Ambulance Service Organization Transfer of Care example (composition)"

* id = "RX8"

//(Note - important to put our profile first, or else the website won't recognise it!)
* meta.lastUpdated = "2022-02-01T09:37:00.441319+00:00"
* meta.profile[0] = "https://fhir-toc.yhcr.nhs.uk/StructureDefinition/Interweave-ToC-Organization"
* meta.profile[1] = "https://fhir.hl7.org.uk/STU3/StructureDefinition/CareConnect-Organization-1"

* insert Ruleset-BlankExampleText

* identifier[0].system = "https://fhir.nhs.uk/Id/ods-organization-code"
* identifier[0].value = "RX8"

* name = "YORKSHIRE AMBULANCE SERVICE NHS TRUST"
* type.coding = http://hl7.org/fhir/organization-type#prov "Healthcare Provider"

// TODO - it's not clear whether this is included or not - inconsistent examples
* telecom[0].system = #phone
* telecom[0].value = "01924 584000"
* telecom[0].use = #work

// TODO - it's not clear whether the "use" and "type" fields are included or not - inconsistent examples
* address[0].use = #work
* address[0].type = #both
* address[0].line[0] = "SPRINGHILL 2"
* address[0].line[1] = "WAKEFIELD 41 INDUSTRIAL ESTATE"
* address[0].line[2] = "BRINDLEY WAY"
* address[0].city = "WAKEFIELD"
* address[0].district = "WEST YORKSHIRE"
* address[0].postalCode = "WF2 0XQ"
* address[0].country = "ENGLAND"




Instance: InterweaveToCHospitalOrganizationExample
InstanceOf: InterweaveToCOrganization
Description: "Interweave Hospital Organization Transfer of Care example"

* id = "YHCR.4bbfa2f7-00ec-4853-aa05-d41fc2e7ef9e"

//(Note - important to put our profile first, or else the website won't recognise it!)
* meta.lastUpdated = "2022-02-01T09:37:00.441319+00:00"
* meta.profile[0] = "https://fhir-toc.yhcr.nhs.uk/StructureDefinition/Interweave-ToC-Organization"
* meta.profile[1] = "https://fhir.hl7.org.uk/STU3/StructureDefinition/CareConnect-Organization-1"

* insert Ruleset-BlankExampleText

* identifier[0].system = "https://fhir.nhs.uk/Id/ods-organization-code"
* identifier[0].value = "RR8"

* name = "LEEDS TEACHING HOSPITALS NHS TRUST"
// NB: This is an entirely made-up value set and even uses the yhcr namespace!! 
* type.coding = https://fhir.yhcr.nhs.uk/ValueSet/organization-type#trust "NHS Trust"

//* telecom[0].system = #phone
//* telecom[0].value = "01924 584000"
//* telecom[0].use = #work

//* address[0].use = #work
//* address[0].type = #both
* address[0].line[0] = "ST. JAMES'S UNIVERSITY HOSPITAL"
* address[0].line[1] = "BECKETT STREET"
* address[0].line[2] = "LEEDS"
//* address[0].city = "LEEDS"
//* address[0].district = "WEST YORKSHIRE"
* address[0].postalCode = "LS9 7TF"
//* address[0].country = "ENGLAND"

