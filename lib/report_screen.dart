import 'package:flutter/material.dart';
import 'package:glass/src/GlassWidget.dart';
import 'package:mereter/user.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
//import 'dart:io';

const TextStyle textStyle = TextStyle(
  fontSize: 30,
  fontFamily: 'SF Pro Display',
  color : Color(0xff3d3d3d),
);

class ReportScreen extends StatefulWidget {
  const ReportScreen(this.patient, {Key? key,}) : super(key: key);
  static const String id = 'reportScreen';
  final Patient patient;
  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {


  @override
  Widget build(BuildContext context) {
    List<String> urls = widget.patient.getUserReportsURLS();
    List<String> names = widget.patient.getReportNames();
    List<String> dates = widget.patient.getReportDates();
    List<String> labs = widget.patient.getReportLab();



    return Container(
      decoration:const BoxDecoration(
        image: DecorationImage(image : NetworkImage('https://firebasestorage.googleapis.com/v0/b/mereter-35f11.appspot.com/o/backdrop.png?alt=media&token=643db69d-e72b-4303-ae4d-f73b6698241c'), fit: BoxFit.cover)
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: ListView.builder(itemBuilder: (BuildContext context, int index) {

            if(index == 0){
              return Column(
                children: [
                  const SizedBox(height: 40,),
                  const Text("YOUR REPORTS",
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
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      minVerticalPadding: 10,
                      trailing: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Lab No. '+ labs[index],style: const TextStyle(fontFamily: 'SF Pro Display',fontSize: 20,color: Color(0xff3d3d3d)),),
                          const SizedBox(height: 10,),
                          const Text('MLT No. ' + '#SL5285',style: TextStyle(fontFamily: 'SF Pro Display',fontSize: 20,color: Color(0xff3d3d3d)),),

                        ],
                      ),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(
                          builder: (BuildContext context) =>
                              SfPdfViewer.network(
                                  urls[index]),
                        ));
                      },
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          const Text('Report type', style:TextStyle(fontSize: 15,fontFamily: 'SF Pro Display',color: Color(0xff3d3d3d)),),
                          Text(names[index],style: const TextStyle(fontSize: 30,fontFamily: 'SF Pro Display',color: Color(0xff3d3d3d)),),
                        ],
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10,),
                          const Text('Report issued Date', style:TextStyle(fontSize: 15,fontFamily: 'SF Pro Display',color: Color(0xff3d3d3d)),),
                          Text(dates[index],style: const TextStyle(fontSize: 20,fontFamily: 'SF Pro Display',color: Color(0xff3d3d3d)),),
                        ],
                      ),
                    ).asGlass(clipBorderRadius: BorderRadius.circular(25),tintColor: const Color(0XFF98E1DA)),
                  ),

                ],
              );
            }

            else{
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  minVerticalPadding: 10,
                  trailing: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Lab No. '+ labs[index],style: const TextStyle(fontFamily: 'SF Pro Display',fontSize: 20,color: Color(0xff3d3d3d)),),
                      const SizedBox(height: 10,),
                      const Text('MLT No. ' + '#SL5285',style: TextStyle(fontFamily: 'SF Pro Display',fontSize: 20,color: Color(0xff3d3d3d)),),

                    ],
                  ),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(
                      builder: (BuildContext context) =>
                          SfPdfViewer.network(
                              urls[index]),
                    ));
                  },
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      const Text('Report type', style: TextStyle(fontSize: 15,fontFamily: 'SF Pro Display',color: Color(0xff3d3d3d)),),
                      Text(names[index],style: const TextStyle(fontSize: 30,fontFamily: 'SF Pro Display',color: Color(0xff3d3d3d)),),
                    ],
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10,),
                      const Text('Report issued Date', style: TextStyle(fontSize: 15,fontFamily: 'SF Pro Display',color: Color(0xff3d3d3d)),),
                      Text(dates[index],style: const TextStyle(fontSize: 20,fontFamily: 'SF Pro Display',color: Color(0xff3d3d3d)),),
                    ],
                  ),
                ).asGlass(clipBorderRadius: BorderRadius.circular(25),tintColor: const Color(0XFF98E1DA)),
              );
            }
          },
            itemCount: urls.length,
          ),
        ),),
    );
  }}
