Profile: CareConnectComposition1
Parent: Composition
Id: CareConnect-Composition-1
Description: "A set of healthcare-related information that is assembled together into a single logical document that provides a single coherent statement of meaning, establishes its own context and that has clinical attestation with regard to who is making the statement."
* ^meta.lastUpdated = "2018-05-04T09:54:22.262+01:00"
* ^version = "1.2.0"
* ^status = #draft
* ^date = "2018-11-05"
* ^publisher = "HL7 UK"
* ^contact.name = "INTEROPen"
* ^contact.telecom.system = #email
* ^contact.telecom.value = "admin@interopen.org"
* ^contact.telecom.use = #work
* ^purpose = "CURATED BY INTEROPen see: http://www.interopen.org/careconnect-curation-methodology/ "
* ^copyright = "Copyright © 2016 HL7 UK  Licensed under the Apache License, Version 2.0 (the \"License\"); you may not use this file except in compliance with the License. You may obtain a copy of the License at  http://www.apache.org/licenses/LICENSE-2.0  Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an \"AS IS\" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.  HL7® FHIR® standard Copyright © 2011+ HL7  The HL7® FHIR® standard is used under the FHIR license. You may obtain a copy of the FHIR license at  https://www.hl7.org/fhir/license.html"

* extension ^slicing.discriminator.type = #value
* extension ^slicing.discriminator.path = "url"
* extension ^slicing.rules = #open
* extension contains Extension-CareConnect-CareSettingType-1 named careSettingTypeExtension 0..1

* identifier.system 1..
* identifier.value 1..
* identifier.assigner only Reference(CareConnect-Organization-1)
* type ^short = "Kind of composition (SNOMED CT)"
* type ^binding.extension.url = "http://hl7.org/fhir/StructureDefinition/elementdefinition-bindingName"
* type ^binding.extension.valueString = "DocumentType"
* type ^binding.strength = #preferred
* type ^binding.description = "SNOMED CT Document Type"
* type ^binding.valueSet = CareConnect-DocumentType-1
* encounter only Reference(CareConnect-Encounter-1)
* author only Reference(Device or RelatedPerson or CareConnect-Practitioner-1 or CareConnect-Patient-1)
* attester.party only Reference(CareConnect-Organization-1 or CareConnect-Practitioner-1 or CareConnect-Patient-1)
* custodian only Reference(CareConnect-Organization-1)
* relatesTo ..1
* relatesTo.target[x] only Identifier or Reference(CareConnect-Composition-1)
* section.code ^binding.extension.url = "http://hl7.org/fhir/StructureDefinition/elementdefinition-bindingName"
* section.code ^binding.extension.valueString = "CompositionSectionType"
* section.code ^binding.strength = #preferred
* section.code ^binding.valueSet = CareConnect-CompositionSectionCode-1

//Add correct Care Connect URL
* ^url = "https://fhir.hl7.org.uk/STU3/StructureDefinition/CareConnect-Composition-1"