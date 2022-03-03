const functions = require("firebase-functions");
const admin=require("firebase-admin");
admin.initializeApp(functions.config().firebase);


exports.checkPatientNIC = functions.https.onCall(async (data, context) => {
    const result = await checkNIC(data.nic, "Patients");
    return result;
  });
  
  exports.checkDoctorNIC = functions.https.onCall(async (data, context) => {
    const result = await checkNIC(data.nic, "Doctors");
    return result;
  });
  
  exports.checkMLTNIC = functions.https.onCall(async (data, context) => {
    const result = await checkNIC(data.nic, "MLTs");
    return result;
  });
  
  exports.checkNurseNIC = functions.https.onCall(async (data, context) => {
    const result = await checkNIC(data.nic, "Nurses");
    return result;
  });
  
  exports.checkPharmacistNIC = functions.https.onCall(async (data, context) => {
    const result = await checkNIC(data.nic, "Pharmacists");
    return result;
  });
  
  async function checkNIC(nic, col) {
      const userCollectionRef = admin.firestore().collection(col);
      const querySnapshot = await userCollectionRef
        .where("NIC", "==", nic)
        .get();
      return querySnapshot.size >= 1;
    }
  
  
  exports.checkUserRole=functions.https.onCall(async (data, context) => {
      const pat=await checkCollectionForUser(data.email, "Patients");
      const doct=await checkCollectionForUser(data.email, "Doctors");
      const mlt=await checkCollectionForUser(data.email, "MLTs");
      const nurs=await checkCollectionForUser(data.email, "Nurses");
      const phar=await checkCollectionForUser(data.email, "Pharmacists");
  
      if (pat) {
          return "Patient";
      } else if (doct) {
          return "Doctor";
      } else if (mlt) {
          return "MLT";
      } else if (nurs) {
          return "Nurse";
      } else if (phar) {
          return "Pharmacist";
      } else {
          return "No";
      }
  });
  
  async function checkCollectionForUser(email, col) {
      const userCollectionRef = admin.firestore().collection(col);
      const querySnapshot = await userCollectionRef
        .where("Email", "==", email)
        .get();
      return querySnapshot.size >= 1;
    }
  
  
  
  exports.addPrescriptionToHistory = functions.firestore
  .document("Prescriptions/{prescriptionId}")
  .onCreate(async (snapshot, context) => {
      const nic=snapshot.data().NIC;
      const patRef=await admin.firestore()
      .collection("Patients").where("NIC","==",nic).get();
      
      let updatePromises=[];
      patRef.forEach(doc => {
          updatePromises.push(admin.firestore()
          .collection("Patients").doc(doc.id)
          .update({History:admin.firestore.FieldValue
              .arrayUnion(snapshot.data().Date+": Prescription "+snapshot.data().PrescriptionNo+" added by Dr "+snapshot.data().Doctor)}))
      });
      
      await Promise.all(updatePromises);
  });
  
  exports.addReportToHistory = functions.firestore
  .document("Reports/{reportId}")
  .onCreate(async (snapshot, context) => {
      const nic=snapshot.data().NIC;
      const patRef=await admin.firestore()
      .collection("Patients").where("NIC","==",nic).get();
      
      let updatePromises=[];
      patRef.forEach(doc => {
          updatePromises.push(admin.firestore()
          .collection("Patients").doc(doc.id)
          .update({History:admin.firestore.FieldValue
              .arrayUnion(snapshot.data().Date+": "+snapshot.data().ReportType+" report "+snapshot.data().ReportNo+" added")}))
      });
      
      await Promise.all(updatePromises);
  });
  
  exports.addPrescribedReportToHistory = functions.firestore
  .document("PrescribedReports/{prescribedReportId}")
  .onCreate(async (snapshot, context) => {
      const nic=snapshot.data().NIC;
      const patRef=await admin.firestore()
      .collection("Patients").where("NIC","==",nic).get();
      
      let updatePromises=[];
      patRef.forEach(doc => {
          updatePromises.push(admin.firestore()
          .collection("Patients").doc(doc.id)
          .update({History:admin.firestore.FieldValue
              .arrayUnion(snapshot.data().Date+": Prescription for a "+snapshot.data().Data+" report is added by Dr "+snapshot.data().Doctor)}))
      });
      
      await Promise.all(updatePromises);
  });
  
  
  exports.addPrescriptionReference = functions.firestore
  .document("Prescriptions/{prescriptionId}")
  .onCreate(async (snapshot, context) => {
      const nic=snapshot.data().NIC;
      const patRef=await admin.firestore()
      .collection("Patients").where("NIC","==",nic).get();
      
      let updatePromises=[];
      patRef.forEach(doc => {
          updatePromises.push(admin.firestore()
          .collection("Patients").doc(doc.id)
          .update({Prescriptions:admin.firestore.FieldValue
              .arrayUnion(snapshot.ref)}))
      });
      
      await Promise.all(updatePromises);
  });
  
  exports.addPrescribedReportReference = functions.firestore
  .document("PrescribedReports/{prescribedReportId}")
  .onCreate(async (snapshot, context) => {
      const nic=snapshot.data().NIC;
      const patRef=await admin.firestore()
      .collection("Patients").where("NIC","==",nic).get();
      
      let updatePromises=[];
      patRef.forEach(doc => {
          updatePromises.push(admin.firestore()
          .collection("Patients").doc(doc.id)
          .update({Prescriptions:admin.firestore.FieldValue
              .arrayUnion(snapshot.ref)}))
      });
      
      await Promise.all(updatePromises);
  });
  
  exports.addReportReference = functions.firestore
  .document("Reports/{reportId}")
  .onCreate(async (snapshot, context) => {
      const nic=snapshot.data().NIC;
      const patRef=await admin.firestore()
      .collection("Patients").where("NIC","==",nic).get();
      
      let updatePromises=[];
      patRef.forEach(doc => {
          updatePromises.push(admin.firestore()
          .collection("Patients").doc(doc.id)
          .update({Reports:admin.firestore.FieldValue
              .arrayUnion(snapshot.ref)}))
      });
      
      await Promise.all(updatePromises);
  });