Profile: InterweaveToCMessageHeader
Parent: MessageHeader
Id: Interweave-ToC-MessageHeader
Description: "Interweave ToC Message Header resource profile."
* ^status = #active

* id 1..1
//* meta.lastUpdated 1..1
//* meta.profile 1..*

* eventCoding 1..1   // STU3: event
* eventCoding from InterweaveToCEventType (required)
//* eventCoding = https://yhcr.nhs.uk/STU3/ValueSet/EventType-1#YH001 "Transfer of care from ambulance to ED" (exactly)
* eventCoding ^short = "Always YH001: Transfer of care from ambulance to ED"

// Reciever is the hospital with A&E department
* destination.receiver 1..1 //STU3: receiver
* destination.receiver only Reference(Interweave-ToC-Organization)
* destination.receiver ^short = "The hospital being conveyed to"

// Sender is the ambulance service
* sender 1..1
* sender only Reference(Interweave-ToC-Organization)
* sender ^short = "The ambulance service"

// destination - the Exchange gateway. Not strictly needed and Design Paper says to omit. 
// But is in the current messages, so leave optional
* destination ^short = "If provided: The Exchange messaging gateway"

// timestamp - is included, and already mandatory (and also not in R4!)

// Source - is included, and already mandatory

* focus 1..2
* focus only Reference(Bundle or Interweave-ToC-DocumentReference)
* focus ^short = "Always includes a composition Bundle. At finalisation also includes a DocumentReference to the PDF"


////////////////////////////////////////////////////////////////////////////////////////
// Remove fields we don't need
////////////////////////////////////////////////////////////////////////////////////////

* insert Ruleset-RemoveUnwantedHeaderFields

* enterer 0..0
* author 0..0
* responsible 0..0
* reason 0..0
* response 0..0


////////////////////////////////////////////////////////////////////////////////////////
// Examples
////////////////////////////////////////////////////////////////////////////////////////

Instance: InterweaveToCMessageHeaderExamplePreReg
InstanceOf: InterweaveToCMessageHeader
Description: "Interweave Message Header Transfer of Care example - Pre Registration"

* text.status = #generated
* text.div = "<div xmlns='http://www.w3.org/1999/xhtml'>\n    <p>Yorkshire Ambulance Service Transfer of Care for JOHN SMITH, NHS Number: 1234567890</p>\n    </div>"

//STU3 = event
* eventCoding = https://yhcr.nhs.uk/STU3/CodeSystem/EventType-1#YH001 "Transfer of care from ambulance to ED"

* destination.name = "YHCR System of Systems Reliable Message Gateway"
* destination.endpoint = "https://sandpit.yhcr.nhs.uk/fhir/stu3/$process-message"

//STU3 = receiver
* destination.receiver = Reference(InterweaveToCHospitalOrganizationExample) 
* destination.receiver.identifier.system = "https://fhir.nhs.uk/Id/ods-organization-code"
* destination.receiver.identifier.value = "RR8"
* destination.receiver.display = "LEEDS TEACHING HOSPITALS NHS TRUST"

* sender = Reference(InterweaveToCAmbulanceOrganizationExample)
* sender.identifier.system = "https://fhir.nhs.uk/Id/ods-organization-code"
* sender.identifier.value = "RX8"
* sender.display = "YORKSHIRE AMBULANCE SERVICE NHS TRUST"

//Timestamp - not in R4, but mandatory in R3!!
//Conversion script will insert a hard-coded example value

* source.name = "YORKSHIRE AMBULANCE SERVICE NHS TRUST"
* source.software = "SynFHIR Repository"
* source.version = "localdb-1.4"
* source.contact.system = #email
* source.contact.value = "support@synanetics.com"
* source.endpoint = "https://INTENG1.yas.nhs.uk/fhirbus"

* focus[0].reference = "Bundle/Composition-Bundle-guid-here"




Instance: InterweaveToCMessageHeaderExampleFinalise
InstanceOf: InterweaveToCMessageHeader
Description: "Interweave Message Header Transfer of Care example - Finalisation"

* text.status = #generated
* text.div = "<div xmlns='http://www.w3.org/1999/xhtml'>\n    <p>Yorkshire Ambulance Service Transfer of Care for JOHN SMITH, NHS Number: 1234567890</p>\n    </div>"

//STU3 = event
* eventCoding = https://yhcr.nhs.uk/STU3/CodeSystem/EventType-1#YH001 "Transfer of care from ambulance to ED"

* destination.name = "YHCR System of Systems Reliable Message Gateway"
* destination.endpoint = "https://sandpit.yhcr.nhs.uk/fhir/stu3/$process-message"

//STU3 = receiver
* destination.receiver = Reference(InterweaveToCHospitalOrganizationExample) 
* destination.receiver.identifier.system = "https://fhir.nhs.uk/Id/ods-organization-code"
* destination.receiver.identifier.value = "RR8"
* destination.receiver.display = "LEEDS TEACHING HOSPITALS NHS TRUST"

* sender = Reference(InterweaveToCAmbulanceOrganizationExample)
* sender.identifier.system = "https://fhir.nhs.uk/Id/ods-organization-code"
* sender.identifier.value = "RX8"
* sender.display = "YORKSHIRE AMBULANCE SERVICE NHS TRUST"

//Timestamp - not in R4, but mandatory in R3!!
//Conversion script will insert a hard-coded example value

* source.name = "YORKSHIRE AMBULANCE SERVICE NHS TRUST"
* source.software = "SynFHIR Repository"
* source.version = "localdb-1.4"
* source.contact.system = #email
* source.contact.value = "support@synanetics.com"
* source.endpoint = "https://INTENG1.yas.nhs.uk/fhirbus"

* focus[0].reference = "Bundle/Composition-Bundle-guid-here"
//** Only for finalise ***************
* focus[1] = Reference(InterweaveToCDocumentReferenceExample)
