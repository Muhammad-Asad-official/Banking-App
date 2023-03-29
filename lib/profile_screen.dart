import 'dart:io';

import 'package:ad_bank/auth/login_screen.dart';
import 'package:ad_bank/services/session_manager.dart';
import 'package:ad_bank/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'buttons/press-button.dart';
import 'package:ad_bank/transaction-screen.dart';
import 'package:ad_bank/transfer_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'nav-drawer.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  DatabaseReference ref = FirebaseDatabase.instance.ref().child('Users');
  DatabaseReference refTransaction =
      FirebaseDatabase.instance.ref().child('Transactions');

  void uploadProfilePhoto() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxHeight: 512,
      maxWidth: 512,
      imageQuality: 72,
    );
    Reference ref = FirebaseStorage.instance
        .ref()
        .child(SessionController().userId.toString());
    ref.child(SessionController().userId.toString());
    await ref.putFile(File(image!.path));
    ref.getDownloadURL().then((value) {
      DatabaseReference ref1 = FirebaseDatabase.instance.ref().child('Users');
      ref1.child(SessionController().userId.toString()).update({
        'profilePhoto': value,
      });
    });
  }

  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    int counter = 0;
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
          drawer: const NavDrawer(),
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.indigo,
            actions: [
              IconButton(
                  onPressed: () async {
                    if (await Permission.storage.request().isGranted) {
                      uploadProfilePhoto();
                    }
                  },
                  icon: const Icon(
                    Icons.add_a_photo_outlined,
                    color: Colors.white,
                    semanticLabel: "Change Profile Photo",
                  )), //add photo
              IconButton(
                  onPressed: () {
                    _auth.signOut().then((value) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LogInScreen()));
                    }).onError((error, stackTrace) {
                      Utils().toastMessage(error.toString());
                    });
                  },
                  icon: const Icon(Icons.login_outlined)), //log out
              const SizedBox(
                width: 10,
              )
            ],
          ),
          body: StreamBuilder(
            stream: ref.child(SessionController().userId.toString()).onValue,
            builder: (context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasData) {
                Map<dynamic, dynamic> map = snapshot.data.snapshot.value;
                return Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * .44,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                              colors: [Colors.indigo, Colors.blue],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter)),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: map['profilePhoto'].toString() == ''
                                ? const Image(
                                    image: AssetImage(
                                        'assets/images/profile-photo.png'))
                                : CircleAvatar(
                                    maxRadius: 60,
                                    backgroundImage:
                                        NetworkImage(map['profilePhoto']),
                                  ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .02,
                          ),
                          Text(
                            map['userName'],
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 30),
                          ),
                          Text(
                            map['email'],
                            style: const TextStyle(
                                color: Colors.white, fontSize: 16),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .03,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)),
                            width: 300,
                            height: 130,
                            child: Column(
                              children: [
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * .01,
                                ),
                                const Text(
                                  "BALANCE",
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * .01,
                                ),
                                Text(
                                  map['accBalance'] + ' RS',
                                  style: const TextStyle(
                                      color: Colors.indigo,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * .01,
                                ),
                                PressButton(
                                  title: "TRANSFER",
                                  onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => TransferScreen(
                                                accNo: map['accountNo'],
                                              ))),
                                ) //transfer button
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .02,
                    ),
                    const Text(
                      "LATEST TRANSACTIONS",
                      style: TextStyle(color: Colors.blue, fontSize: 15),
                    ),
                    Expanded(
                      child: FirebaseAnimatedList(
                        query: refTransaction.child(SessionController().userId.toString()),
                        sort: (a, b) {
                          return b.value.toString().compareTo(a.value.toString());
                        },
                        itemBuilder: (context, snapshot, animation, index) {
                          counter = index;
                          return ListTile(
                            leading: CircleAvatar(
                              maxRadius: 20,
                              child: snapshot.child('type').value.toString() ==
                                  'Transferred'
                                  ? const Icon(Icons.arrow_downward_outlined,
                                  color: Colors.red,size: 30)
                                  : const Icon(Icons.arrow_upward_outlined,
                                  color: Colors.green,size: 30),
                            ),
                            title: snapshot.child('type').value.toString() ==
                                'Transferred'
                                ? Text(
                                '${snapshot.child('type').value} to account ${snapshot.child('toAcc').value.toString()}')
                                : Text(
                                '${snapshot.child('type').value} from account ${snapshot.child('fromAcc').value.toString()}'),
                            subtitle: Text(
                                'Message: ${snapshot.child('message').value}'),
                            trailing: Text(
                              'RS ${snapshot.child('ammount').value.toString()}',
                              style: const TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold),
                            ),
                          );
                        },
                      ),
                    ),

                    InkWell(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const TransactionScreen())),
                      child: const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        child: Align(
                            alignment: Alignment.bottomRight,
                            child: Text("more>>",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 18,
                                ))),
                      ),
                    )
                  ],
                );
              } else {
                return Center(
                  child: Text(
                    "Something went wrong",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                );
              }
            },
          ) //upper design,
          ),
    );
  }
}
