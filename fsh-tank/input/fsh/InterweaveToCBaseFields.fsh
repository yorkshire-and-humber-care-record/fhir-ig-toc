////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Rulesets to remove unwanted fields
////////////////////////////////////////////////////////////////////////////////////////////////////////////

RuleSet: Ruleset-RemoveUnwantedHeaderFields

* implicitRules 0..0
* language 0..0
* meta.id 0..0
* meta.security 0..0
* meta.versionId 0..0
// Allow tags - YAS do use them * meta.tag 0..0
* text ^short = "Do NOT rely on this field. (Some examples on this site may automaticaly generate it, but not included in the actual messages)"
* contained 0..0


RuleSet: Ruleset-RemoveUnwantedIdentifierFields

* identifier.id 0..0
* identifier.use 0..0
* identifier.type 0..0
* identifier.period 0..0
* identifier.assigner 0..0

RuleSet: Ruleset-RemoveUnwantedIdentifierFieldsKeepUse

* identifier.id 0..0
//* identifier.use 0..0
* identifier.type 0..0
* identifier.period 0..0
* identifier.assigner 0..0


RuleSet: Ruleset-RemoveUnwantedIdentifierFieldsForSlice(slice)

* identifier[{slice}].id 0..0
* identifier[{slice}].use 0..0
* identifier[{slice}].type 0..0
* identifier[{slice}].period 0..0
* identifier[{slice}].assigner 0..0

RuleSet: Ruleset-RemoveUnwantedIdentifierFieldsForSliceKeepUse(slice)

* identifier[{slice}].id 0..0
//* identifier[{slice}].use 0..0
* identifier[{slice}].type 0..0
* identifier[{slice}].period 0..0
* identifier[{slice}].assigner 0..0


RuleSet: Ruleset-RemoveUnwantedTelcomFields

* telecom.id 0..0
* telecom.rank 0..0
* telecom.period 0..0


RuleSet: Ruleset-BlankExampleText

* text.status = #empty
* text.div = "<div xmlns=\"http://www.w3.org/1999/xhtml\">Text Not Provided</div>"

////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Rulesets to tighten up Local Id, CodeableConcept and Reference usage
////////////////////////////////////////////////////////////////////////////////////////////////////////////

RuleSet: Ruleset-AddIdentifierSlicing

* identifier ^slicing.discriminator.type = #value
* identifier ^slicing.discriminator.path = "system"
* identifier ^slicing.ordered = false
* identifier ^slicing.rules = #open


RuleSet: Ruleset-AddLocalIdentifierMS(type)

* identifier contains
    localIdentifier 0..1 MS

* identifier[localIdentifier].system 1..1 MS
* identifier[localIdentifier].system = "https://fhir.yhcr.nhs.uk/Id/local-{type}-identifier" (exactly)
* identifier[localIdentifier].value 1..1 MS
* identifier[localIdentifier].value ^short = "The Local {type} Identifier. Please prefix with ODS code plus period (XXX.) to ensure unique"
// Period assumed to match that of the entity
* identifier[localIdentifier].period 0..0


RuleSet: Ruleset-AddLocalIdentifierOptional(type)

* identifier contains
    localIdentifier 0..1

* identifier[localIdentifier].system 1..1 MS
* identifier[localIdentifier].system = "https://fhir.yhcr.nhs.uk/Id/local-{type}-identifier" (exactly)
* identifier[localIdentifier].value 1..1 MS
* identifier[localIdentifier].value ^short = "The Local {type} Identifier. Please prefix with ODS code plus period (XXX.) to ensure unique"
// Period assumed to match that of the entity
* identifier[localIdentifier].period 0..0



RuleSet: Ruleset-CodingWithSystemCodeDisplay(path)
// Don't have to provide coding
// But if we do then properly populated with system, code, AND display text
* {path}.coding.system 1..1
* {path}.coding.code 1..1
* {path}.coding.display 1..1


RuleSet: Ruleset-RawCodingWithSystemCodeDisplay(path)
// For raw coding, not in a CodeableConcept
// Properly populate with system, code, AND display text
* {path}.system 1..1
* {path}.code 1..1
* {path}.display 1..1


RuleSet: Ruleset-ReferenceWithReferenceAndDisplay(path)
* {path}.display 1..1
* {path}.display ^short = "Description of the referenced resource"
* {path}.reference 1..1
* {path}.reference ^short = "Reference to a resource"

RuleSet: Ruleset-ReferenceWithReferenceAndId(path)
* {path}.reference 1..1
* {path}.reference ^short = "Reference to a resource"
* {path}.identifier 1..1
* {path}.identifier ^short = "Id of resource"

RuleSet: Ruleset-ReferenceWithReferenceAndIdAndDisplay(path)
* {path}.reference 1..1
* {path}.reference ^short = "Reference to a resource"
* {path}.identifier 1..1
* {path}.identifier ^short = "Id of resource"
* {path}.display 1..1
* {path}.display ^short = "Description of the referenced resource"

RuleSet: Ruleset-ReferenceWithReferenceOnly(path)
* {path}.reference 1..1
* {path}.reference ^short = "Reference to a resource"


