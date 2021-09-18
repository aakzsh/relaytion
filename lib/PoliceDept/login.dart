import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:relaytion/PoliceDept/policeHome.dart';

class PoliceLogin extends StatefulWidget {
  @override
  _PoliceLoginState createState() => _PoliceLoginState();
}

TextEditingController email;
TextEditingController pass;

class _PoliceLoginState extends State<PoliceLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("login"),
            TextField(
              controller: email,
              decoration: InputDecoration(hintText: "email"),
            ),
            TextField(
              controller: pass,
              decoration: InputDecoration(hintText: "password"),
            ),
            MaterialButton(
              onPressed: () async {
                await FirebaseAuth.instance
                    .signInWithEmailAndPassword(
                        email: email.text, password: pass.text)
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
              child: Text("login"),
            )
          ],
        ),
      ),
    );
  }
}
