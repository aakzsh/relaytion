import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:relaytion/PoliceDept/login.dart';
import 'package:relaytion/PoliceDept/signup2.dart';

class PoliceSignup extends StatefulWidget {
  @override
  _PoliceSignupState createState() => _PoliceSignupState();
}

String emaill, password;

class _PoliceSignupState extends State<PoliceSignup> {
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
                child: Text("Register",
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
                      emaill = value;
                    },
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
                      password = value;
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PoliceSignup2()));
              },
              child: Text(
                "Next",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            MaterialButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PoliceLogin()));
                },
                child: Text(
                  "Already have an account? Login",
                  style: TextStyle(color: Colors.blue),
                )),
          ],
        ),
      ),
    );
  }
}
