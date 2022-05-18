#!/usr/bin/env node

//*******************************************************************
//** A limitiation of fsh is that it outputs only R4 files
//** This script tweaks them to be STU3, ready for the fhir publisher tool
//*******************************************************************

console.log( "Beginning R4 to STU3 conversion" );

var fs = require('fs');
var path = require('path');
var fileHelpers = require('./FileHelpers');

var dirR4 = path.resolve(__dirname, '..\\..') + '\\fsh-generated';
var dirSTU3 = path.resolve(__dirname, '..\\..') + '\\fsh-generated-STU3';
var regexEscapedDirR4=dirR4.replace(/([.*+?^=!:${}()|\[\]\/\\])/g, "\\$1");


// Clean out and recreate the STU3 output folder
if (fs.existsSync(dirSTU3)) {
    fs.rmdirSync(dirSTU3, { recursive: true });
}
fs.mkdirSync(dirSTU3);



// Go through all the R4 files output by fsh to the "fsh-generated" folder
// Copy them across to "fsh-generated-STU3", converting the FHIR Version as we go
fileArrayR4 = fileHelpers.getAllFiles(dirR4);
fileArrayR4.forEach(function(filePathR4) {


       var fileData = fs.readFileSync(filePathR4,'utf8');

      var processContent = true;
      if(filePathR4.includes("menu.xml")) processContent = false;
      if(filePathR4.includes("CareConnect")) processContent = false;

      if(processContent) {

            // Find and replace the FHIR version in all files
            var findString = "4.0.1";
            var escapedFindString=findString.replace(/([.*+?^=!:${}()|\[\]\/\\])/g, "\\$1");
            fileData = fileData.replace(new RegExp(escapedFindString, 'g'), "3.0.2");


            // Now look in more detail for specific R4 -> STU3 differences in each type of file
            var jsonObject = JSON.parse(fileData);

            // Convert Structure Definitions
            if (jsonObject.resourceType == "StructureDefinition") {
              jsonObject = convertStructureDefinition(jsonObject);

              if(jsonObject.id == "Interweave-ToC-Encounter") {
                jsonObject = convertInterweaveEncounterStructureDefinition(jsonObject);
              }

              if(jsonObject.id == "Interweave-ToC-DocumentReference") {
                jsonObject = convertInterweaveDocumentReferenceStructureDefinition(jsonObject);
              }

              if(jsonObject.id == "Interweave-ToC-Composition") {
                jsonObject = convertInterweaveCompositionStructureDefinition(jsonObject);
              }

              if(jsonObject.id == "Interweave-ToC-MessageHeader") {
                jsonObject = convertInterweaveMessageHeaderStructureDefinition(jsonObject);
              }

            }

            // Convert various types of instances
            if (jsonObject.resourceType == "Location") {
              jsonObject = convertLocationInstance(jsonObject);
            }

            if (jsonObject.resourceType == "Encounter") {
              jsonObject = convertEncounterInstance(jsonObject);
            }

            if (jsonObject.resourceType == "DocumentReference") {
              jsonObject = convertDocumentReferenceInstance(jsonObject);
            }

            if (jsonObject.resourceType == "Appointment") {
              jsonObject = convertAppointmentInstance(jsonObject);
            }

            if (jsonObject.resourceType == "Procedure") {
              jsonObject = convertProcedureInstance(jsonObject);
            }

            if (jsonObject.resourceType == "Condition") {
              jsonObject = convertConditionInstance(jsonObject);
            }

            if (jsonObject.resourceType == "DiagnosticReport") {
              jsonObject = convertDiagnosticReportInstance(jsonObject);
            }

            if (jsonObject.resourceType == "MessageHeader") {
              jsonObject = convertMessageHeaderInstance(jsonObject);
            }

            // Convert also any Contained instances! (realistically only Location and maybe Practitioner)
            if (jsonObject.contained) {
              jsonObject.contained.forEach(function(jsonContained) {
             
                  if (jsonContained.resourceType == "Location") {
                    jsonContained = convertLocationInstance(jsonContained);
                  }

                }) //foreach contained
            }


            // Reserialise the JSON
            fileData = JSON.stringify(jsonObject, null, 2)

          } //Process Content


      //Write the output to STU3 folder
      var filePathSTU3 = filePathR4.replace(new RegExp(regexEscapedDirR4, 'g'), dirSTU3);
      fileHelpers.ensureDirectoryExistence(filePathSTU3);
      fs.writeFileSync(filePathSTU3, fileData, 'utf8')

});


console.log( "Completed R4 to STU3 conversion" );



//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

