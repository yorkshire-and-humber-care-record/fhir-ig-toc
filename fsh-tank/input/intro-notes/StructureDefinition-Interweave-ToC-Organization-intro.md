## Introduction
This profile defines the use of the Organization resource in Transfer of Care messages.

Two Organization resources are always included in the message bundle, and are always the same - representing the Ambulance Service and the Hospital Emergency Department involved.

These two Organizations are used as the Sender and Receiver in the FHIR Message Header.

In addition the Ambulance Service organisation is used:
 - As the Managing Organisation of the patient's Location
 - As the Authenticator and Custodian of the PDF DocumentReference

The Organization resource contains:

 - **Identifier** - the ODS Code of the Ambulance Service or Hospital
 - **Type** - either "Healthcare Provider" for the Ambulance Service, or "NHS Trust" for the hospital
 - **Telecom** - the work phone number of the organisation, if known
 - **Address** the work address of the organisation

>***Please refer to the example to see how this will look in practice***