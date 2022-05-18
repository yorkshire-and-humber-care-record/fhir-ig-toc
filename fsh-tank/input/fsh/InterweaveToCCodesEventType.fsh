Alias: $InterweaveToCEventType = https://yhcr.nhs.uk/STU3/ValueSet/EventType

ValueSet: InterweaveToCEventType
Id: Interweave-ToC-EventType
Description: "This value set defines a set of codes for MessageHeader Event Types"


// Set the URL, as this is different to the root of this IG, but is already in use
// (See Design Paper 006)
* ^url = "https://yhcr.nhs.uk/STU3/ValueSet/EventType"

// TODO: This is what is in the existing messages - but it is really wrong and should be a code system
* $InterweaveToCEventType#FM001 "National Population Failsafe Alert"
* $InterweaveToCEventType#FM002 "National Population Failsafe Alert Nullify"
* $InterweaveToCEventType#PDS001 "PDS Change of GP"
* $InterweaveToCEventType#PDS002 "PDS Change of Address"
* $InterweaveToCEventType#PDS003 "PDS Birth Notification"
* $InterweaveToCEventType#PDS004 "PDS Person Death"
* $InterweaveToCEventType#YH001 "Transfer of care from ambulance to ED"
* $InterweaveToCEventType#YH002 "Cancer centre secondary referral"
