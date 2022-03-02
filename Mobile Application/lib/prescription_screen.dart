import 'package:flutter/material.dart';
import 'package:glass/src/GlassWidget.dart';
import 'package:mereter/prescription_view_screen.dart';
import 'package:mereter/user.dart';

class PrescriptionScreen extends StatefulWidget {
    final Patient patient;
    const PrescriptionScreen(this.patient, {Key? key}) : super(key: key);

  @override
  _PrescriptionScreenState createState() => _PrescriptionScreenState();
}

class _PrescriptionScreenState extends State<PrescriptionScreen> {
  @override
  Widget build(BuildContext context) {
    List<dynamic> prescriptions = widget.patient.getUserPrescriptions();

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(image : NetworkImage('https://firebasestorage.googleapis.com/v0/b/mereter-35f11.appspot.com/o/backdrop.png?alt=media&token=643db69d-e72b-4303-ae4d-f73b6698241c'),fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: ListView.builder(itemCount: prescriptions.length,itemBuilder: (BuildContext context,int index){
            if (index == 0){
              return Column(
                children: [
                  const SizedBox(height: 40,),
                  const Text("Your Prescriptions",
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
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: ListTile(
                      onTap: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PrescriptionViewScreen(prescription: prescriptions[index])));
                      },
                      title: Text('${prescriptions[index]['Date']} Prescription No. - ${prescriptions[index].reference.id }',style: const TextStyle(fontSize: 25,fontFamily: 'SF Pro Display',color: Color(
                          0xFF3D3D3D)),),
                    ).asGlass(tintColor: const Color(0XFF98E1DA), clipBorderRadius: BorderRadius.circular(15)),
                  ),
                ],
              );
            }
            return Padding(
                padding: const EdgeInsets.all(5.0),
                child: ListTile(
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PrescriptionViewScreen(prescription: prescriptions[index])));
                  },
                  title: Text('${prescriptions[index]['Date']} Prescription No. - ${prescriptions[index].reference.id }',style: const TextStyle(fontSize: 25,fontFamily: 'SF Pro Display',color: Color(
                      0xFF3D3D3D)),),
                ).asGlass(tintColor: const Color(0XFF98E1DA), clipBorderRadius: BorderRadius.circular(15)),
              );
          })
        ),
      ),
    );
  }
}

