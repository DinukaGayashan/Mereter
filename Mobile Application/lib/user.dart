import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Patient {
  //late DocumentSnapshot<Map<String, dynamic>> _userData;
  late DocumentReference<Map<String, dynamic>> _firestore;
  late final List<dynamic> _userReports = [];
  late final List<dynamic> _userClinics = [];
  late final List<dynamic> _userPrescriptions = [];
  late final List<dynamic> _userHistory = [];
  var userData;

  void setUserData(var data) {
    userData = data;
  }

  dynamic getUserData() {
    return userData;
  }

  List<String> getReportNames() {
    List<String> names = [];
    for (int i = 0; i < _userReports.length; i++) {
      names.add(_userReports[i]['ReportType']);
      //names.add('Test Name');
      //print(_userReports[i]['Name']);
    }
    return names;
  }

  List<String> getReportDates(){
    List<String> dates = [];
    for(int i=0;i<_userReports.length; i++){
      dates.add(_userReports[i]['Date']);
    }
    return dates;
  }

  List<String> getReportLab(){
    List<String> labs = [];
    for(int i=0;i<_userReports.length;i++){
      labs.add(_userReports[i]['MltID']);
    }
    return labs;
  }

  late String uid = '';

  Patient() {
    final _auth = FirebaseAuth.instance;

    try {
      User? loggedInUser = _auth.currentUser;
      uid = loggedInUser!.uid;
    } catch (e) {
      //print(e);
    }
  }

  String getUid() {
    return uid;
  }

  List<String> getUserReportsURLS() {
    List<String> urls = [];
    for (int i = 0; i < _userReports.length; i++) {
      urls.add(_userReports[i]['ImageURL']);
    }
    return urls;
  }

  List<dynamic> getUserClinics() {
    return _userClinics;
  }

  List<dynamic> getUserPrescriptions(){
    return _userPrescriptions;
  }

  void addUserPrescriptions(var prescription){
    _userPrescriptions.add(prescription);
  }

  void addUserReport(var report) {
    _userReports.add(report);
  }

  void addUserClinic(var clinic) {
    _userClinics.add(clinic);
  }

  void addUserHistory(var log){
    _userHistory.add(log);
  }

  List<dynamic> getUserHistory(){
    return _userHistory;
  }

  void updateData() async {
    _firestore = FirebaseFirestore.instance.doc('Patients/' + uid);
    await _firestore.update({
      //existing
      'Name': 'update',

      //new
      'Address': 'new address updated 2',
    });
  }

  Reference storageTest() {
    final _storage = FirebaseStorage.instance;
    return (_storage.ref().child('a/').child('b.txt'));
  }

  Future<void> downloadURL() async {
    final _storage = FirebaseStorage.instance;
    String s = await _storage.ref('a/c.pdf').getDownloadURL();
    //print(s);

    // Within your widgets:
    // Image.network(downloadURL);
  }

  Future<void> listExample() async {
    ListResult result = await FirebaseStorage.instance.ref().listAll();

    result.items.forEach((Reference ref) async {
      String s = await ref.getDownloadURL();
    });
  }
}
