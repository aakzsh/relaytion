import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:relaytion/HealthCare/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Relaytion',
      theme: ThemeData(
        primarySwatch: Colors.red,
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
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text("Relaytion"),
            Text("subtitle"),
            Row(
              children: <Widget>[
                MaterialButton(
                    child: Text("Healthcare side"),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HospitalLogin()));
                    }),
                MaterialButton(child: Text("Police side"), onPressed: () {})
              ],
            )
          ],
        ),
      ),
    );
  }
}
