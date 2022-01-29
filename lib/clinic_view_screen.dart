import 'package:flutter/material.dart';
import 'package:glass/src/GlassWidget.dart';

class ClinicViewScreen extends StatefulWidget {
  final dynamic clinic;
  const ClinicViewScreen({Key? key, required this.clinic}) : super(key: key);

  @override
  _ClinicViewScreenState createState() => _ClinicViewScreenState();
}

class _ClinicViewScreenState extends State<ClinicViewScreen> {
  @override
  Widget build(BuildContext context) {
    final clinic = widget.clinic;
    List<dynamic> clinicDetails = [];

    clinicDetails.add(clinic['ClinicID']);
    clinicDetails.add(clinic['Consultant']);
    clinicDetails.add(clinic['Doctors'].toString());
    clinicDetails.add(clinic['Type']);
    clinicDetails.add(clinic['Day'].toString());

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: NetworkImage(
                'https://firebasestorage.googleapis.com/v0/b/mereter-35f11.appspot.com/o/backdrop.png?alt=media&token=643db69d-e72b-4303-ae4d-f73b6698241c'),
            fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
            child: ListView.builder(
                itemCount: clinicDetails.length,
                itemBuilder: (BuildContext context, int index) {
                  String heading = "Null";
                  if (index == 0) {
                    heading = "Clinic ID";
                    return Column(

                      children: [
                        const SizedBox(height: 40,),
                        const Text("Clinic Details",
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
                        ListTile(
                          title: Text(
                            heading,
                            style: const TextStyle(
                                fontSize: 20,
                                fontFamily: 'SF Pro Display',
                                color: Color(0xFF878585)),
                          ),
                          subtitle: Text(
                            clinicDetails[index],
                            style: const TextStyle(
                                fontSize: 25,
                                fontFamily: 'SF Pro Display',
                                color: Color(0xFF585757)),
                          ),
                        ),
                      ],
                    );
                  } else if (index == 1) {
                    heading = "Consultant";
                  } else if (index == 2) {
                    heading = "Doctors";
                    String docs = clinicDetails[index];
                    docs = docs.replaceAll('[', '');
                    docs = docs.replaceAll(']', '');
                    docs = docs.replaceAll(', ', '\n');
                    clinicDetails[index] = docs;

                  } else if (index == 3) {
                    heading = "Type";
                  } else if (index == 4) {
                    heading = "Day";
                    String docs = clinicDetails[index];
                    docs = docs.replaceAll('[', '');
                    docs = docs.replaceAll(']', '');
                    docs = docs.replaceAll(', ', '\n');
                    clinicDetails[index] = docs;
                  }

                  return ListTile(
                    title: Text(
                      heading,
                      style: const TextStyle(
                          fontSize: 20,
                          fontFamily: 'SF Pro Display',
                          color: Color(0xFFAAAAAA)),
                    ),
                    subtitle: Text(
                      clinicDetails[index],
                      style: const TextStyle(
                          fontSize: 25,
                          fontFamily: 'SF Pro Display',
                          color: Color(0xFF3D3D3D)),
                    ),
                  );
                }).asGlass(tintColor: const Color(0XFF98E1DA))),
      ),
    );
  }
}
