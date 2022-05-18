ValueSet: Care_ConnectCompositionSectionCode
Id: CareConnect-CompositionSectionCode-1
Description: "A code from the SNOMED Clinical Terminology UK with the expression (^999001721000000100 | Clinical record headings simple reference set (foundation metadata concept)|)."
* ^name = "Care ConnectCompositionSectionCode"
* ^version = "1.1.0"
* ^status = #draft
* ^publisher = "HL7 UK"
* ^copyright = "This value set includes content from SNOMED CT, which is copyright © 2002+ International Health Terminology Standards Development Organisation (IHTSDO), and distributed by agreement between IHTSDO and HL7. Implementer use of SNOMED CT is not covered by this agreement."
* include codes from system SNOMED_CT
    where constraint = "(^999001721000000100 | Clinical record headings simple reference set (foundation metadata concept)|)"


* ^url = "https://fhir.hl7.org.uk/STU3/ValueSet/CareConnect-CompositionSectionCode-1"