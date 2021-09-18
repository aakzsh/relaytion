import 'package:flutter/material.dart';
import 'package:relaytion/HealthCare/newCorridor.dart';
import 'package:relaytion/HealthCare/profile.dart';

class HospitalHome extends StatefulWidget {
  @override
  _HospitalHomeState createState() => _HospitalHomeState();
}

class _HospitalHomeState extends State<HospitalHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text("Home"),
            MaterialButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => NewCorridor()));
              },
              child: Text("Request Corridor"),
            ),
            MaterialButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HospitalProfile()));
              },
              child: Text("View Profile"),
            ),
            MaterialButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Container()));
              },
              child: Text("Logout"),
            ),
          ],
        ),
      ),
    );
  }
}