function convertStructureDefinition(jsonObject) {

  //Remove an R4 extension about security-category that we don't need
  if(jsonObject.extension){
    var index = jsonObject.extension.findIndex(obj => obj.url=="http://hl7.org/fhir/StructureDefinition/structuredefinition-security-category");
    if(index > -1) {
      jsonObject.extension.splice(index,1);
    }
  }


  // For extensions then "context" is done differently
  if(jsonObject.type == "Extension") {
    if(jsonObject.context) {

      jsonObject.contextType = "resource";

      var newContextArray = new Array()
      jsonObject.context.forEach(function (objContext) {
        newContextArray.push(objContext.expression);
      })
      jsonObject.context = newContextArray;

    }
  }

  // Loop through the elements
  jsonObject.differential.element.forEach(function(objElement) {

    //***New***
    // If the element has a "type" attribute with a "targetProfile" then convert it from an array (R4) to multiple "type" elements with a single value (STU3)
    if(objElement.type)
    {
      var newTypeArray = new Array();

      objElement.type.forEach(function(objType) {   

          // Start by always removing an R4 "type" extension that we don't need
          if(objType.extension) delete objType.extension;

          //Starting assumption that we just pass this type attribute through
          newTypeArray.push(objType);

          if(objType.targetProfile) {
            //If it needs adjusting, pop off the original attribute and start again
            //Create a separate "type" element for each "targetProfile" in the original array
            newTypeArray.pop();
            for (let i = 0; i < objType.targetProfile.length; i++) {
              
              newObjType = Object.assign({},objType);
              newObjType.targetProfile = newObjType.targetProfile[i];
              newTypeArray.push(newObjType);
            }
          }


          if(objType.profile) {
            //Similarly for "profile"
            newTypeArray.pop();
            for (let i = 0; i < objType.profile.length; i++) {
              
              newObjType = Object.assign({},objType);
              newObjType.profile = newObjType.profile[i];
              newTypeArray.push(newObjType);
            }
          }


          // ** Example of original version - but didn't cater for multiple profiles!
          //if(objType.profile) {
          //  objType.profile = objType.profile[0];
          //}   


        }); //foreach

        // Finally, having transfered and adjusted the new array of "type" information... assign it back to the element
        objElement.type = newTypeArray;

      }; // Type


      // If the element has a "binding" attribute then we need to adjust any valueSet
      // R4 has a simple "valueSet" attribute, whereas STU3 has a more baroque "valueSetReference" containing a "reference"
      if(objElement.binding) {
        if(objElement.binding.valueSet) {
       
          var valueSetUrl = objElement.binding.valueSet;
          objElement.binding.valueSetReference = new Object;
          objElement.binding.valueSetReference.reference = valueSetUrl;
          delete objElement.binding.valueSet;
          
        }
      }

  }); //Element

  return jsonObject;
}


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

function convertInterweaveEncounterStructureDefinition(jsonObject) {
 
  // Loop through the elements
  jsonObject.differential.element.forEach(function(objElement) {


    // Convert "basedOn" to "incomingReferral"
    if(objElement.id.includes("Encounter.basedOn"))  {
      objElement.id = objElement.id.replace("Encounter.basedOn", "Encounter.incomingReferral");
      objElement.path = objElement.id;
    };
      

    // Make class mandatory. (It already is in R4, so not considered a "differential" otherwise!)
    if(objElement.id == "Encounter.class")  {
      objElement.min = 1;
    } // Encounter.diagnosis
    

    // Convert "diagnosis.use" to "diagnosis.role"
    if(objElement.id == "Encounter.diagnosis")  {
      if(objElement.slicing) {
        objElement.slicing.discriminator[0].path = "role";
        //console.log(objElement);
      }
    } // Encounter.diagnosis


    if(objElement.id.includes("Encounter.diagnosis.use"))  {
      objElement.id = objElement.id.replace("Encounter.diagnosis.use", "Encounter.diagnosis.role");
      objElement.path = objElement.id;
    };

    if(objElement.id == "Encounter.diagnosis:chiefComplaint.use")  {
      objElement.id = "Encounter.diagnosis:chiefComplaint.role";
      objElement.path = "Encounter.diagnosis.role";
    }; // Encounter.diagnosis.use

    //NB! This one is slighlty different due to the slicing!
    if(objElement.id.includes("Encounter.diagnosis:chiefComplaint.use"))  {
      objElement.id = objElement.id.replace("Encounter.diagnosis:chiefComplaint.use", "Encounter.diagnosis:chiefComplaint.role");
      objElement.path = objElement.path.replace("Encounter.diagnosis.use", "Encounter.diagnosis.role");
    };


    // Convert "reasonCode" to "reason"
    if(objElement.id.includes("Encounter.reasonCode"))  {
      objElement.id = objElement.id.replace("Encounter.reasonCode", "Encounter.reason");
      objElement.path = objElement.id;
  };


  }); //Element

  return jsonObject;
}



