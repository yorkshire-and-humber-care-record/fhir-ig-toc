## Introduction
This profile defines the use of the Patient resource in Transfer of Care messages.

It contains:

 - **Identifier** - the NHS Number of the patient (if known, else this entire block will be omitted)
 - **Active** - always "true"
 - **Name** - the official name of the patient
 - **Gender** and **DoB** - further demographic details
 - **Telecom and Address** - the phone number and home address of the patient
 - **Contact** - details of a contact person, for example next of kin
 - **General Practitioner** - a reference to a Practitioner resource representing the patient's GP
 - **Ethnic Category** - if captured, or may be "Z - Unknown"

 ***Note that what is known will be provided, but in some cases this may be very little. This includes possibly not knowing the NHS Number of the patient.***

>***Please refer to the example to see how this will look in practice***