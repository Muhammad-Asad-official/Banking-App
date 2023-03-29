import 'package:ad_bank/buttons/press-button.dart';
import 'package:ad_bank/services/session_manager.dart';
import 'package:ad_bank/utils/utils.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'nav-drawer.dart';

class TransferScreen extends StatefulWidget {
  const TransferScreen({Key? key, required this.accNo}) : super(key: key);
  final String accNo;
  @override
  State<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  bool loading = false;
  final senderAccController = TextEditingController();
  final recieverAccController = TextEditingController();
  final ammountController = TextEditingController();
  final messageController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String userId = '';
  int availableBalanceSender=0;
  int availableBalanceReciever=0;
  String rName = '';
  DatabaseReference ref = FirebaseDatabase.instance.ref().child('Users');
  DatabaseReference refTransaction = FirebaseDatabase.instance.ref().child('Transactions');


  @override
  void dispose() {
    super.dispose();
    senderAccController.dispose();
    recieverAccController.dispose();
    ammountController.dispose();
    messageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Transfer"),
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
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 40),
        child: Center(
          child: Column(
            children: [
              const Image(
                image: AssetImage("assets/images/transaction-photo.png"),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .04,
              ),
              const Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: 5,
                    ),
                    child: Text(
                      "From Bank Account",
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: TextFormField(
                  enabled: false,
                  controller: senderAccController,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                    filled: true,
                    fillColor: const Color(0xffebebeb),
                    hintText: widget.accNo,
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
              const Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: 5,
                    ),
                    child: Text(
                      "To Bank Account",
                    ),
                  )),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: recieverAccController,
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 10),
                            filled: true,
                            fillColor: const Color(0xffebebeb),
                            hintText: '0000 0000 2122333',
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(
                                  color: Colors.blue,
                                )),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide:
                                    const BorderSide(color: Colors.grey)),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter Receiver's bank account number";
                            }
                            return null;
                          },
                        ),
                      ),
                      const Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: EdgeInsets.only(
                              bottom: 5,
                            ),
                            child: Text(
                              "Amount",
                            ),
                          )),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: ammountController,
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 10),
                            filled: true,
                            fillColor: const Color(0xffebebeb),
                            hintText: '\$1200',
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(
                                  color: Colors.blue,
                                )),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide:
                                    const BorderSide(color: Colors.grey)),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter Ammount to transfer';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  )),
              const Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: 5,
                    ),
                    child: Text(
                      "Message",
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: TextFormField(
                  controller: messageController,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                    filled: true,
                    fillColor: const Color(0xffebebeb),
                    hintText: 'example',
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

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                SizedBox(
                width: 0,
                height: 0,
                child:FirebaseAnimatedList(
                    query: ref,
                    itemBuilder: (context, snapshot, animation, index) {
                      if (snapshot.child('uid').value.toString() == SessionController().userId) {
                        availableBalanceSender = int.parse(snapshot.child('accBalance').value.toString());
                      }
                      if (snapshot.child('accountNo').value.toString() == recieverAccController.text) {
                        userId = snapshot.child('uid').value.toString();
                        availableBalanceReciever = int.parse(snapshot.child('accBalance').value.toString());
                        rName = snapshot.child('userName').value.toString();
                      }
                      return  const Text('');
                    }
                ),
              ), //transfer manager
                  PressButton(
                    loadingIcon: loading,
                    title: 'SEND',
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        if( recieverAccController.text == widget.accNo){
                          Utils().toastMessage("Sorry, You Can't transfer to your own Bank Account number",);
                        }else {
                          if (userId == '') {
                            Utils().toastMessage("You entered an Invalid account number");
                          } else {
                            if (availableBalanceSender >= int.parse(ammountController.text)) {
                              showMyDialog(rName,'TRANSFER AMMOUNT',ammountController.text);
                            } else {
                              Utils().toastMessage('OOPS!, Insufficient account balance');
                            }
                          }
                        }
                      }
                    },

                  ), //SEND button
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "or",
                      style: TextStyle(color: Colors.grey, fontSize: 20),
                    ),
                  ), //or
                  Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(width: 2, color: Colors.grey)),
                      width: 130,
                      height: 40,
                      child: InkWell(
                           onTap:  () {

                             recieverAccController.text = '';
                             ammountController.text = '';
                             messageController.text = '';
                           },
                        child: const Text(
                          "CLEAR",
                          style: TextStyle(color: Colors.grey, fontSize: 15),
                        ),
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
  Future<void> showMyDialog(String recieverName,String title,String ammount)async{
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.blue,
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
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text('Ammount: $ammount',style: const TextStyle(fontSize: 16),),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Transfer to $recieverName',style: const TextStyle(fontSize: 16),),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text('CONFIRM',style: TextStyle(color: Colors.white)),
              onPressed: () {
                Navigator.pop(context);
                int updatedRecieverBalance = int.parse(ammountController.text) + availableBalanceReciever;
                ref.child(userId).update({
                  'accBalance': updatedRecieverBalance.toString()
                }).onError((error, stackTrace) {
                  Utils().toastMessage(error.toString());
                });
                int updatedSenderBalance = availableBalanceSender - int.parse(ammountController.text);
                ref.child(SessionController().userId.toString()).update({
                  'accBalance': updatedSenderBalance.toString()
                }).then((value) {
                  refTransaction.child(SessionController().userId.toString()).child(DateTime.now().toString().substring(0,19)).set({
                    'type' : "Transferred",
                    'fromAcc' : widget.accNo,
                    'toAcc' :  recieverAccController.text,
                    'ammount' : ammountController.text,
                    'message' : messageController.text,
                    'recieverName' : rName,
                    'date' : DateTime.now().toString().substring(0,19)
                  });
                  refTransaction.child(userId).child(DateTime.now().toString().substring(0,19)).set({
                    'type' : 'Received',
                    'fromAcc' : widget.accNo,
                    'toAcc' :  recieverAccController.text,
                    'ammount' : ammountController.text,
                    'message' : messageController.text,

                    'date' : DateTime.now().toString().substring(0,19)
                  });
                  userId = '';
                  recieverAccController.text = '';
                  ammountController.text = '';
                  messageController.text = '';
                  Utils().toastMessage('Ammount transferred Successfully');
                }).onError((error, stackTrace) {
                  Utils().toastMessage(error.toString());
                });
              },
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
