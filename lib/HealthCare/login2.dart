import 'package:flutter/material.dart';

class HospitalLogin2 extends StatefulWidget {
  @override
  _HospitalLogin2State createState() => _HospitalLogin2State();
}

class _HospitalLogin2State extends State<HospitalLogin2> {
  TextEditingController num;
  TextEditingController otp;
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
            decoration: InputDecoration(hintText: "enter number"),
          ),
          MaterialButton(
            onPressed: () {},
            child: Text("get otp"),
          ),
          TextField(
            decoration: InputDecoration(hintText: 'enter otp'),
          ),
          MaterialButton(
            child: Text("login"),
            onPressed: () {},
          )
        ],
      ),
    ));
  }
}
