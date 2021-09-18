import 'package:flutter/material.dart';
import 'package:relaytion/HealthCare/home.dart';
import 'package:relaytion/HealthCare/login.dart';
import 'dart:math';

import 'package:relaytion/twilio.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HospitalLogin2 extends StatefulWidget {
  @override
  _HospitalLogin2State createState() => _HospitalLogin2State();
}

class _HospitalLogin2State extends State<HospitalLogin2> {
  TextEditingController number;
  TextEditingController mob;
  TextEditingController otp;
  String msg = "";
  String msg2 = "";

  String numGenerated;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("verify mobile number"),
          TextField(
            controller: mob,
            decoration: InputDecoration(hintText: "enter number"),
          ),
          MaterialButton(
            onPressed: () {
              setState(() {
                numGenerated =
                    (1000 + Random().nextInt(9999 - 1000)).toString();
              });
              twilioFlutter
                  .sendSMS(
                      toNumber: mob.text,
                      messageBody: "your otp is $numGenerated")
                  .then((value) => {
                        setState(() {
                          msg = "otp sent successfully!";
                        })
                      });
            },
            child: Text("get otp"),
          ),
          Text("$msg"),
          TextField(
            controller: number,
            decoration: InputDecoration(hintText: 'enter otp'),
          ),
          MaterialButton(
            child: Text("login"),
            onPressed: () async {
              if (numGenerated.toString() == number.text.toString()) {
                await FirebaseAuth.instance
                    .signInWithEmailAndPassword(
                        email: email.text, password: pass.text)
                    .then((value) {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HospitalHome(),
                      ));
                }).catchError((err) {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Error"),
                          content: Text(err.message),
                          actions: [
                            TextButton(
                              child: Text("Ok"),
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
                  msg2 = "Wrong OTP!!";
                });
              }
            },
          ),
          Text("$msg2"),
        ],
      ),
    ));
  }
}
