import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:glass/src/GlassWidget.dart';
import 'package:mereter/login_screen.dart';
import 'package:mereter/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';


const TextStyle textStyle = TextStyle(
  fontSize: 20,
  fontFamily: 'SF Pro Display',
);

const TextStyle textStyle2 = TextStyle(
  fontSize: 20,
  fontFamily: 'SF Pro Display',
);

class PersanolDateEditScreen extends StatefulWidget {
  final Patient patient;
  const PersanolDateEditScreen(this.patient,{Key? key}) : super(key: key);
  static const String id = 'PersanolDateEditScreen';

  @override
  _PersanolDateEditScreenState createState() => _PersanolDateEditScreenState();
}

class _PersanolDateEditScreenState extends State<PersanolDateEditScreen> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  final String _collectionPath = "Patients";

  late var userPersonalInfo;
  late String _userName;
  late String _userMobileNumber;
  late String _userAddress;
  late String _userEmergencyContactName;
  late String _userEmergencyContactNumber;
  late String _userEmergencyContactRelationship;


  late User loggedInUser;

  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      var snackBar2 = SnackBar(
        shape: const RoundedRectangleBorder(
            borderRadius:
            BorderRadius.all(Radius.circular(15))),
        behavior: SnackBarBehavior.floating,
        content: Text(
          e.toString(),
          style: textStyle2,
        ),
        backgroundColor: const Color(0xfffa4e4e),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar2);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }



  @override
  Widget build(BuildContext context) {
    userPersonalInfo = widget.patient.getUserData();

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: NetworkImage(
                'https://firebasestorage.googleapis.com/v0/b/mereter-35f11.appspot.com/o/backdrop.png?alt=media&token=643db69d-e72b-4303-ae4d-f73b6698241c'),
            fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          toolbarHeight: 70,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
          title: const Text(
            "Personal Detail Update Form",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 30,
              fontFamily: 'SF Pro Display',
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    const Text(
                      'Name',
                      style: textStyle,
                    ),
                    TextFormField(
                      validator: (value) {
                        _userName = value!;
                      },
                      style: textStyle,
                      cursorHeight: 25,
                      decoration: const InputDecoration(
                        hintText: 'Enter your name',
                      ),
                    ),
                    const SizedBox(height: 30),

                    const Text(
                      'Address',
                      style: textStyle,
                    ),
                    TextFormField(
                      validator: (value) {
                        _userAddress = value!;
                      },
                      style: textStyle,
                      cursorHeight: 25,
                      decoration: const InputDecoration(
                        hintText: 'Enter your address',
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      'Phone Number',
                      style: textStyle,
                    ),
                    TextFormField(
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      validator: (value) {

                        _userMobileNumber = value!;
                      },
                      style: textStyle,
                      cursorHeight: 25,
                      decoration: const InputDecoration(
                        hintText: 'Enter your phone number',
                      ),
                    ),

                    const SizedBox(height: 30),

                    const Text(
                      'Emergency Contact Name',
                      style: textStyle,
                    ),
                    TextFormField(
                      validator: (value) {
                        _userEmergencyContactName = value!;
                      },
                      style: textStyle,
                      cursorHeight: 25,
                      decoration: const InputDecoration(
                        hintText: 'Enter your emergency contact name',
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      'Emergency Contact Phone Number',
                      style: textStyle,
                    ),
                    TextFormField(
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      validator: (value) {

                        _userEmergencyContactNumber = value!;

                      },
                      style: textStyle,
                      cursorHeight: 25,
                      decoration: const InputDecoration(
                        hintText: 'Enter your emergency contact phone number',
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      'Emergency Contact Relationship',
                      style: textStyle,
                    ),
                    TextFormField(
                      validator: (value) {
                        _userEmergencyContactRelationship = value!;
                      },
                      style: textStyle,
                      cursorHeight: 25,
                      decoration: const InputDecoration(
                        hintText: 'Enter your emergency contact relationship',
                      ),
                    ),


                    const SizedBox(height: 45),
                    SizedBox(
                      height: 60,
                      child: ElevatedButton(
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                //side: BorderSide(color: Colors.red)
                              ))),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              var snackBar2 = const SnackBar(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                                behavior: SnackBarBehavior.floating,
                                content: Text(
                                  "Please Wait ...",
                                  style: textStyle2,
                                ),
                                backgroundColor: Color(0xffe78320),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(snackBar2);

                              try {
                                if(_userName == ''){
                                  _userName = userPersonalInfo['Name'];
                                }
                                if(_userMobileNumber == ''){
                                  _userMobileNumber = userPersonalInfo['Mobile number'];
                                }
                                if(_userAddress == '')  _userAddress = userPersonalInfo['Address'];
                                if(_userEmergencyContactName == '')  _userEmergencyContactName = userPersonalInfo['Emergency Contact Name'];
                                if(_userEmergencyContactNumber == '')  _userEmergencyContactNumber = userPersonalInfo['Emergency Contact Number'];
                                if(_userEmergencyContactRelationship == '')  _userEmergencyContactRelationship = userPersonalInfo['Emergency Contact Relationship'];

                                String uid = widget.patient.getUid();
                                await _firestore.doc('Patients/' + uid).update({
                                  'Name': _userName,
                                  'Address': _userAddress,
                                  'Mobile number': _userMobileNumber,
                                  'Emergency Contact Name' : _userEmergencyContactName,
                                  'Emergency Contact Number' : _userEmergencyContactNumber,
                                  'Emergency Contact Relationship': _userEmergencyContactRelationship,
                                });

                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) => const LoginScreen(),
                                  ),
                                      (route) => false,
                                );
                              } catch (e) {
                                var snackBar2 = SnackBar(
                                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                                  behavior: SnackBarBehavior.floating,
                                  content: Text(
                                    e.toString(),
                                    style: textStyle2,
                                  ),
                                  backgroundColor: const Color(0xffbf280c),
                                );
                                ScaffoldMessenger.of(context).showSnackBar(snackBar2);
                              }

                            }
                          },
                          child: const Text(
                            'Submit',
                            style: TextStyle(
                              fontSize: 25,
                              fontFamily: 'SF Pro Display',
                            ),
                          )),
                    ),
                  ],
                ),
              )),
        ).asGlass(),
      ),
    );
  }
}
