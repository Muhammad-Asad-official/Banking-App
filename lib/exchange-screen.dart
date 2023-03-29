import 'buttons/key-buttons.dart';
import 'package:flutter/material.dart';

import 'nav-drawer.dart';

class ExchangeScreen extends StatefulWidget {
  const ExchangeScreen({Key? key}) : super(key: key);

  @override
  State<ExchangeScreen> createState() => _ExchangeScreenState();
}

class _ExchangeScreenState extends State<ExchangeScreen> {
  String userInput = '';
  String exchangeOutput = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("EXCHANGE"),
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
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Image(image: AssetImage('assets/images/doller.png')),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.1,
                ),
                const Image(
                    image: AssetImage('assets/images/exchange-arrow.png')),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.1,
                ),
                const Image(image: AssetImage('assets/images/euro.png')),
              ],
            ),
          ),
          //exchange photo
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.2,
                  height: MediaQuery.of(context).size.height * 0.09,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.blue)),
                  child: const Center(
                    child: Text('RS',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.04,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  height: MediaQuery.of(context).size.height * 0.09,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.blue)),
                  child: Center(
                    child: Text(
                      userInput.toString(),
                      style: const TextStyle(
                          color: Colors.blue,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Text(
            "CONVERT TO",
            style: TextStyle(color: Colors.blue),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.2,
                  height: MediaQuery.of(context).size.height * 0.09,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.blue)),
                  child: const Center(child: Text("\$",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.04,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  height: MediaQuery.of(context).size.height * 0.09,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.blue)),
                  child: Center(
                    child: userInput != '' ? Text(
                      ( int.parse(userInput) / 260.18).toString().substring(0,5),
                      style: const TextStyle(
                          color: Colors.blue,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ) : const Text('',
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    )
                  ),
                ),
              ],
            ),
          ),

          // keypad below
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                KeyButtons(
                    title: '1',
                    onPress: () {
                      userInput += '1';
                      setState(() {});
                    }),
                KeyButtons(
                  title: '2',
                  onPress: () {
                    userInput += '2';
                    setState(() {});
                  },
                ),
                KeyButtons(
                  title: '3',
                  onPress: () {
                    userInput += '3';
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                KeyButtons(
                  title: '4',
                  onPress: () {
                    userInput += '4';
                    setState(() {});
                  },
                ),
                KeyButtons(
                  title: '5',
                  onPress: () {
                    userInput += '5';
                    setState(() {});
                  },
                ),
                KeyButtons(
                  title: '6',
                  onPress: () {
                    userInput += '6';
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                KeyButtons(
                  title: '7',
                  onPress: () {
                    userInput += '7';
                    setState(() {});
                  },
                ),
                KeyButtons(
                  title: '8',
                  onPress: () {
                    userInput += '8';
                    setState(() {});
                  },
                ),
                KeyButtons(
                  title: '9',
                  onPress: () {
                    userInput += '9';
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                KeyButtons(
                  title: '00',
                  onPress: () {
                    userInput += '00';
                    setState(() {});
                  },
                ),
                KeyButtons(
                  title: '0',
                  onPress: () {
                    userInput += '0';
                    setState(() {});
                  },
                ),
                KeyButtons(
                  title: 'x',
                  onPress: () {
                    userInput = '';
                    exchangeOutput = '';
                    setState(() {});
                  },
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
