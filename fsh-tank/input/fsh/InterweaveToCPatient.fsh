Alias: $patient-cadavericDonor = http://hl7.org/fhir/StructureDefinition/patient-cadavericDonor

Profile: InterweaveToCPatient
Parent: CareConnect-Patient-1
Id: Interweave-ToC-Patient
Description: "Interweave ToC Patient resource profile."
* ^status = #active

* id 1..1
* meta.lastUpdated 1..1
* meta.profile 0..*

// We do provide the ethnic category
* extension[Extension-CareConnect-EthnicCategory-1] 1..1 


// CareConnect already defines a special identifier for NHS Number
// This may not be known, but... if used then it must be verified
* identifier[nhsNumber] 0..1
* identifier[nhsNumber].extension[nhsNumberVerificationStatus].valueCodeableConcept = CareConnect-NHSNumberVerificationStatus-1#01 "Number present and verified" (exactly)
* identifier[nhsNumber].extension[nhsNumberVerificationStatus] ^short = "Verification status of the NHS Number - if provided then must be traced and verified"


* active 1..1

// Name: CareConnect already mandates there to be exactly one "official" name, including a "family" name.
//  So nothing to add here.
// (Other than it doesn't look like we provide the "text")
* name[official].text 0..0


// Other details
* birthDate 0..1
* gender 0..1


// Address: This is provided, not much to add
// (Doesn't look like we provide the "text" or any "period")
* address.text 0..0
* address.period 0..0

// We provide the GP
* generalPractitioner 0..1
* generalPractitioner only Reference(CareConnect-Practitioner-1)
* insert Ruleset-ReferenceWithReferenceAndId(generalPractitioner)


////////////////////////////////////////////////////////////////////////////////////////
// Remove fields we don't need
////////////////////////////////////////////////////////////////////////////////////////

* insert Ruleset-RemoveUnwantedHeaderFields

// Remove Care Connect extensions that we are not using
* extension[Extension-CareConnect-TreatmentCategory-1] 0..0
* extension[$patient-cadavericDonor] 0..0
* extension[birthPlace] 0..0
* extension[Extension-CareConnect-NominatedPharmacy-1] 0..0
* extension[Extension-CareConnect-DeathNotificationStatus-1] 0..0
* extension[Extension-CareConnect-NHSCommunication-1] 0..0
* extension[Extension-CareConnect-ReligiousAffiliation-1] 0..0
* extension[Extension-CareConnect-ResidentialStatus-1] 0..0

* insert Ruleset-RemoveUnwantedIdentifierFieldsForSliceKeepUse(nhsNumber)

* name[official].id 0..0
* name[official].period 0..0

* telecom 0..0
* deceased[x] 0..0
* maritalStatus 0..0
* multipleBirth[x] 0..0
* photo 0..0
* contact 0..0
* link 0..0
* managingOrganization 0..0


////////////////////////////////////////////////////////////////////////////////////////
// Examples
////////////////////////////////////////////////////////////////////////////////////////

Instance: InterweaveToCPatientExample
InstanceOf: InterweaveToCPatient
Description: "Interweave Patient Transfer of Care example"

* meta.lastUpdated = "2022-02-01T09:37:00.441319+00:00"
* meta.profile[0] = "https://fhir-toc.yhcr.nhs.uk/StructureDefinition/Interweave-ToC-Patient"
* meta.profile[1] = "https://fhir.hl7.org.uk/STU3/StructureDefinition/CareConnect-Patient-1"

* insert Ruleset-BlankExampleText

* extension[Extension-CareConnect-EthnicCategory-1].valueCodeableConcept = CareConnect-EthnicCategory-1#A "British, Mixed British"

* identifier[nhsNumber].extension[nhsNumberVerificationStatus].valueCodeableConcept = CareConnect-NHSNumberVerificationStatus-1#01 "Number present and verified"
* identifier[nhsNumber].use = #official
* identifier[nhsNumber].system = "https://fhir.nhs.uk/Id/nhs-number"
* identifier[nhsNumber].value = "123456789"

* active = true

* name[0].use = #official "Official"
* name[0].family = "BLOGGS"
* name[0].given[0] = "Fred"

* birthDate = 1992-01-27
* gender = http://hl7.org/fhir/administrative-gender#male


* address[0].use = #home 
* address[0].type = #physical 
* address[0].line[0] = "42 GROVE STREET"
* address[0].city = "HORNSEA"
* address[0].postalCode = "HU18 1AB"
* address[0].country = "GB"

// This is the current implementation and not ideal. Should really be referencing an organisation. And including display text of the name.
* generalPractitioner = Reference(InterweaveToCGPPractitionerExampleFinalise) 
* generalPractitioner.identifier.system = "https://fhir.nhs.uk/id/ods-organization-code"
* generalPractitioner.identifier.value = "B81004"
