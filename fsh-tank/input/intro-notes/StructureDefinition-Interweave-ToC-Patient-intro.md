## Introduction
This profile defines the use of the Patient resource in Transfer of Care messages.

It contains:

 - **Identifier** - the NHS Number of the patient (if known, else this entire block will be omitted)
 - **Active** - always "true"
 - **Name** - the official name of the patient
 - **Gender** and **DoB** - further demographic details
 - **Address** the home address of the patient
 - **General Practitioner** - a reference to a Practitioner resource representing the patient's GP

 ***Note that what is known will be provided, but in some cases this may be very little. This includes possibly not knowing the NHS Number of the patient.***

>***Please refer to the example to see how this will look in practice***