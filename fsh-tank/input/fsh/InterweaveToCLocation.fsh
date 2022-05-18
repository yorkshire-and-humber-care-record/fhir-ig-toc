Profile: InterweaveToCLocation
Parent: CareConnect-Location-1
Id: Interweave-ToC-Location
Description: "Interweave ToC Location resource profile."
* ^status = #active


//TODO - is more data provided on Finalise?

* id 1..1
* meta.lastUpdated 1..1
* meta.profile 0..*

* name 1..1 
* name ^short =  "Always 'Casualty Location'" 

// TODO - this seems to be optional and not always included??
// TODO - confirm the list and system??
* type 0..1
//* type from http://hl7.org/fhir/ValueSet/v3-ServiceDeliveryLocationRoleType (required)
* insert Ruleset-CodingWithSystemCodeDisplay(type)

* address 1..1


* managingOrganization 1..1
* insert Ruleset-ReferenceWithReferenceAndDisplay(managingOrganization)
* managingOrganization ^short =  "A reference to the Ambulance Service involved" 


////////////////////////////////////////////////////////////////////////////////////////
// Remove fields we don't need
////////////////////////////////////////////////////////////////////////////////////////

* insert Ruleset-RemoveUnwantedHeaderFields

* identifier[odsSiteCode] 0..0
* identifier 0..0
* status 0..0
* operationalStatus 0..0
* alias 0..0
* description 0..0
* mode 0..0
* telecom 0..0
* physicalType 0..0
* position 0..0
* partOf 0..0
* endpoint 0..0



///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Examples
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

Instance: InterweaveToCLocationExample
InstanceOf: InterweaveToCLocation
Description: "Interweave Location Transfer of Care example"

//(Note - important to put our profile first, or else the website won't recognise it!)
//* meta.lastUpdated = "2022-02-01T09:37:00Z"
* meta.lastUpdated = "2022-02-01T09:37:00.441319+00:00"
* meta.profile[0] = "https://fhir-toc.yhcr.nhs.uk/StructureDefinition/Interweave-ToC-Location"
* meta.profile[1] = "https://fhir.hl7.org.uk/STU3/StructureDefinition/CareConnect-Location-1"

* insert Ruleset-BlankExampleText

* name = "Casualty Location"

//TODO - type?

* address[0].line[0] = "1 Acacia Avenue"
* address[0].city = "York"
* address[0].postalCode = "YO21 1AB"
* address[0].country = "ENGLAND"

* managingOrganization = Reference(InterweaveToCAmbulanceOrganizationExample)
* managingOrganization.display = "Yorkshire Ambualance Service NHS Trust"

