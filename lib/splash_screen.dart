
import 'package:ad_bank/auth/splash_services.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  SplashServices splashScreen = SplashServices();
  @override
  void initState() {
    super.initState();
    splashScreen.isLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Image(image: AssetImage("assets/images/bank-icon.png")),
          Padding(
            padding: EdgeInsets.all(10),
            child: Text("AD Bank",style: TextStyle(color: Colors.white,fontSize: 40,fontWeight: FontWeight.bold,),),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: CircularProgressIndicator(
              color: Colors.white,

            ),
          ),
          Center(
              child: Padding(
                padding: EdgeInsets.only(top:150, bottom: 30),
                child: Text(
            "Developed By \nAD Creations\n(MUHAMMAD ASAD)",textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30,color: Colors.white),
          ),
              ))
        ],
      )),
    );
  }
}
