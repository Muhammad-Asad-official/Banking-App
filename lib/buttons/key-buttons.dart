import 'package:flutter/material.dart';

class KeyButtons extends StatelessWidget {
  final String title;
  final VoidCallback onPress;
  const KeyButtons({Key? key, required this.title, required this.onPress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.315,
        height: MediaQuery.of(context).size.height * 0.08,
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [Colors.indigo, Colors.blue],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)
        ),
        child:  Align(alignment: Alignment.center, child: Text(title,style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 40,),)),
      ),
    );
  }
}
