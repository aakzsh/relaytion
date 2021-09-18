import 'package:flutter/material.dart';

class Success extends StatefulWidget {
  @override
  _SuccessState createState() => _SuccessState();
}

class _SuccessState extends State<Success> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Text("success ho gaya"),
            MaterialButton(
              onPressed: () {},
              child: Text("see route"),
            )
          ],
        ),
      ),
    );
  }
}
