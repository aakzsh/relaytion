import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:relaytion/HealthCare/home.dart';
import 'package:relaytion/HealthCare/login.dart';
import 'package:relaytion/HealthCare/signup.dart';
import 'package:relaytion/PoliceDept/login.dart';
import 'package:relaytion/PoliceDept/policeHome.dart';
import 'package:relaytion/PoliceDept/signup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Relaytion',
      theme: ThemeData(
        primarySwatch: Colors.red,
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: WelcomeScreen(),
    );
  }
}

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            SizedBox(
              height: h / 7,
            ),
            Container(height: 100, width: w - 80, color: Colors.pink),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        side: BorderSide(
                            color: Color.fromRGBO(223, 74, 74, 1), width: 5)),
                    height: 60,
                    minWidth: w - 80,
                    color: Color.fromRGBO(223, 74, 74, 1),
                    child: Text(
                      "Continue As Hospital Department",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    onPressed: () {
                      if (FirebaseAuth.instance.currentUser != null) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HospitalHome()));
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PoliceHome()));
                      }
                    }),
                SizedBox(
                  height: 50,
                ),
                MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        side: BorderSide(
                            color: Color.fromRGBO(223, 74, 74, 1), width: 2)),
                    height: 60,
                    minWidth: w - 80,
                    color: Colors.white,
                    child: Text("Continue In As Police Official",
                        style: TextStyle(
                            color: Color.fromRGBO(223, 74, 74, 1),
                            fontSize: 14)),
                    onPressed: () {
                      if (FirebaseAuth.instance.currentUser != null) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PoliceHome()));
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PoliceLogin()));
                      }
                    })
              ],
            ),
            MaterialButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Select Profile"),
                        content: Container(
                          height: 0,
                        ),
                        actions: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                HospitalSignup()));
                                  },
                                  child: Text("HealthCare")),
                              TextButton(
                                child: Text("Police Dept"),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              PoliceSignup()));
                                },
                              )
                            ],
                          )
                        ],
                      );
                    });
              },
              child: Text("Dont't have an account? Sign Up",
                  style: TextStyle(color: Colors.blue)),
            ),
            SizedBox(
              height: h / 7,
            ),
          ],
        ),
      ),
    );
  }
}
