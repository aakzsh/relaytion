import 'package:flutter/material.dart';

class NewCorridor extends StatefulWidget {
  @override
  _NewCorridorState createState() => _NewCorridorState();
}

class _NewCorridorState extends State<NewCorridor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(hintText: "from"),
            ),
            TextField(
              decoration: InputDecoration(hintText: "to"),
            ),
            TextField(
              decoration: InputDecoration(hintText: "time"),
            ),
            TextField(
              decoration: InputDecoration(hintText: "purpose"),
            ),
            MaterialButton(
              onPressed: () {},
              child: Text("submit"),
            )
          ],
        ),
      ),
    );
  }
}
