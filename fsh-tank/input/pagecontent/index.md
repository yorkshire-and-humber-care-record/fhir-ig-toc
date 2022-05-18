# Interweave FHIR Implementation Guide for Transfer of Care

## Background and Purpose

This Implementation Guide defines Interweave standards for the Ambulance Transfer of Care messaging.


 - It is recommended to start with the  **Guidance** section. This includes:
   - An **[overview](overview.html)** of the Transfer of Care message types and structure
   - Additional information on technical **[connectivity](connectivity.html)** and transport


 - The **[artifacts](artifacts.html)** section provides more detail with a constrained profile for each type of FHIR Resource, plus additional examples

    Within each artifact then a suggested approach would be:
    - **Read the introductory text.** This provides useful background explanation and rationale, plus offers a simple descriptive summary of which fields are required and why

    <img src=".\HowToIntroText.png" alt="Intro Text" style="clear:both; float:none">


      - **Review the "Differential Table".** This highlights the changes that have been made to further tighten the CareConnect profile.

    <img src=".\HowToDifferential.png" alt="Intro Text" style="clear:both; float:none">


      - **Review the "Snapshot Table".** This gives a more complete view of the entire resource

    <img src=".\HowToSnapshot.png" alt="Intro Text" style="clear:both; float:none">

      - Back at the top of the page, **look at the "Examples" tab.** This contains example instances - to illustrate what the data might actually look like in practice.

      <img src=".\HowToExamples.png" alt="Intro Text" style="clear:both; float:none">

>***Note that the Ambulance Transfer of Care is an existing message which pre-dates other more recent work on Interweave Data Standards. This implementation guide therefore documents this existing message format as-implemented***