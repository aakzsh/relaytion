import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:relaytion/PoliceDept/login.dart';
import 'package:relaytion/PoliceDept/policeHome.dart';
import 'package:relaytion/PoliceDept/signup.dart';
import 'dart:math';
import 'package:relaytion/twilio.dart';

class PoliceSignup2 extends StatefulWidget {
  @override
  _PoliceSignup2State createState() => _PoliceSignup2State();
}

String name, mob, station, location;
String otp1, otp2;
String err = "";

class _PoliceSignup2State extends State<PoliceSignup2> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text("Complete your profile",
                    style: GoogleFonts.josefinSans(
                        fontSize: 25, fontWeight: FontWeight.bold)),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                onChanged: (value) {
                  name = value;
                },
                decoration: new InputDecoration(
                  labelText: "Incharge Name",
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                onChanged: (value) {
                  mob = value;
                },
                decoration: new InputDecoration(
                  labelText: "Mobile Number (with code)",
                ),
              ),
            ),
            MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  side: BorderSide(color: Color.fromRGBO(223, 74, 74, 1))),
              height: 60,
              minWidth: w - 80,
              color: Color.fromRGBO(223, 74, 74, 1),
              onPressed: () {
                setState(() {
                  otp1 = (Random().nextInt(7000) + 1000).toString();
                });
                twilioFlutter.sendSMS(
                    toNumber: "$mob", messageBody: "your otp is $otp1");
              },
              child: Text("Get OTP"),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                onChanged: (value) {
                  otp2 = value;
                },
                decoration: new InputDecoration(
                  labelText: "Enter OTP",
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                onChanged: (value) {
                  station = value;
                },
                decoration: new InputDecoration(
                  labelText: "Station Name",
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                onChanged: (value) {
                  location = value;
                },
                decoration: new InputDecoration(
                  labelText: "Location",
                ),
              ),
            ),
            MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  side: BorderSide(color: Color.fromRGBO(223, 74, 74, 1))),
              height: 60,
              minWidth: w - 80,
              color: Color.fromRGBO(223, 74, 74, 1),
              onPressed: () async {
                if (otp1 == otp2) {
                  await FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                          email: email, password: password)
                      .then((value) {
                    if (value.user != null) {
                      FirebaseFirestore.instance
                          .collection("hospitals")
                          .doc(value.user?.uid)
                          .set({
                        "location": location,
                        "mobile": mob,
                        "incharge_name": name,
                        "station": station,
                        "requests": []
                      }).then((value) => {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PoliceHome(),
                                    ))
                              });
                    }
                  }).catchError((err) {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Error"),
                            content: Text(err.message),
                            // content:
                            //     Text("Invalid content, try again!"),
                            actions: [
                              TextButton(
                                child: Text("okay"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              )
                            ],
                          );
                        });
                  });
                } else {
                  setState(() {
                    err = "wrong otp";
                  });
                }
              },
              child: Text(
                "Register",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            Text("$err")
          ],
        ),
      ),
    );
  }
}