//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

function convertInterweaveDocumentReferenceStructureDefinition(jsonObject) {

  // The "created" field does not exist in R4! Add text to the STU3 profile to indicate this
  // And remove it!
  objCreated = new Object;
  objCreated.id = "DocumentReference.created";
  objCreated.path = "DocumentReference.created";
  objCreated.short = "DISCOURAGED - deprecated in R4";
  objCreated.max = "0";
  jsonObject.differential.element.push(objCreated);


  // Loop through the elements
  jsonObject.differential.element.forEach(function(objElement) {

        // Convert "date" to "indexed"
        if(objElement.id.includes("DocumentReference.date"))  {
          objElement.id = objElement.id.replace("DocumentReference.date", "DocumentReference.indexed");
          objElement.path = objElement.id;
      };

        // Convert "category" to "class"
        if(objElement.id.includes("DocumentReference.category"))  {
          objElement.id = objElement.id.replace("DocumentReference.category", "DocumentReference.class");
          objElement.path = objElement.id;
      };


  }); //Element

  return jsonObject;
}



function convertInterweaveCompositionStructureDefinition(jsonObject) {

  // Loop through the elements
  jsonObject.differential.element.forEach(function(objElement) {


        // Convert "category" to "class"
        if(objElement.id.includes("Composition.category"))  {
          objElement.id = objElement.id.replace("Composition.category", "Composition.class");
          objElement.path = objElement.id;
      };


  }); //Element

  return jsonObject;
}


function convertInterweaveMessageHeaderStructureDefinition(jsonObject) {

  // Loop through the elements
  jsonObject.differential.element.forEach(function(objElement) {


        // Convert "eventCoding" to "event"
        if(objElement.id.includes("MessageHeader.eventCoding"))  {
          objElement.id = objElement.id.replace("MessageHeader.eventCoding", "MessageHeader.event");
          objElement.path = objElement.id;
      };


        // Convert "destination.receiver" to "receiver"
        if(objElement.id.includes("MessageHeader.destination.receiver"))  {
          objElement.id = objElement.id.replace("MessageHeader.destination.receiver", "MessageHeader.receiver");
          objElement.path = objElement.id;
      };


  }); //Element

  return jsonObject;
}




//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

function convertInterweaveAppointmentStructureDefinition(jsonObject) {
 
  // Loop through the elements
  jsonObject.differential.element.forEach(function(objElement) {

    // Convert "reasonCode" to "reason"
    if(objElement.id.includes("Appointment.reasonCode"))  {
        objElement.id = objElement.id.replace("Appointment.reasonCode", "Appointment.reason");
        objElement.path = objElement.id;
    };

  // Convert "reasonReference" to "indication"
  if(objElement.id.includes("Appointment.reasonReference"))  {
    objElement.id = objElement.id.replace("Appointment.reasonReference", "Appointment.indication");
      objElement.path = objElement.id;
    };
  
    // Convert "basedOn" to "incomingReferral"
    if(objElement.id.includes("Appointment.basedOn"))  {
      objElement.id = objElement.id.replace("Appointment.basedOn", "Appointment.incomingReferral");
      objElement.path = objElement.id;
    };
      


  }); //Element

  return jsonObject;
}




//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

function convertInterweaveConditionStructureDefinition(jsonObject) {
 
  // Loop through the elements
  jsonObject.differential.element.forEach(function(objElement) {

    // Convert "encounter" to "context"
    if(objElement.id.includes("Condition.encounter"))  {
      objElement.id = objElement.id.replace("Condition.encounter", "Condition.context");
      objElement.path = objElement.id;
    };
      

  // Convert "recordedDate" to "assertedDate"      
  if(objElement.id.includes("Condition.recordedDate"))  {
    objElement.id = objElement.id.replace("Condition.recordedDate", "Condition.assertedDate");
    objElement.path = objElement.id;
  };


  }); //Element

  return jsonObject;
}


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

function convertInterweaveProcedureStructureDefinition(jsonObject) {
 
  // Loop through the elements
  jsonObject.differential.element.forEach(function(objElement) {


    // Convert "encounter" to "context"
    if(objElement.id.includes("Procedure.encounter"))  {
      objElement.id = objElement.id.replace("Procedure.encounter", "Procedure.context");
      objElement.path = objElement.id;
    };     
    

  }); //Element

  return jsonObject;
}


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

