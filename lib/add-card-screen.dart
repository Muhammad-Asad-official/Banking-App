
import 'package:ad_bank/nav-drawer.dart';
import 'package:ad_bank/services/session_manager.dart';
import 'package:ad_bank/utils/utils.dart';
import 'package:firebase_database/firebase_database.dart';
import 'buttons/press-button.dart';
import 'package:flutter/material.dart';

class AddCardScreen extends StatefulWidget {
  const AddCardScreen({Key? key}) : super(key: key);

  @override
  State<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {

  final nameController = TextEditingController();
  final cardNumberController = TextEditingController();
  final expiredDateController = TextEditingController();
  final cvcController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  DatabaseReference ref = FirebaseDatabase.instance.ref().child('Cards');

  @override
  void dispose(){
    super.dispose();
    nameController.dispose();
    cardNumberController.dispose();
    expiredDateController.dispose();
    cvcController.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.indigo,
        title: const Text('AD CARD'),
        centerTitle: true,
        actions:  const [
          Padding(
            padding: EdgeInsets.all(15.0),
            child: Icon(Icons.settings),
          )
        ],

      ),
      drawer: const NavDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
          child: Center(
            child: Column(
              children: [
                const Image(image: AssetImage("assets/images/card.png"),),
                SizedBox(height: MediaQuery.of(context).size.height * .02,),

                Form(
                  key: _formKey,
                    child: Column(
                      children: [
                        const Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 5,),
                              child: Text(
                                "YOUR NAME",
                              ),
                            )),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: SizedBox(
                            child: TextFormField(
                              controller: nameController,
                              decoration: InputDecoration(
                                contentPadding:
                                const EdgeInsets.symmetric(horizontal: 10),
                                filled: true,
                                fillColor: const Color(0xffebebeb),
                                hintText: 'Your Name',
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: const BorderSide(
                                      color: Colors.blue,
                                    )),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: const BorderSide(color: Colors.grey)),
                              ),
                              validator: (value) {
                                if(value!.isEmpty){
                                  return "Enter Your Name";
                                }
                                return null;
                              },
                            ),
                          ),
                        ),

                        const Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 5,),
                              child: Text(
                                "CARD NUMBER",
                              ),
                            )),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: SizedBox(
                            child: TextFormField(
                              controller: cardNumberController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                contentPadding:
                                const EdgeInsets.symmetric(horizontal: 10),
                                filled: true,
                                fillColor: const Color(0xffebebeb),
                                hintText: '0000 0000 0000 0000',
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: const BorderSide(
                                      color: Colors.blue,
                                    )),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: const BorderSide(color: Colors.grey)),
                              ),
                              validator: (value) {
                                if(value!.isEmpty){
                                  return "Enter Your Card number";
                                }
                                return null;
                              },
                            ),
                          ),
                        ),

                        const Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 5,),
                              child: Text(
                                "EXPIRED DATE",
                              ),
                            )),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: SizedBox(
                            child: TextFormField(
                              controller: expiredDateController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                contentPadding:
                                const EdgeInsets.symmetric(horizontal: 10),
                                filled: true,
                                fillColor: const Color(0xffebebeb),
                                hintText: 'MMYY',
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: const BorderSide(
                                      color: Colors.blue,
                                    )),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: const BorderSide(color: Colors.grey)),
                              ),
                              validator: (value) {
                                if(value!.isEmpty){
                                  return "Enter Card expiration date";
                                }
                                return null;
                              },
                            ),
                          ),
                        ),

                        const Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 5,),
                              child: Text(
                                "SECURITY CODE",
                              ),
                            )),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: SizedBox(
                            child: TextFormField(
                              controller: cvcController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                contentPadding:
                                const EdgeInsets.symmetric(horizontal: 10),
                                filled: true,
                                fillColor: const Color(0xffebebeb),
                                hintText: '***',
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: const BorderSide(
                                      color: Colors.blue,
                                    )),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: const BorderSide(color: Colors.grey)),
                              ),
                              validator: (value) {
                                if(value!.isEmpty){
                                  return "Enter Security code";
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                      ],
                    )),


                SizedBox(
                  height: MediaQuery.of(context).size.height * .01,
                ),
                 PressButton(title: "LINK CARD",
                 onTap: () {
                   if(_formKey.currentState!.validate()){
                     if(cardNumberController.text.toString().length == 16){
                       if(expiredDateController.text.toString().length == 4){
                         if(cvcController.text.toString().length == 4){
                           ref.child(SessionController().userId.toString()).set({
                             'name' : nameController.text,
                             'cardNumber' : cardNumberController.text,
                             'expireDate' : expiredDateController.text,
                             'cvc' : cvcController.text
                           }).then((value){
                             Utils().toastMessage('Card added Successfully');
                             nameController.text = '';
                             cardNumberController.text = '';
                             expiredDateController.text = '';
                             cvcController.text = '';
                           }).onError((error, stackTrace) {
                             Utils().toastMessage(error.toString());
                           });
                         }else{
                           Utils().toastMessage('Invalid! Security Code, Security code length should be 3 digits');
                         }
                       }else{
                         Utils().toastMessage('Invalid! date, add Month and year without dashes');
                       }
                     }else{
                       Utils().toastMessage('Card number format is Invalid!,use 16 digit card number');
                     }
                   }
        },),
                const Padding(
                  padding: EdgeInsets.all(20),
                  child: Center(child: Text('Your Card')),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.22,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                      gradient: LinearGradient(
                          colors: [Colors.indigo, Colors.blue],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter),
                  ),
                  child: StreamBuilder(
                    stream: ref.child(SessionController().userId.toString()).onValue,
                    builder: (context,AsyncSnapshot snapshot) {
                    if(snapshot.data.snapshot.value.toString() == 'null'){
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Padding(
                            padding: EdgeInsets.only( top: 30, left: 20),
                            child: Text("AD BANK",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white),),
                          ),
                          Padding(
                            padding: EdgeInsets.only( top: 30, left: 20),
                            child: Text("0000 0000 0000 0000",style: TextStyle(fontSize: 20,color: Colors.white),),
                          ),
                          Padding(
                            padding: EdgeInsets.only( top: 10, left: 20),
                            child: Text("VALID THRU" "  00/00",style: TextStyle(fontSize: 10,color: Colors.white),),
                          ),
                          Padding(
                            padding: EdgeInsets.only( top: 10, left: 20),
                            child: Text("No Card Found",style: TextStyle(fontSize: 20,color: Colors.white),),
                          ),
                        ],
                      );
                    }else if(snapshot.data.snapshot.value.toString() != 'null'){
                      Map<dynamic, dynamic> map = snapshot.data.snapshot.value;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:
                        [
                          const Padding(
                            padding: EdgeInsets.only( top: 30, left: 20),
                            child: Text("AD BANK",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white),),
                          ),
                          Padding(
                            padding: const EdgeInsets.only( top: 30, left: 20),
                            child: Text("${map['cardNumber'].toString().substring(0,4)} ${map['cardNumber'].toString().substring(4,8)} ${map['cardNumber'].toString().substring(8,12)} ${map['cardNumber'].toString().substring(12,16)}",style: const TextStyle(fontSize: 20,color: Colors.white),),
                          ),
                          Padding(
                            padding: const EdgeInsets.only( top: 10, left: 20),
                            child: Text("VALID THRU  ${map['expireDate'].toString().substring(0,2)} / ${map['expireDate'].toString().substring(2,4)}" ,style: const TextStyle(fontSize: 10,color: Colors.white),),
                          ),
                          Padding(
                            padding: const EdgeInsets.only( top: 10, left: 20),
                            child: Text(map['name'],style: const TextStyle(fontSize: 20,color: Colors.white),),
                          ),
                        ],
                      );
                    }else{
                      return Center(child: Text("Something went wrong", style: Theme.of(context).textTheme.titleMedium,),);
                    }
                  },)
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
