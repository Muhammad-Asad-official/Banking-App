import 'package:ad_bank/auth/login_screen.dart';
import 'package:ad_bank/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../buttons/press-button.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class  _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  bool loading = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  void resetPassword() {

    setState(() {
      loading = true;
    });

    _auth.sendPasswordResetEmail(
        email: emailController.text).then((value) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const LogInScreen()));
      Utils().toastMessage('Please check your email to reset your password');
      setState(() {
        loading = false;
      });
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
      Utils().toastMessage(error.toString());
      setState(() {
        loading = false;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
              height: MediaQuery.of(context).size.height * .45,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.indigo, Colors.blue],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter)),
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .08,
                  ),
                  const Text(
                    "Forgot Password!",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .02,
                  ),
                  const Image(
                    image: AssetImage('assets/images/bank-icon.png'),
                  )
                ],
              )), //upper design
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * .03,
                ),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xffebebeb),
                            hintText: 'Username or Email',
                            prefixIcon: const Icon(Icons.email_outlined),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Colors.blue,
                                )),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                const BorderSide(color: Colors.grey)),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter Your Email';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .03,
                        ),
                      ],
                    )),

                SizedBox(
                  height: MediaQuery.of(context).size.height * .03,
                ),
                PressButton(
                    title: "Reset",
                    loadingIcon: loading,
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        resetPassword();
                      }
                    }), //logIN Button

              ],
            ),
          )
        ],
      ),
    );
  }
}
