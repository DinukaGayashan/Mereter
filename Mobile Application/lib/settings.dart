import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:glass/src/GlassWidget.dart';
import 'package:mereter/contact_us_screen.dart';
import 'package:mereter/personal_data_edit.dart';
import 'package:mereter/personal_details.dart';
import 'package:mereter/user.dart';


const double margin = 10;
const TextStyle textStyle2 = TextStyle(
  fontSize: 17,
  fontFamily: 'SF Pro Display',
  color: Color(0xff7e7e7e),
);

const TextStyle textStyle = TextStyle(
  fontSize: 25,
  fontFamily: 'SF Pro Display',
  color: Color(0xff3d3d3d),
);


class Settings extends StatefulWidget {
  final Patient patient;
  const Settings(this.patient, {Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(image : NetworkImage('https://firebasestorage.googleapis.com/v0/b/mereter-35f11.appspot.com/o/backdrop.png?alt=media&token=643db69d-e72b-4303-ae4d-f73b6698241c'),fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
            children: <Widget>[
              const SizedBox(height: 40,),
              const Text("Settings",
                style: TextStyle(
                  fontSize: 40,
                  color: Color(0xff3d3d3d),
                  fontFamily: 'SF Pro Display',
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 40,),
              ListTile(
                  onTap: () {
                    try {
                      final user = FirebaseAuth.instance.currentUser;
                      if (!user!.emailVerified) {
                        var snackBar3 = const SnackBar(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(15))),
                          behavior: SnackBarBehavior.floating,
                          content: Text(
                            "Warning! : Your email is not verified. Email is sent to your account. Make sure to verify your email.",
                            style: textStyle2,
                          ),
                          backgroundColor: Color(0xffe76211),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar3);
                        user.sendEmailVerification();
                      } else {
                        var snackBar3 = const SnackBar(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(15))),
                          behavior: SnackBarBehavior.floating,
                          content: Text(
                            "Your email has verified!",
                            style: textStyle2,
                          ),
                          backgroundColor: Color(0xff30a704),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar3);
                      }
                    } catch (e) {
                      var snackBar2 = SnackBar(
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15))),
                        behavior: SnackBarBehavior.floating,
                        content: Text(
                          e.toString(),
                          style: textStyle2,
                        ),
                        backgroundColor: const Color(0xfffa4e4e),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar2);
                    }
                  },
                  leading: const Icon(Icons.email,size: 30,),
                  subtitle: const Text("You can verify your email by clicking this button.",style: textStyle2,),
                  title: const Text(
                    'Verify email',
                    style: textStyle,
                  )).asGlass(clipBorderRadius: BorderRadius.circular(25),tintColor: const Color(0XFF98E1DA)),

              const SizedBox(height: 30,),
          ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PersanolDateEditScreen(widget.patient)));
                },
              leading: const Icon(Icons.person,size: 30,),
              title: const Text(
                'Edit Personal Info',
                style: textStyle,
              ),
            subtitle: const Text("You can update your personal information. ",style: textStyle2,),).asGlass(clipBorderRadius: BorderRadius.circular(25),tintColor: const Color(0XFF98E1DA)),
              const SizedBox(height: 30,),
              ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ContactUs()));
                  },
                  leading: const Icon(Icons.contact_page,size: 30,),
                  title: const Text(
                    'Contact Us',
                    style: textStyle,
                  ),
                subtitle: const Text("You can contact admin through email or phone. ",style: textStyle2,)).asGlass(clipBorderRadius: BorderRadius.circular(25),tintColor: const Color(0XFF98E1DA)),
              const SizedBox(height: 30,),


            ],
          ),
        ),
      ),
    );
  }
}
