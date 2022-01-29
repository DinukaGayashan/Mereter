import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mereter/user.dart';
import 'main_menu.dart';

class MainMenuLoadingScreen extends StatefulWidget {
  const MainMenuLoadingScreen({Key? key}) : super(key: key);
  static const String id = 'mainMenuLoadingScreen';
  @override
  _MainMenuLoadingScreenState createState() => _MainMenuLoadingScreenState();
}

class _MainMenuLoadingScreenState extends State<MainMenuLoadingScreen> {
  Patient user = Patient();

  void getData() async {
    try{
      var _firestore = FirebaseFirestore.instance.doc('Patients/' + user.getUid());
      var _userData = await _firestore.get();
      user.setUserData(_userData);

      for(int i=0;i<_userData['Reports'].length;i++){
        var report = await _userData['Reports'][i].get();
        user.addUserReport(report);
      }

      for(int i=0;i<_userData['Clinics'].length;i++){
        var clinic = await _userData['Clinics'][i].get();
        user.addUserClinic(clinic);
      }

      for(int i=0;i < _userData['Prescriptions'].length;i++){
        var prescription = await _userData['Prescriptions'][i].get();
        user.addUserPrescriptions(prescription);
      }

      for(int i=0;i<_userData['History'].length;i++){
        var log = await _userData['History'][i];
        user.addUserHistory(log);
      }

    }catch(e){
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return MainMenu(user,exception: e,);
      }));
    }

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return MainMenu(user,exception: Object(),);
    }));

  }

  @override
  Widget build(BuildContext context) {
    getData();
    return const Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Color(0xFF008081),
          size: 100,
        ),
      ),
    );
  }
}
