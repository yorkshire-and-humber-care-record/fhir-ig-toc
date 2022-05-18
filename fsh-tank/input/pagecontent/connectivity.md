# Connectivity

## Overview
Messages are transmitted over HTTPS to a RESTful FHIR messaging endpoint implementing the $process-message operation. See <https://www.hl7.org/fhir/STU3/messaging.html>


## Reliability
 - A HTTP response code is expected, but there is no other FHIR response message.
 - In the event of a timeout or HTTP failure response then the central messaging Exchange will retry. This is subject to configuration, but is currently set to rety - with backoff - for just over 24 hours.
 - At the end of this time the message is discarded. It is assumed that the message is no longer relevant as the patient will have been dealt with manually.
 - The Transfer of Care messages augment and streamline existing manual administrative processes. However it is required that all Emergency Departments have fallback manual processes (as-per those in place historically) to provide essential care even if the messages do not arrive.


## Security
Three layers of security are implemented:
1. **IP Whitelisting** - the central messaging exchange presents on a single static IP address. This may therefore be whitelisted by recipients
2. **TLS Mutual Authentication** - a HTTPS client certificate is presented, thus allowing recipients to implement TLS Mutual Authentication
3. **JWT token** - the messages include a HTTP Header with a JWT bearer token, thus allowing recipients to verify this token

## Onboarding and Testing
 - Further details and logons will be provided once a project enters the Interweave Onboarding process.
 - This will include 
   - Access to the support ticketing system
   - Access to the Onboarding web portal - where endpoints can be configured and certificates downloaded
   - Access to test environments to develop against (**Sandpit** for initial development, **Staging** for user-acceptance, and **Production** for live operations. Note that all environments except Production use synthetic data)

## References
The following reference may be useful:
 - FHIR messaging specification <https://www.hl7.org/fhir/STU3/messaging.html>
 - Interweave technical design papers <https://yhcr.org/resources/technical-papers/>
 - Interweave design paper 006 - Reliable Messaging Infrastructure <https://yhcr.org/wp-content/uploads/2019/03/YHCR_Design_Paper_006__Reliable_Messaging_Infrastructure.docx>
 - Interweave design paper 005 - Identity and Access Management (covering format of JWT tokens) <https://yhcr.org/wp-content/uploads/2021/11/YHCR-Design-Paper-005-Identity-and-Access-Management-v1.3.docx>

