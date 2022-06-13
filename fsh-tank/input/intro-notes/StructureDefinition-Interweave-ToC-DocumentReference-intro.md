## Introduction
This profile defines the use of the DocumentReference resource in Transfer of Care messages. 

This resource is provided only at Finalisation, and contains a PDF with details from the Ambulance Service Electronic Patient Record.

It contains:

 - **Identifier** - the EPR Id from which the information in the PDF has been generated
 - **Status** - always "current"
 - **DocStatus** - always "final"
 - **Indexed** - the timestamp of creation
 - **Type** - always "YAS electronic care record"
 - **Subject** - a reference to the Patient
 - **Authenticator** and **Custodian** - a reference to the Ambulance Service organisation
 - **Content** - this contains an embedded PDF document (base64 encoded)

>***Please refer to the examples to see how this will look in practice. See also example PDFs, [typical](ExampleToC-typical.pdf) and [full](ExampleToC-full.pdf)***