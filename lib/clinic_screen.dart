import 'package:flutter/material.dart';
import 'package:glass/src/GlassWidget.dart';
import 'package:mereter/clinic_view_screen.dart';
import 'package:mereter/user.dart';

const TextStyle textStyle = TextStyle(
  fontSize: 30,
  fontFamily: 'SF Pro Display',
);

class ClinicScreen extends StatefulWidget {
  const ClinicScreen(this.patient, {Key? key}) : super(key: key);
  static const String id = 'reportScreen';
  final Patient patient;

  @override
  _ClinicScreenState createState() => _ClinicScreenState();
}

class _ClinicScreenState extends State<ClinicScreen> {
  @override
  Widget build(BuildContext context) {
    List<dynamic> userClinics = widget.patient.getUserClinics();

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: NetworkImage(
                'https://firebasestorage.googleapis.com/v0/b/mereter-35f11.appspot.com/o/backdrop.png?alt=media&token=643db69d-e72b-4303-ae4d-f73b6698241c'),
            fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(child:
            ListView.builder(itemCount: userClinics.length,itemBuilder: (BuildContext context, int index) {
              if(index == 0){
                return Column(
                  children: [
                    const SizedBox(height: 40,),
                    const Text("Your Clinics",
                      style: TextStyle(
                        fontSize: 40,
                        color: Color(0xff3d3d3d),
                        fontFamily: 'SF Pro Display',
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 40,),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ClinicViewScreen(clinic: userClinics[index])));
                        },
                        title: Text(
                          userClinics[index]['Type'] + ' Clinic',
                          style: const TextStyle(
                              fontSize: 25,
                              fontFamily: 'SF Pro Display',
                              color: Color(0xFF3D3D3D)),
                        ),
                      ).asGlass(clipBorderRadius: BorderRadius.circular(15),tintColor: const Color(0XFF98E1DA)),
                    ),
                  ],
                );
              }
          return Padding(
            padding: const EdgeInsets.all(5.0),
            child: ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ClinicViewScreen(clinic: userClinics[index])));
              },
              title: Text(
                userClinics[index]['Type'] + ' Clinic',
                style: const TextStyle(
                    fontSize: 25,
                    fontFamily: 'SF Pro Display',
                    color: Color(0xFF3D3D3D)),
              ),
            ).asGlass(clipBorderRadius: BorderRadius.circular(15),tintColor: const Color(0XFF98E1DA)),
          );
        })),
      ),
    );
  }
}


