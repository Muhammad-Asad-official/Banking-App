import 'package:ad_bank/payment%20screen/electricity-screen.dart';
import 'package:ad_bank/payment%20screen/gas-screen.dart';
import 'package:ad_bank/payment%20screen/insurance-screen.dart';
import 'package:ad_bank/payment%20screen/more-screen.dart';
import 'package:ad_bank/payment%20screen/mortgage-screen.dart';
import 'package:ad_bank/payment%20screen/other-bill-screen.dart';
import 'package:ad_bank/payment%20screen/phone-screen.dart';
import 'package:ad_bank/payment%20screen/shopping-screen.dart';
import 'package:ad_bank/payment%20screen/water-screen.dart';
import 'package:ad_bank/profile_screen.dart';
import 'package:ad_bank/services/session_manager.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'nav-drawer.dart';
import 'payment screen/credit-card-screen.dart';


class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}
DatabaseReference ref = FirebaseDatabase.instance.ref().child('Users');
class _PaymentScreenState extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavDrawer(),
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
      body: StreamBuilder(
        stream: ref.child(SessionController().userId.toString()).onValue,
        builder: (context,AsyncSnapshot snapshot) {
          if(!snapshot.hasData){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }else if(snapshot.hasData){
            Map <dynamic, dynamic> map  = snapshot.data.snapshot.value;
            return Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.20,
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.indigo, Colors.blue],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter)),
                  child: Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.10,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: map['profilePhoto'].toString() == '' ? const Image(image: AssetImage('assets/images/profile-photo.png')) : CircleAvatar(
                          maxRadius: 50,
                          backgroundImage: NetworkImage(map['profilePhoto']),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.05,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("BALANCE", style: TextStyle(color: Colors.grey, fontSize: 18),),
                          SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                           Text('${map['accBalance']} RS',style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontSize: 30),)
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.06,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:[
                    InkWell(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const WaterScreen())),
                      child: Column(
                        children: [
                          const Image(image: AssetImage('assets/images/water.png')),
                          Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text("Water",style: TextStyle(color: Colors.grey.shade600,fontSize: 18),)),
                        ],
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.06,),
                    InkWell(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ElectricityScreen())),
                      child: Column(
                        children: [
                          const Image(image: AssetImage('assets/images/electricity.png')),
                          Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text("Electricity",style: TextStyle(color: Colors.grey.shade600,fontSize: 18),)),
                        ],
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.06,),
                    InkWell(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const GasScreen())),
                      child: Column(
                        children: [
                          const Image(image: AssetImage('assets/images/gas.png')),
                          Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text("Gas",style: TextStyle(color: Colors.grey.shade600,fontSize: 18),)),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:[
                    InkWell(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ShoppingScreen())),
                      child: Column(
                        children: [
                          const Image(image: AssetImage('assets/images/shopping.png')),
                          Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text("Shopping",style: TextStyle(color: Colors.grey.shade600,fontSize: 18),)),
                        ],
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.06,),
                    InkWell(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const PhoneScreen())),
                      child: Column(
                        children: [
                          const Image(image: AssetImage('assets/images/phone.png')),
                          Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text("Phone",style: TextStyle(color: Colors.grey.shade600,fontSize: 18),)),
                        ],
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.06,),
                    InkWell(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const CreditCardScreen())),
                      child: Column(
                        children: [
                          const Image(image: AssetImage('assets/images/credit-card.png')),
                          Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text("Credit Card",style: TextStyle(color: Colors.grey.shade600,fontSize: 18),)),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:[
                    InkWell(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const InsuranceScreen())),
                      child: Column(
                        children: [
                          const Image(image: AssetImage('assets/images/insurance.png')),
                          Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text("Insurance",style: TextStyle(color: Colors.grey.shade600,fontSize: 18),)),
                        ],
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.06,),
                    InkWell(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const MortgageScreen())),
                      child: Column(
                        children: [
                          const Image(image: AssetImage('assets/images/mortgage.png')),
                          Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text("Mortgage",style: TextStyle(color: Colors.grey.shade600,fontSize: 18),)),
                        ],
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.06,),
                    InkWell(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const OtherBillsScreen())),
                      child: Column(
                        children: [
                          const Image(image: AssetImage('assets/images/other.png')),
                          Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text("Other Bills",style: TextStyle(color: Colors.grey.shade600,fontSize: 18),)),
                        ],
                      ),
                    ),
                  ],
                ),
                InkWell(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const MoreScreen())),
                  child: const Padding(
                    padding: EdgeInsets.only(right: 35, top: 30),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Text("more>>",style: TextStyle(color: Colors.blue, fontSize: 20),),
                    ),
                  ),
                )
              ],
            );
          }else{
            return Center(child: Text("Something went wrong", style: Theme.of(context).textTheme.titleMedium,),);
          }
      },)
    );
  }
}
