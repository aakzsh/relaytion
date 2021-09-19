import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:relaytion/HealthCare/home.dart';

class HospitalSignup2 extends StatefulWidget {
  @override
  _HospitalSignup2State createState() => _HospitalSignup2State();
}

String name, mob, hospital, location;

class _HospitalSignup2State extends State<HospitalSignup2> {
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
                  hospital = value;
                },
                decoration: new InputDecoration(
                  labelText: "Mobile Number (with code)",
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                onChanged: (value) {
                  hospital = value;
                },
                decoration: new InputDecoration(
                  labelText: "Hospital Name",
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                onChanged: (value) {
                  hospital = value;
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HospitalHome()));
              },
              child: Text(
                "Register",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
