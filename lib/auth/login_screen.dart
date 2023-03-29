import 'package:ad_bank/auth/forgot_password_screen.dart';
import 'package:ad_bank/profile_screen.dart';
import 'package:ad_bank/auth/signUp_screen.dart';
import 'package:ad_bank/services/session_manager.dart';
import 'package:ad_bank/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../buttons/press-button.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool loading = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  void login() {

    setState(() {
      loading = true;
    });

    _auth.signInWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text.toString()).then((value) {
              SessionController().userId = value.user!.uid.toString();
          Utils().toastMessage(value.user!.email.toString());
          Navigator.push(context, MaterialPageRoute(builder: (context) =>  const ProfileScreen()));
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
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
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
                      "WELCOME!",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 50,
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
                          TextFormField(
                            controller: passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: const Color(0xffebebeb),
                              hintText: 'Password',
                              prefixIcon: const Icon(Icons.lock_open_outlined),
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
                                return 'Enter Your Password';
                              }
                              return null;
                            },
                          ),
                        ],
                      )),

                  SizedBox(
                    height: MediaQuery.of(context).size.height * .03,
                  ),
                  PressButton(
                      title: "LOG IN",
                      loadingIcon: loading,
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          login();
                        }
                      }), //logIN Button
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .04,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: InkWell(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ForgotPasswordScreen())),
                      child: const Text(
                        "Forgot Password?",
                        style: TextStyle(color: Colors.lightBlue),
                      ),
                    ),
                  ), //forgot button
                  Container(
                    alignment: Alignment.center,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have account?",
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .02,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .03,
                        ),
                        InkWell(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const SignUpScreen())),
                            child: const Text(
                              "Sign Up",
                              style: TextStyle(
                                color: Colors.lightBlue,
                              ),
                            )),
                      ],
                    ),
                  ), //signUp button
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
