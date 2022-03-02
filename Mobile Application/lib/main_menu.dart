import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:glass/src/GlassWidget.dart';
import 'package:mereter/clinic_screen.dart';
import 'package:mereter/custom_app_bar.dart';
import 'package:mereter/history.dart';
import 'package:mereter/personal_details.dart';
import 'package:mereter/personal_info_display.dart';
import 'package:mereter/prescription_screen.dart';
import 'package:mereter/settings.dart';
import 'package:mereter/welcome_screen.dart';
import 'package:mereter/report_screen.dart';
import 'contact_us_screen.dart';
import 'user.dart';

const double margin = 10;
const TextStyle textStyle = TextStyle(
    fontSize: 25,
    fontFamily: 'SF Pro Display',
    color: Color(0xff3d3d3d),
);

const TextStyle textStyle2 = TextStyle(
  fontSize: 17,
  fontFamily: 'SF Pro Display',
  color: Color(0xff7e7e7e),
);

const double iconSize = 65;

class MainMenu extends StatefulWidget {
  final Object exception;
  final Patient patient;

  const MainMenu(this.patient, {Key? key, required this.exception})
      : super(key: key);

  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      if (widget.exception.toString() != 'Instance of \'Object\'') {
        var snackBar2 = SnackBar(
          dismissDirection: DismissDirection.startToEnd,
          duration: const Duration(seconds: 10),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15))),
          behavior: SnackBarBehavior.floating,
          content: Text(
            widget.exception.toString(),
            style: textStyle2,
          ),
          backgroundColor: const Color(0xfffa4e4e),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar2);
      }
    });

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(image : NetworkImage('https://firebasestorage.googleapis.com/v0/b/mereter-35f11.appspot.com/o/backdrop.png?alt=media&token=643db69d-e72b-4303-ae4d-f73b6698241c'),fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(height: 30,),
              const Text("MERETER",
                style: TextStyle(
                  fontSize: 40,
                  color: Color(0xff3d3d3d),
                  fontFamily: 'SF Pro Display',
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
                textAlign: TextAlign.center,
              ),
              //GradientAppBar("Mereter", const Color(0xff43cea2), const Color(0xff185a9d)),
              const SizedBox(height: 30,),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: ListTile(
                      minVerticalPadding: 20,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ReportScreen(widget.patient)));
                        },
                        leading: const Icon(Icons.my_library_books,color: Color(0xff3d3d3d),size: iconSize,),
                        title: const Text(
                          'Reports',
                          style: textStyle,
                        ),
                        subtitle: const Text("You can view all your medical reports.",style: textStyle2,),

                    ).asGlass(clipBorderRadius: BorderRadius.circular(25),tintColor: const Color(0XFF98E1DA)),
                  ),
                ),
              ),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: ListTile(
                      minVerticalPadding: 20,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PrescriptionScreen(widget.patient)));
                        },
                        leading: const Icon(Icons.my_library_books,color: Color(0xff3d3d3d),size: iconSize,),
                        title: const Text(
                          'Prescriptions',
                          style: textStyle,
                        ),
                        subtitle: const Text("You can view all your prescription information here.",style: textStyle2,),

                    ).asGlass(clipBorderRadius: BorderRadius.circular(25),tintColor: const Color(0XFF98E1DA)),
                  ),
                ),
              ),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: ListTile(
                      minVerticalPadding: 20,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ClinicScreen(widget.patient)));
                        },
                        leading: const Icon(Icons.health_and_safety,color: Color(0xff3d3d3d),size: iconSize,),
                        title: const Text(
                          'Clinics',
                          style: textStyle,
                        ),
                        subtitle: const Text("You can view all your clinic information here.",style: textStyle2,),

                    ).asGlass(clipBorderRadius: BorderRadius.circular(25),tintColor: const Color(0XFF98E1DA)),
                  ),
                ),
              ),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: ListTile(
                      minVerticalPadding: 20,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PersonalInfoDisplay(loggedInUser: widget.patient,)));
                        },
                        leading: const Icon(Icons.account_circle,color: Color(0xff3d3d3d),size: iconSize,),
                        title: const Text(
                          'Personal Information',
                          style: textStyle,
                        ),
                        subtitle: const Text("You can view all your personal information in our database.",style: textStyle2,),

                    ).asGlass(clipBorderRadius: BorderRadius.circular(25),tintColor: const Color(0XFF98E1DA)),
                  ),
                ),
              ),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: ListTile(
                      minVerticalPadding: 20,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Settings(widget.patient)));
                      },
                      leading: const Icon(Icons.settings,color: Color(0xff3d3d3d),size: iconSize,),
                      title: const Text(
                        'Settings',
                        style: textStyle,
                      ),
                      subtitle: const Text("Your Settings",style: textStyle2,),

                    ).asGlass(clipBorderRadius: BorderRadius.circular(25),tintColor: const Color(0XFF98E1DA)),
                  ),
                ),
              ),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: ListTile(
                      minVerticalPadding: 20,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HistoryScreen(widget.patient)));
                      },
                      leading: const Icon(Icons.history ,color: Color(0xff3d3d3d),size: iconSize,),
                      title: const Text(
                        'History',
                        style: textStyle,
                      ),
                      subtitle: const Text("Check your medical history",style: textStyle2,),

                    ).asGlass(clipBorderRadius: BorderRadius.circular(25),tintColor: const Color(0XFF98E1DA)),
                  ),
                ),
              ),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: ListTile(
                      minVerticalPadding: 20,
                      onTap: () async {
                        final auth = FirebaseAuth.instance;
                        await auth.signOut();

                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => const InitialScreen(),
                          ),
                              (route) => false,
                        );
                      },
                      leading: const Icon(Icons.home,color: Color(0xff3d3d3d),size: iconSize,),
                      title: const Text(
                        'Sign Out',
                        style: textStyle,
                      ),
                      subtitle: const Text("Click to log out from your current account",style: textStyle2,),

                    ).asGlass(clipBorderRadius: BorderRadius.circular(25),tintColor: const Color(0XFF98E1DA)),
                  ),
                ),
              ),

              const SizedBox(height: 30,),

            ],
          ),
        ),
      ),
    );
  }
}
