import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class PoliceHome extends StatefulWidget {
  @override
  _PoliceHomeState createState() => _PoliceHomeState();
}

class _PoliceHomeState extends State<PoliceHome> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    // <1> Use StreamBuilder
    return StreamBuilder<QuerySnapshot>(
        // <2> Pass `Stream<QuerySnapshot>` to stream
        stream:
            FirebaseFirestore.instance.collection('notifications').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // <3> Retrieve `List<DocumentSnapshot>` from snapshot
            final List<DocumentSnapshot> documents = snapshot.data.docs;
            return ListView(
                children: documents
                    .map((doc) => Card(
                          child: ListTile(
                            title: Text(doc['location']),
                            subtitle: Text("From: " +
                                doc['from'] +
                                "\n" +
                                "To: " +
                                doc['to']),
                            trailing: Text("Arrival in 10 mins"),
                            leading: Checkbox(
                                value: false,
                                onChanged: (value) {
                                  setState(() {
                                    value = true;
                                  });
                                  var ref = FirebaseFirestore.instance
                                      .collection('notifications')
                                      .doc(doc.id);
                                  ref.update({'confirmed': true});
                                }),
                          ),
                        ))
                    .toList());
          } else if (snapshot.hasError) {
            return Text('Its Error!');
          } else {
            return Text('hehe');
          }
        });
  }
}
