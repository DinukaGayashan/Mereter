import 'package:flutter/material.dart';
import 'package:glass/src/GlassWidget.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  _ContactUsState createState() => _ContactUsState();
}

const double margin = 15;
const TextStyle textStyle = TextStyle(
    fontSize: 20,
    fontFamily: 'SF Pro Display'
);

class _ContactUsState extends State<ContactUs> {
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
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children:   <Widget>[
              const SizedBox(height: 40,),
               const Text("Contact Us",
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
              const ListTile(
                  leading: Icon(Icons.phone),
                  title: Text(
                    '+94704268157',
                    style: textStyle,
                  )).asGlass(clipBorderRadius: BorderRadius.circular(25),tintColor: const Color(0XFF98E1DA)),
              const SizedBox(height: 20,),
              const ListTile(
                  leading: Icon(Icons.email),
                  title: Text(
                    'meretergroup@gmail.com',
                    style: textStyle,
                  )).asGlass(clipBorderRadius: BorderRadius.circular(25),tintColor: const Color(0XFF98E1DA)),
            ],
          ),
        ),
      ),
    );
  }
}
