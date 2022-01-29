import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:glass/src/GlassWidget.dart';
import 'package:mereter/login_screen.dart';


const TextStyle textStyle = TextStyle(
  fontSize: 20,
  fontFamily: 'SF Pro Display',
);

const TextStyle textStyle2 = TextStyle(
  fontSize: 20,
  fontFamily: 'SF Pro Display',
);

class PersonalDetailsScreen extends StatefulWidget {
  const PersonalDetailsScreen({Key? key}) : super(key: key);
  static const String id = 'PersonalDetailsScreen';

  @override
  _PersonalDetailsScreenState createState() => _PersonalDetailsScreenState();
}

class _PersonalDetailsScreenState extends State<PersonalDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  final String _collectionPath = "Patients";

  late String _userBloodType;
  late String _userName;
  late String _userAge;
  late String _userMobileNumber;
  late String _userAddress;
  late String _userGender;
  late String _userNIC;
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

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(
          child: Text(
            "A+",
            style: textStyle,
          ),
          value: "A+"),
      const DropdownMenuItem(
          child: Text(
            "A-",
            style: textStyle,
          ),
          value: "A-"),
      const DropdownMenuItem(
          child: Text(
            "B+",
            style: textStyle,
          ),
          value: "B+"),
      const DropdownMenuItem(
          child: Text(
            "B-",
            style: textStyle,
          ),
          value: "B-"),
      const DropdownMenuItem(
          child: Text(
            "AB+",
            style: textStyle,
          ),
          value: "AB+"),
      const DropdownMenuItem(
          child: Text(
            "AB-",
            style: textStyle,
          ),
          value: "AB-"),
      const DropdownMenuItem(
          child: Text(
            "O+",
            style: textStyle,
          ),
          value: "O+"),
      const DropdownMenuItem(
          child: Text(
            "O-",
            style: textStyle,
          ),
          value: "O-"),
    ];
    return menuItems;
  }

  List<DropdownMenuItem<String>> get genderDropDownItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(
          child: Text(
            "Male",
            style: textStyle,
          ),
          value: "Male"),
      const DropdownMenuItem(
          child: Text(
            "Female",
            style: textStyle,
          ),
          value: "Female"),
    ];
    return menuItems;
  }

  @override
  Widget build(BuildContext context) {
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
            "Personal Detail Form",
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
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        _userName = value;
                      },
                      style: textStyle,
                      cursorHeight: 25,
                      decoration: const InputDecoration(
                        hintText: 'Enter your name',
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      'NIC number',
                      style: textStyle,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your NIC number';
                        }

                        _userNIC = value;
                      },
                      style: textStyle,
                      cursorHeight: 25,
                      decoration: const InputDecoration(
                        hintText: 'Enter your NIC number',
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      'Select your blood type',
                      style: textStyle,
                    ),
                    ButtonTheme(
                      alignedDropdown: true,
                      child: DropdownButtonFormField(
                          /*decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue, width: 2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue, width: 2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          filled: true,
                          fillColor: Colors.blueAccent,
                        ),*/
                          validator: (value) =>
                              value == null ? "Please select a blood type" : null,
                          //dropdownColor: Colors.blueAccent,
                          //value: selectedValue,
                          onChanged: (String? newValue) {
                            setState(() {
                              _userBloodType = newValue!;
                            });
                          },
                          items: dropdownItems),
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      'Address',
                      style: textStyle,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your address';
                        }
                        _userAddress = value;
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
                        if (value == null || value.isEmpty) {
                          return 'Please enter your phone number';
                        }
                        _userMobileNumber = value;
                        return null;
                      },
                      style: textStyle,
                      cursorHeight: 25,
                      decoration: const InputDecoration(
                        hintText: 'Enter your phone number',
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      'Age',
                      style: textStyle,
                    ),
                    TextFormField(
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your age';
                        }
                        _userAge = value;
                        return null;
                      },
                      style: textStyle,
                      cursorHeight: 25,
                      decoration: const InputDecoration(
                        hintText: 'Enter your age',
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      'Select your gender',
                      style: textStyle,
                    ),
                    ButtonTheme(
                      alignedDropdown: true,
                      child: DropdownButtonFormField(
                          /*decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue, width: 2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue, width: 2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          filled: true,
                          fillColor: Colors.blueAccent,
                        ),*/
                          validator: (value) =>
                              value == null ? "Please select a gender" : null,
                          //dropdownColor: Colors.blueAccent,
                          //value: selectedValue,
                          onChanged: (String? newValue) {
                            setState(() {
                              _userGender = newValue!;
                            });
                          },
                          items: genderDropDownItems),
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      'Emergency Contact Name',
                      style: textStyle,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your emergency contact name';
                        }
                        _userEmergencyContactName = value;
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
                        if (value == null || value.isEmpty) {
                          return 'Please enter your emergency contact phone number';
                        }
                        _userEmergencyContactNumber = value;
                        return null;
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
                        if (value == null || value.isEmpty) {
                          return 'Please enter your emergency contact relationship';
                        }
                        _userEmergencyContactRelationship = value;
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
                              //TODO: test the exception handling
                              try {
                                FirebaseFunctions function = FirebaseFunctions.instance;
                                HttpsCallable nicCheck = function.httpsCallable("checkPatientNIC");
                                final results = await nicCheck.call(<String,dynamic>{
                                  'nic' : _userNIC,
                                });

                                if(results.data){
                                  throw Exception(["NIC already exists"]);
                                }
                                await _firestore
                                    .collection(_collectionPath)
                                    .doc(loggedInUser.uid)
                                    .set({
                                  'Name': _userName,
                                  'Age': _userAge,
                                  'NIC': _userNIC,
                                  'Address': _userAddress,
                                  'Blood group': _userBloodType,
                                  'Mobile number': _userMobileNumber,
                                  'Gender': _userGender,
                                  'Email' : loggedInUser.email,
                                  'Emergency Contact Name' : _userEmergencyContactName,
                                  'Emergency Contact Number' : _userEmergencyContactNumber,
                                  'Emergency Contact Relationship': _userEmergencyContactRelationship,
                                  'Reports' : [],
                                  'Clinics': [],
                                  'Prescriptions': [],
                                  'to' : loggedInUser.email,
                                  'message': {
                                    'subject': "Hello from Mereter!",
                                    'text': "Thank You for your registration and Welcome to our app",
                                  },
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

                              //print(_userName);
                              //print(_userAddress);
                              //print(_userNIC);
                              //print(_userAge);
                              //print(_userMobileNumber);
                              //print(_userBloodType);
                              //print(_userGender);
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
