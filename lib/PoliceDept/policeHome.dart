import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PoliceHome extends StatefulWidget {
  @override
  _PoliceHomeState createState() => _PoliceHomeState();
}

class _PoliceHomeState extends State<PoliceHome> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
          child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text("Recent Requests",
                    style: GoogleFonts.josefinSans(
                        fontSize: 25, fontWeight: FontWeight.bold)),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Text("Pending Requests",
                        style: TextStyle(color: Colors.red)))),
            Container(
                height: 80,
                width: w - 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Checkbox(
                      value: false,
                      onChanged: (value) {
                        setState(() {
                          value = true;
                        });
                      },
                    ),
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Fortis Hospital, Mumbai",
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold)),
                          Row(
                            children: <Widget>[
                              Text("Expected Arrival:",
                                  style: TextStyle(
                                    fontSize: 10,
                                  )),
                              Text("10 mins",
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.red)),
                            ],
                          )
                        ],
                      ),
                      width: w - 220,
                    ),
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      color: Colors.red,
                      onPressed: () {},
                      child: Text(
                        "View on Map",
                        style: TextStyle(fontSize: 10, color: Colors.white),
                      ),
                    )
                  ],
                ),
                color: Color.fromRGBO(238, 239, 248, 1)),
            SizedBox(
              height: 40,
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Text("Completed",
                        style: TextStyle(color: Colors.blue))))
          ],
        ),
      )),
    );
  }
}
