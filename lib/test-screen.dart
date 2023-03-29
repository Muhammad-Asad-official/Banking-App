import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  State<TestScreen> createState() => _TestScreenState();
}

DatabaseReference ref = FirebaseDatabase.instance.ref().child('Users');

class _TestScreenState extends State<TestScreen> {
  String userId = 'no';
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(title: Text('Test Screen'),
            bottom: TabBar(tabs: [
              Tab(
                icon: Icon(Icons.safety_check)
              )
            ]),
          ),

        ));
  }
}
