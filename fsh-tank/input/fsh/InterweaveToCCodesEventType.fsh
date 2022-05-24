ValueSet: InterweaveToCEventType
Id: Interweave-ToC-EventType-1
Description: "This value set defines a set of codes for MessageHeader Event Types"


// Set the URL, as this is different to the root of this IG, but is already in use
// (See Design Paper 006)
* ^url = "https://yhcr.nhs.uk/STU3/ValueSet/EventType-1"

* include codes from system Interweave-ToC-EventType-1

 

CodeSystem: InterweaveToCEventType
Id: Interweave-ToC-EventType-1
Description: "MessageHeader Event Types"
* ^name = "InterweaveToCEventType"
* ^content = #complete
* ^caseSensitive = true


// Set the URL, as this is different to the root of this IG, but is already in use
* ^url = "https://yhcr.nhs.uk/STU3/CodeSystem/EventType-1"


// Note - the existing messages are wrong and use the value set instead of the code system
* #FM001 "National Population Failsafe Alert"
* #FM002 "National Population Failsafe Alert Nullify"
* #PDS001 "PDS Change of GP"
* #PDS002 "PDS Change of Address"
* #PDS003 "PDS Birth Notification"
* #PDS004 "PDS Person Death"
* #YH001 "Transfer of care from ambulance to ED"
* #YH002 "Cancer centre secondary referral"