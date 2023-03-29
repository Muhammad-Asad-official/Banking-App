import 'package:ad_bank/nav-drawer.dart';
import 'package:ad_bank/services/session_manager.dart';
import 'package:ad_bank/utils/utils.dart';
import 'package:firebase_database/firebase_database.dart';
import 'buttons/press-button.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  DatabaseReference ref = FirebaseDatabase.instance.ref().child('Users');
  final phoneNumberController = TextEditingController();
  final addressController = TextEditingController();

  @override
  void dispose(){
    super.dispose();
    phoneNumberController.dispose();
    addressController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavDrawer(),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.indigo,
          centerTitle: true,
          title: const Text("ACCOUNT"),
          actions: const [
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Icon(Icons.settings),
            )
          ],
        ),
        resizeToAvoidBottomInset: false,
        body: StreamBuilder(
          stream: ref.child(SessionController().userId.toString()).onValue,
            builder: (context, AsyncSnapshot snapshot) {
              if(!snapshot.hasData){
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }else if(snapshot.hasData){
                Map<dynamic, dynamic> map = snapshot.data.snapshot.value;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    children: [
                       Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: map['profilePhoto'].toString() == '' ? const Image(image: AssetImage('assets/images/account-photo.png')) : CircleAvatar(
                            maxRadius: 60,
                            backgroundImage: NetworkImage(map['profilePhoto']),
                          ),
                        ),
                      ),
                      const Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 5),
                            child: Text(
                              "YOUR NAME",
                            ),
                          )),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: SizedBox(
                          height: 40,
                          child: TextFormField(
                            enabled: false,
                            decoration: InputDecoration(
                              contentPadding:
                              const EdgeInsets.symmetric(horizontal: 10),
                              filled: true,
                              fillColor: const Color(0xffebebeb),
                              hintText: map['userName'],
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: const BorderSide(
                                    color: Colors.blue,
                                  )),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: const BorderSide(color: Colors.grey)),
                            ),
                          ),
                        ),
                      ),
                      const Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 5),
                            child: Text(
                              "BANK ACCOUNT",
                            ),
                          )),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: SizedBox(
                          height: 40,
                          child: TextFormField(
                            enabled: false,
                            decoration: InputDecoration(
                              contentPadding:
                              const EdgeInsets.symmetric(horizontal: 10),
                              filled: true,
                              fillColor: const Color(0xffebebeb),
                              hintText: map['accountNo'],
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: const BorderSide(
                                    color: Colors.blue,
                                  )),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: const BorderSide(color: Colors.grey)),
                            ),
                          ),
                        ),
                      ),
                      const Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 5),
                            child: Text(
                              "EMAIL",
                            ),
                          )),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: SizedBox(
                          height: 40,
                          child: TextFormField(
                            enabled: false,
                            decoration: InputDecoration(
                              contentPadding:
                              const EdgeInsets.symmetric(horizontal: 10),
                              filled: true,
                              fillColor: const Color(0xffebebeb),
                              hintText: map['email'],
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: const BorderSide(
                                    color: Colors.blue,
                                  )),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: const BorderSide(color: Colors.grey)),
                            ),
                          ),
                        ),
                      ),
                      const Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 5),
                            child: Text(
                              "PHONE NUMBER",
                            ),
                          )),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: SizedBox(
                          height: 35,
                          child: TextFormField(

                            controller: phoneNumberController,
                            decoration: InputDecoration(
                              contentPadding:
                              const EdgeInsets.symmetric(horizontal: 10),
                              filled: true,
                              fillColor: const Color(0xffebebeb),
                              hintText: map['phoneNo'],
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: const BorderSide(
                                    color: Colors.blue,
                                  )),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: const BorderSide(color: Colors.grey)),
                            ),
                          ),
                        ),
                      ),
                      const Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 5),
                            child: Text(
                              "YOUR ADDRESS",
                            ),
                          )),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: TextFormField(
                          controller: addressController,
                          decoration: InputDecoration(
                            hintMaxLines: 3,
                            filled: true,
                            fillColor: const Color(0xffebebeb),
                            hintText: map['address'],
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(
                                  color: Colors.blue,
                                )),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(color: Colors.grey)),
                          ),
                        ),
                      ),

                      SizedBox(
                        height: MediaQuery.of(context).size.height * .04,
                      ),
                      PressButton(
                        title: "SAVE CHANGES",
                        onTap: () {
                          showMyDialog('UPDATE PROFILE');
                        },
                      ) //save button

                    ],
                  ),
                );
              }else{
                return Center(child: Text("Something went wrong", style: Theme.of(context).textTheme.titleMedium,),);
              }
            },
        )
    );
  }
  Future<void> showMyDialog(String title)async{
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.blue,
          actionsAlignment: MainAxisAlignment.center,
          title:  Center(child: Text(title,style: const TextStyle(color: Colors.white),)),
          content: SizedBox(
            height: 200,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:const [
                    Image(
                        height: 80,
                        image: AssetImage('assets/images/bank-icon.png')),
                    Padding(
                      padding: EdgeInsets.only(left: 20, top: 30),
                      child: Text('AD BANK',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                    )
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.all(20),
                  child: Text('Are you sure! to update profile',style: TextStyle(fontSize: 16),),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text('CONFIRM',style: TextStyle(color: Colors.white)),
              onPressed: () {
                Navigator.pop(context);
                if(phoneNumberController.text.toString() != ''){
                  ref.child(SessionController().userId.toString()).update({
                    'phoneNo' : phoneNumberController.text.toString(),
                  }).then((value){
                    Utils().toastMessage('Profile updated successfully');
                  }).onError((error, stackTrace){
                    Utils().toastMessage(error.toString());
                  });
                }
                if(addressController.text.toString() != ''){
                  ref.child(SessionController().userId.toString()).update({
                    'address' : addressController.text.toString()
                  }).then((value){
                    Utils().toastMessage('Profile updated successfully');
                  }).onError((error, stackTrace){
                    Utils().toastMessage(error.toString());
                  });
                }
              }
            ),
            TextButton(
                onPressed:() => Navigator.pop(context),
                child: const Text('CANCEL',style: TextStyle(color: Colors.white),)
            )
          ],
        );
      },
    );
  }
}
