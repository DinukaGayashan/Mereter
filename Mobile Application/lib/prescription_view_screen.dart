import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:glass/src/GlassWidget.dart';

class PrescriptionViewScreen extends StatefulWidget {
  final dynamic prescription;
  const PrescriptionViewScreen({Key? key, required this.prescription})
      : super(key: key);

  @override
  _PrescriptionViewScreenState createState() => _PrescriptionViewScreenState();
}

class _PrescriptionViewScreenState extends State<PrescriptionViewScreen> {
  @override
  Widget build(BuildContext context) {
    final prescription = widget.prescription;
    List<String> prescriptionDetails = [];

    prescriptionDetails.add(prescription['PrescriptionNo']);
    prescriptionDetails.add(prescription['Doctor']);
    prescriptionDetails.add(prescription['Date']);
    prescriptionDetails.add(prescription['Data']);

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(image : NetworkImage('https://firebasestorage.googleapis.com/v0/b/mereter-35f11.appspot.com/o/backdrop.png?alt=media&token=643db69d-e72b-4303-ae4d-f73b6698241c'),fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
            child: ListView.builder(
                itemCount: prescriptionDetails.length,
                itemBuilder: (BuildContext context, int index) {
                  String heading = "Null";
                  if (index == 0) {
                    heading = "Prescription number";

                    return Column(
                      children: [
                        const SizedBox(height: 40,),
                        const Text("Prescription Details",
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
                                color: Color(0xFFAAAAAA)),
                          ),
                          subtitle: Text(
                            prescriptionDetails[index],
                            style: const TextStyle(
                                fontSize: 25,
                                fontFamily: 'SF Pro Display',
                                color: Color(0xFF3D3D3D)),
                          ),
                        ),
                      ],
                    );

                  } else if (index == 1) {
                    heading = "Doctor";
                  } else if (index == 2) {
                    heading = "Date";
                  } else if (index == 3) {
                    heading = "Data";
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
                      prescriptionDetails[index],
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