function convertInterweaveDiagnosticReportStructureDefinition(jsonObject) {
 
  // Loop through the elements
  jsonObject.differential.element.forEach(function(objElement) {


    // Convert "encounter" to "context"
    if(objElement.id.includes("DiagnosticReport.encounter"))  {
      objElement.id = objElement.id.replace("DiagnosticReport.encounter", "DiagnosticReport.context");
      objElement.path = objElement.id;
    };     
    

    // Convert "media" to "image"
    if(objElement.id.includes("DiagnosticReport.media"))  {
      objElement.id = objElement.id.replace("DiagnosticReport.media", "DiagnosticReport.image");
      objElement.path = objElement.id;
    };     

  }); //Element

  return jsonObject;
}



////////////////////////////////////////////////////////////////////////////////////////


function convertLocationInstance(jsonObject) {

  // Convert the location "type" from an array (R4) to a single value (STU3)
  if(jsonObject.type) {
    jsonObject.type = jsonObject.type[0];
  }

  return jsonObject;
}

function convertEncounterInstance(jsonObject) {

  if(jsonObject.basedOn) {
    jsonObject.incomingReferral = jsonObject.basedOn;
    delete jsonObject.basedOn;
  }

  if(jsonObject.reasonCode) {
    jsonObject.reason = jsonObject.reasonCode;
    delete jsonObject.reasonCode;
  }

  if(jsonObject.diagnosis) jsonObject.diagnosis.forEach(function(objDiagnosis) {
    objDiagnosis.role = objDiagnosis.use;
    delete objDiagnosis.use;
  });
 
  if(jsonObject.appointment) {
    jsonObject.appointment = jsonObject.appointment[0];
  }


  return jsonObject;
}


function convertDocumentReferenceInstance(jsonObject) {

  // Convert the "date" field into "indexed"
  if(jsonObject.date) {
    jsonObject.indexed = jsonObject.date;
    delete jsonObject.date;
  }

  if(jsonObject.context && jsonObject.context.encounter) {
    jsonObject.context.encounter = jsonObject.context.encounter[0];
  }


  return jsonObject;
}



function convertAppointmentInstance(jsonObject) {

  if(jsonObject.basedOn) {
    jsonObject.incomingReferral = jsonObject.basedOn;
    delete jsonObject.basedOn;
  }

  if(jsonObject.reasonCode) {
    jsonObject.reason = jsonObject.reasonCode;
    delete jsonObject.reasonCode;
  }

  if(jsonObject.reasonReference) {
    jsonObject.indication = jsonObject.reasonReference;
    delete jsonObject.reasonReference;
  }
 

  return jsonObject;
}



function convertConditionInstance(jsonObject) {

  if(jsonObject.encounter) {
    jsonObject.context = jsonObject.encounter;
    delete jsonObject.encounter;
  }

  if(jsonObject.recordedDate) {
    jsonObject.assertedDate = jsonObject.recordedDate;
    delete jsonObject.recordedDate;
  }

  //Clinical status is just a simple code (not codableconcept) in STU3
  if(jsonObject.clinicalStatus) {
    jsonObject.clinicalStatus = jsonObject.clinicalStatus.coding[0].code;
  }

  return jsonObject;
}


function convertProcedureInstance(jsonObject) {

  if(jsonObject.encounter) {
    jsonObject.context = jsonObject.encounter;
    delete jsonObject.encounter;
  }


  return jsonObject;
}


function convertDiagnosticReportInstance(jsonObject) {

  if(jsonObject.encounter) {
    jsonObject.context = jsonObject.encounter;
    delete jsonObject.encounter;
  }

  if(jsonObject.media) {
    jsonObject.image = jsonObject.media;
    delete jsonObject.media;
  }

  // Convert from an array in R4 to a single value in STU3
  if(jsonObject.category) {
    jsonObject.category = jsonObject.category[0];
  }


  return jsonObject;
}


function convertMessageHeaderInstance(jsonObject) {

  if(jsonObject.eventCoding) {
    jsonObject.event = jsonObject.eventCoding;
    delete jsonObject.eventCoding;
  }

  if(jsonObject.destination[0].receiver) {
    jsonObject.receiver = jsonObject.destination[0].receiver;
    delete jsonObject.destination[0].receiver;
  }

  // Insert timestamp - which is a field that is mandatory in R3 but doesn't exist at all in R4!
  // (For now just insert a hard-coded example)
  jsonObject.timestamp = "2022-02-01T09:37:00Z";


  return jsonObject;
}
