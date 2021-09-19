import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:relaytion/PoliceDept/policeHome.dart';
import 'package:relaytion/PoliceDept/signup.dart';

class PoliceLogin extends StatefulWidget {
  @override
  _PoliceLoginState createState() => _PoliceLoginState();
}

String email;
String pass;

class _PoliceLoginState extends State<PoliceLogin> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text("Log In",
                    style: GoogleFonts.josefinSans(
                        fontSize: 35, fontWeight: FontWeight.bold)),
              ),
            ),
            Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: TextField(
                    onChanged: (value) {
                      email = value;
                    },
                    obscureText: true,
                    decoration: new InputDecoration(
                      labelText: "Email",
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: TextField(
                    onChanged: (value) {
                      pass = value;
                    },
                    decoration: new InputDecoration(
                      labelText: "Password",
                    ),
                  ),
                ),
              ],
            ),
            MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  side: BorderSide(color: Color.fromRGBO(223, 74, 74, 1))),
              height: 60,
              minWidth: w - 80,
              color: Color.fromRGBO(223, 74, 74, 1),
              onPressed: () async {
                await FirebaseAuth.instance
                    .signInWithEmailAndPassword(email: email, password: pass)
                    .then((value) {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PoliceHome(),
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
              },
              child: Text(
                "LogIn",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            MaterialButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PoliceSignup()));
                },
                child: Text(
                  "Don't have an account? Register",
                  style: TextStyle(color: Colors.blue),
                )),
          ],
        ),
      ),
    );
  }
}
