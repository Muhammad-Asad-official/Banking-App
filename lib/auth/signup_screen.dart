import 'package:ad_bank/TermOfUse/Terms-of-use-screen.dart';
import 'package:ad_bank/auth/login_screen.dart';
import 'package:ad_bank/utils/utils.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../buttons/press-button.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool? isChecked = false;
  bool loading = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final userNameController = TextEditingController();
  final accountNoController = TextEditingController();
  final _formKey = GlobalKey <FormState> () ;



 DatabaseReference ref = FirebaseDatabase.instance.ref().child('Users');
 DatabaseReference refTransaction = FirebaseDatabase.instance.ref().child('Transactions');
 final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void dispose(){
    super.dispose();
  emailController.dispose();
  passwordController.dispose();
  userNameController.dispose();
  accountNoController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            //upper design
            Container(
                height: MediaQuery.of(context).size.height * .30,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.indigo, Colors.blue],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter)),
                child: SafeArea(
                  //upper design
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .03,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Image(
                            image: AssetImage('assets/images/bank-icon.png'),
                            height: 80,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * .02,
                          ),
                          const Image(
                            image: AssetImage('assets/images/link.png'),
                            height: 50,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * .02,
                          ),
                          const Image(
                            image: AssetImage('assets/images/mobile.png'),
                            height: 100,
                          )
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .01,
                      ),
                      const Text(
                        "Connect to your bank account",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 19,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                )),
            //lower design
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: userNameController,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xffebebeb),
                            hintText: 'Your Name',
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Colors.blue,
                                )),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(color: Colors.grey)),
                          ),
                          validator: (value) {
                            if(value!.isEmpty){
                              return 'Enter Your Name';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .02,
                        ),
                        TextFormField(
                          controller: accountNoController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xffebebeb),
                            hintText: 'Bank Account',
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Colors.blue,
                                )),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(color: Colors.grey)),
                          ),
                          validator: (value) {
                            if(value!.isEmpty){
                              return 'Enter Your Bank Account';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .02,
                        ),
                        TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xffebebeb),
                            hintText: 'Email',
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Colors.blue,
                                )),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(color: Colors.grey)),
                          ),
                          validator: (value) {
                            if(value!.isEmpty){
                              return 'Enter Your Email';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .02,
                        ),
                        TextFormField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xffebebeb),
                            hintText: 'Password',
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Colors.blue,
                                )),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(color: Colors.grey)),
                          ),
                          validator: (value) {
                            if(value!.isEmpty){
                              return 'Enter Your Password';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .01,
                        ),
                      ],
                    ),
                  ),
                  const Text(
                    "Use mix letters, numbers & symbols of minimum 6 characters",
                    style: TextStyle(color: Colors.blue),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                    ),
                    child: Row(
                      children: [
                        Checkbox(
                            value: isChecked,
                            onChanged: (newBool) {
                              setState(() {
                                isChecked = newBool;
                              });
                            }),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:  [
                            const Text(
                              "By signing up, you agree to Bank's ",
                              style: TextStyle(color: Colors.grey),
                            ),
                            InkWell(
                              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const TermsOfUseScreen())),
                              child: const Text(
                                "Terms of Use & Privacy Policy.",
                                style: TextStyle(color: Colors.blue),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      PressButton(
                        title: "SIGN UP",
                        loadingIcon: loading,
                        onTap: () {
                          if(_formKey.currentState!.validate() && ( isChecked == true)){
                            setState(() {
                              loading = true;
                            });
                            _auth.createUserWithEmailAndPassword(
                                email: emailController.text,
                                password: passwordController.text).then((value){
                              Utils().toastMessage("Account Created Successfully");
                                  ref.child(value.user!.uid.toString()).set({
                                    'uid' : value.user!.uid.toString(),
                                    'userName' : userNameController.text.toString(),
                                    'accountNo' : accountNoController.text,
                                    'email' : value.user!.email.toString(),
                                    'profilePhoto': '',
                                    'accBalance': '0',
                                    'phoneNo': '',
                                    'address': '',
                                  }).then((value){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => const LogInScreen()));
                                    setState(() {
                                      loading = false;
                                    });
                                  }).onError((error, stackTrace){
                                    Utils().toastMessage(error.toString());
                                    setState(() {
                                      loading = false;
                                    });
                                  });
                            }).onError((error, stackTrace){
                              Utils().toastMessage(error.toString());
                              setState(() {
                                loading = false;
                              });
                            });
                          }
                        },),//signup button

                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "or",
                          style: TextStyle(color: Colors.grey, fontSize: 20),
                        ),
                      ),
                      Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(width: 2, color: Colors.grey)),
                          width: 130,
                          height: 40,
                          child: InkWell(
                            onTap: () {
                              userNameController.text = '';
                              accountNoController.text = '';
                              emailController.text = '';
                              passwordController.text = '';
                            },
                            child: const Text(
                              "CLEAR",
                              style: TextStyle(color: Colors.grey, fontSize: 20),
                            ),
                          )),//cancel button
                    ],
                  ),//buttons
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .01,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text("Already Signed Up?"),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .02,
                        ),
                        InkWell(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LogInScreen())),
                            child: const Text(
                              "Log In",
                              style: TextStyle(
                                color: Colors.lightBlue,
                              ),
                            ))
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
