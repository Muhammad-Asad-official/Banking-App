
import 'package:ad_bank/exchange-screen.dart';
import 'package:ad_bank/payment-screen.dart';
import 'package:ad_bank/profile_screen.dart';
import 'package:ad_bank/transaction-screen.dart';
import 'package:flutter/material.dart';

import 'account_screen.dart';
import 'add-card-screen.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.indigo,
      child: ListView(
        padding: EdgeInsets.zero,
        children:  [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.indigo),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: Text("AD Bank",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 40),),
          ),
          ListTile(
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileScreen()));
            },
            title: const Text("PROFILE",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),),
          ),
          ListTile(
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => const AccountScreen()));
            },
            title: const Text("ACCOUNT",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),),
          ),//account
          ListTile(
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => const AddCardScreen()));
            } ,
            title: const Text("AD CARD",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),),
          ),//add card
          const Divider(color: Colors.grey,),
          ListTile(
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => const TransactionScreen()));
            },
            title: const Text("TRANSACTION",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),),
          ),//transaction
          InkWell(
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => const PaymentScreen()));
            },
            child: const ListTile(
              title: Text("PAYMENT",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),),
            ),
          ),
          const Divider(color: Colors.grey,),
          InkWell(
            onTap: (){
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => const ExchangeScreen()));
            },
            child: const ListTile(
              title: Text("EXCHANGE",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),),
            ),
          ),
        ],
      ),
    );
  }
}
