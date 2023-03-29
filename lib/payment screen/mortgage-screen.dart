import 'package:flutter/material.dart';
import '../nav-drawer.dart';

class MortgageScreen extends StatefulWidget {
  const MortgageScreen({Key? key}) : super(key: key);

  @override
  State<MortgageScreen> createState() => _MortgageScreenState();
}

class _MortgageScreenState extends State<MortgageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("PAYMENT"),
        elevation: 0,
        backgroundColor: Colors.indigo,
        actions: const [
          Padding(
            padding: EdgeInsets.all(15.0),
            child: Icon(Icons.settings),
          )
        ],
      ),
      drawer: const NavDrawer(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Align(
            alignment: Alignment.center,
            child: Text("Coming Soon",style: TextStyle(fontSize: 30,color: Colors.grey),),
          )
        ],
      ),
    );
  }
}
