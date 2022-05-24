## Introduction
This profile defines the use of the Practitioner resource in Transfer of Care messages. Specifically it defines how it is used to represent the patient's GP (if known).

This resource is always provided in the Bundle, but may be only a skelton if the patient's GP is not known. For example it may be skeletal at the Pre-Registration stage, with more details populated at Finalisation.

It contains:

 - **Identifier** - the ODS Code of the GP Practice. (Field omitted if GP is not known)
 - **Telecom** - the work phone number of the GP Practice (fields may be provided with blank details if not known)
 - **Address** - the work address of the GP Practice  (fields may be provided but with blank details if not known)
 - **Name** - may be provided if known, but otherwise just contact details for the GP Practice are included


>***Please refer to the examples to see how this will look (a) pre-registration when the patient's GP practice is unknown (b) at finalisation where the GP practice is known***