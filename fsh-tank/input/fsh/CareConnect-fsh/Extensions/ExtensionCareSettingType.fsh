Extension: ExtensionCareConnectCareSettingType1
Id: Extension-CareConnect-CareSettingType-1
Description: "Extension for a Care Setting which provides the originating care setting for the document."
* ^meta.lastUpdated = "2018-05-24T10:41:55.932+01:00"
* ^version = "1.2.0"
* ^status = #draft
* ^date = "2018-11-05"
* ^publisher = "NHS Digital"
* ^contact.name = "Interoperability Team"
* ^contact.telecom.system = #email
* ^contact.telecom.value = "interoperabilityteam@nhs.net"
* ^contact.telecom.use = #work
* ^purpose = "The Care Setting type provides the originating care setting for the document."
* ^copyright = "Copyright © 2017 NHS Digital"
//* ^contextType = "resource"
//* ^context = "Composition"
* . ^short = "An extension to carry the Care setting type of the document"


/*
* valueCodeableConcept contains valueCodeableConcept 1..1
* valueCodeableConcept[valueCodeableConcept] only CodeableConcept
* valueCodeableConcept[valueCodeableConcept] ^binding.strength = #required
* valueCodeableConcept[valueCodeableConcept] ^binding.description = "Correspondence care setting type"
* valueCodeableConcept[valueCodeableConcept] ^binding.valueSetReference.reference = "https://fhir.hl7.org.uk/STU3/ValueSet/CareConnect-CareSettingType-1"

* valueCodeableConcept[valueCodeableConcept].coding 1..1
* valueCodeableConcept[valueCodeableConcept].coding.system 1..
* valueCodeableConcept[valueCodeableConcept].coding.system = "http://snomed.info/sct" (exactly)
* valueCodeableConcept[valueCodeableConcept].coding.version ..0
* valueCodeableConcept[valueCodeableConcept].coding.code 1..
* valueCodeableConcept[valueCodeableConcept].coding.display 1..
* valueCodeableConcept[valueCodeableConcept].coding.display ^extension.url = "http://hl7.org/fhir/StructureDefinition/elementdefinition-translatable"
* valueCodeableConcept[valueCodeableConcept].coding.display ^extension.valueBoolean = true
* valueCodeableConcept[valueCodeableConcept].coding.userSelected ..0
* valueCodeableConcept[valueCodeableConcept].text ..0
* valueCodeableConcept[valueCodeableConcept].text ^extension.url = "http://hl7.org/fhir/StructureDefinition/elementdefinition-translatable"
* valueCodeableConcept[valueCodeableConcept].text ^extension.valueBoolean = true
*/



//* valueCodeableConcept contains valueCodeableConcept 1..1
* valueCodeableConcept[valueCodeableConcept] only CodeableConcept
* valueCodeableConcept ^binding.strength = #required
* valueCodeableConcept ^binding.description = "Correspondence care setting type"
* valueCodeableConcept ^binding.valueSet = CareConnect-CareSettingType-1

* valueCodeableConcept.coding 1..1
* valueCodeableConcept.coding.system 1..
* valueCodeableConcept.coding.system = "http://snomed.info/sct" (exactly)
* valueCodeableConcept.coding.version ..0
* valueCodeableConcept.coding.code 1..
* valueCodeableConcept.coding.display 1..
* valueCodeableConcept.coding.display ^extension.url = "http://hl7.org/fhir/StructureDefinition/elementdefinition-translatable"
* valueCodeableConcept.coding.display ^extension.valueBoolean = true
* valueCodeableConcept.coding.userSelected ..0
* valueCodeableConcept.text ..0
* valueCodeableConcept.text ^extension.url = "http://hl7.org/fhir/StructureDefinition/elementdefinition-translatable"
* valueCodeableConcept.text ^extension.valueBoolean = true


//Add correct Care Connect URL
* ^url = "https://fhir.hl7.org.uk/STU3/StructureDefinition/Extension-CareConnect-CareSettingType-1"