## Introduction
This profile defines the use of the Location resource in Transfer of Care messages.

This represents the casualty location

It contains:

 - **Name** - always "Casualty Location"
 - **Type** - TBC???
 - **Address** - the address of the casualty location (may be provided with blanks if not known???)
 - **Managing Organisation** - a reference to the Ambulance Service involved

 ***TBC - any other fields?***


>***Please refer to the example to see how this will look in practice***

>*Note: The Encounter also includes a reference to the "location" of the hospital emergency department in the field "hospitalization.destination". However this reference is essentially used as an identifier, and details of the ED location are not included in the bundle*