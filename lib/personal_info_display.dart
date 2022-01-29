import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mereter/user.dart';
import 'package:glass/glass.dart';

class PersonalInfoDisplay extends StatefulWidget {
  final Patient loggedInUser;

  const PersonalInfoDisplay({Key? key, required this.loggedInUser})
      : super(key: key);

  @override
  _PersonalInfoDisplayState createState() => _PersonalInfoDisplayState();
}

class _PersonalInfoDisplayState extends State<PersonalInfoDisplay> {
  static const double fontSz = 15;

  @override
  Widget build(BuildContext context) {
    final currentUser = widget.loggedInUser;
    final details = currentUser.getUserData();

    //print(details['Name'].runtimeType);
    List<String> detailsList = [];

    detailsList.add(details['Name']);
    detailsList.add(details['Address']);
    detailsList.add(details['Age']);
    detailsList.add(details['Email']);
    detailsList.add(details['Mobile number']);
    detailsList.add(details['Gender']);
    detailsList.add(details['NIC']);
    detailsList.add(details['Blood group']);
    detailsList.add(details['Emergency Contact Name']);
    detailsList.add(details['Emergency Contact Number']);
    detailsList.add(details['Emergency Contact Relationship']);

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(image: NetworkImage('https://firebasestorage.googleapis.com/v0/b/mereter-35f11.appspot.com/o/backdrop.png?alt=media&token=643db69d-e72b-4303-ae4d-f73b6698241c'),fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: ListView.builder(
              itemCount: detailsList.length,
              itemBuilder: (BuildContext context, int index) {
                String heading = "Null";
                if (index == 0) {
                  heading = "Name";
                  return Column(
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      const Text(
                        "Your Personal Details",
                        style: TextStyle(
                            fontFamily: 'SF Pro Display',
                            fontSize: 40,
                            color: Color(0xff3d3d3d)),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          title: Text(
                            heading,
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                                fontSize: fontSz,
                                fontFamily: 'SF Pro Display',
                                color: Color(0xff7e7e7e)),
                          ),
                          subtitle: Text(
                            detailsList[index],
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                                fontSize: 25,
                                fontFamily: 'SF Pro Display',
                                color: Color(0xff3d3d3d)),
                          ),
                        ).asGlass(clipBorderRadius: BorderRadius.circular(25),tintColor: const Color(0XFF98E1DA)),
                      ),
                    ],
                  );
                } else {
                  if (index == 1) {
                    heading = 'Address';
                  } else if (index == 2) {
                    heading = 'Age';
                  } else if (index == 3) {
                    heading = 'Email';
                  } else if (index == 4) {
                    heading = 'Mobile No.';
                  } else if (index == 5) {
                    heading = 'Gender';
                  } else if (index == 6) {
                    heading = 'NIC';
                  } else if (index == 7) {
                    heading = 'Blood Group';
                  } else if (index == 8) {
                    heading = 'Emergency Contact Name';
                  } else if (index == 9) {
                    heading = 'Emergency Contact No.';
                  } else if (index == 10) {
                    heading = 'Emergency Contact Relationship';
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            title: Text(
                              heading,
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                  fontSize: fontSz,
                                  fontFamily: 'SF Pro Display',
                                  color: Color(0xff7e7e7e)),
                            ),
                            subtitle: Text(
                              detailsList[index],
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                  fontSize: 25,
                                  fontFamily: 'SF Pro Display',
                                  color: Color(0xff3d3d3d)),
                            ),
                          ).asGlass(clipBorderRadius: BorderRadius.circular(25),tintColor: const Color(0XFF98E1DA)),
                        ),
                        const SizedBox(height: 400,),
                      ],
                    );
                  }

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      title: Text(
                        heading,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                            fontSize: fontSz,
                            fontFamily: 'SF Pro Display',
                            color: Color(0xff7e7e7e)),
                      ),
                      subtitle: Text(
                        detailsList[index],
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                            fontSize: 25,
                            fontFamily: 'SF Pro Display',
                            color: Color(0xff3d3d3d)),
                      ),
                    ).asGlass(clipBorderRadius: BorderRadius.circular(25),tintColor: const Color(0XFF98E1DA)),
                  );
                }
              }),
        ),
      ),
    );
  }
}


