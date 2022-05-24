## Introduction
This profile defines the use of the Location resource in Transfer of Care messages.

This represents the casualty location

It contains:

 - **Name** - always "Casualty Location"
 - **Address** - the address of the casualty location (may be provided with blanks if not known)
 - **Managing Organisation** - a reference to the Ambulance Service involved
  - **Type** - from the standard Care Connect code list, if known. In practice only the following values are currently used:
    - Domestic Address = "PTRES", "Patient's Residence"
    - Work = "WORK", "work site"
    - School = "SCHOOL", "school",
    - Care Home = "CSC", "community service center"
    - Public place = "ACC", "accident site"


>***Please refer to the example to see how this will look in practice***

>*Note: The Encounter also includes a reference to the "location" of the hospital emergency department in the field "hospitalization.destination". However this reference is essentially used as an identifier, and details of the ED location are not included in the bundle*