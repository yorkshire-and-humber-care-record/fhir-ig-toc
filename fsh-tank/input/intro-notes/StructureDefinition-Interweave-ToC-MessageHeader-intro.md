## Introduction
This profile defines the use of the MessageHeader resource in Transfer of Care messages.

This is the top-level wrapper around the message, including routing information

It contains:

 - **Event** - always "YH001: Transfer of care from ambulance to ED"
 - **Destination** - always the YHCR's central reliable messaging gateway
 - **Receiver** - a reference to the Hospital Emergency Department where the message is to be routed (including the ODS code as an identifier)
 - **Sender** - a reference to the Ambulance Service organisation
 - **Timestamp** - the timestamp of the message
 - **Source** - additional details of the sending software at the Ambulance Service
 - **Focus** - at pre-registration this will contain a reference to the Composition Bundle. At finalisation this will contain both a reference to the Composition Bundle and also a reference to the PDF DocumentReference


>***Please refer to the examples to see how this will look in practice***