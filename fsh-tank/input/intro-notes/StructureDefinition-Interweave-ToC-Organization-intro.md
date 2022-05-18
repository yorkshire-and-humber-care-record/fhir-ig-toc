## Introduction
This profile defines the use of the Organization resource in Transfer of Care messages.

Two Organization resources are always included in the message bundle, and are always the same - representing the Ambulance Service and the Hospital Emergency Department involved.

These two Organizations are used as the Sender and Receiver in the FHIR Message Header.

In addition the Ambulance Service organisation is used:
 - As the Managing Organisation of the patient's Location
 - As the Authenticator and Custodian of the PDF DocumentReference

The Organization resource contains:

 - **Identifier** - the ODS Code of the Ambulance Service or Hospital
 - **Type** - always "Healthcare Provider"  ***TO CONFIRM - or is it NHS Trust?***
 - **Telecom** - the work phone number  ***TO CONFIRM - is this included or not?***
 - **Address** the work address 

>***Please refer to the example to see how this will look in practice***