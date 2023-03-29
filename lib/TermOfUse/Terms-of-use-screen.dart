import 'package:flutter/material.dart';

class TermsOfUseScreen extends StatelessWidget {
  const TermsOfUseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Terms of Use"),
        elevation: 0,
        backgroundColor: Colors.indigo,
      ),
      body: const Center(child: Text('We will Update our terms very soon')),
    );
  }
}
