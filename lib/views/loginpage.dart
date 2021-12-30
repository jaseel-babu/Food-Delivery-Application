import 'dart:async';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speechtotext/controller/controller.dart';
import 'package:speechtotext/views/details.dart';
import 'package:speechtotext/views/phonenumber.dart';
import 'package:speechtotext/views/signup.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  //Calling Firebase
  final controller = Get.put(Controller());
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Center(
            child: Form(
              key: _formKey,
              child: ListView(
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.asset("assets/images/5526265.jpg"),
                  TextFormField(
                    autofocus: false,
                    controller: emailcontroller,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please Enter Your Email";
                      } else if (!RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value)) {
                        return "Please Enter a valid email";
                      }
                      return null;
                    },
                    onSaved: (newValue) => emailcontroller.text = newValue!,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.email_outlined),
                      label: Text("Email"),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.lock,
                      ),
                      label: Text("Password"),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      RegExp regex = RegExp(r'^.{6,}$');
                      if (value!.isEmpty) {
                        return "Please Enter Your Password";
                      } else if (!regex.hasMatch(value)) {
                        return "Please Enter valid passsword(min 6 character)";
                      }
                      return null;
                    },
                    obscureText: true,
                    autofocus: false,
                    textInputAction: TextInputAction.done,
                    controller: passwordcontroller,
                    onSaved: (newValue) => passwordcontroller.text = newValue!,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        login(emailcontroller.text, passwordcontroller.text);
                      },
                      child: const Text("Log In")),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?"),
                      GestureDetector(
                        onTap: () {
                          Get.to(() => SignUp());
                        },
                        child: const Text(
                          "Sign up",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.red),
                        ),
                      )
                    ],
                  ),
                  // TextButton(
                  //   onPressed: () {
                  //     Get.to(() => Phonenumber());
                  //   },
                  //   child: const Text("Login With Mobile Number"),
                  // ),
                  const SizedBox(
                    height: 10,
                  ),
                  GetBuilder<Controller>(
                    // id: "signwithGoogle",
                    builder: (controller) {
                      return FloatingActionButton.extended(
                        backgroundColor: Colors.white,
                        icon: Image.asset(
                          "assets/images/google-logo-9824.png",
                          height: 30,
                          width: 30,
                        ),
                        onPressed: () {
                          controller.loginWithGmail();

                          Timer(
                            const Duration(seconds: 3),
                            () {
                              controller.googlesignedornot == true
                                  ? Get.off(() => FirstPage())
                                  : print("illa");
                            },
                          );
                        },
                        label: const Text(
                          "Sign With Google",
                          style: TextStyle(color: Colors.black),
                        ),
                      );
                      ;
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void login(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        print("validate");
        controller.user = (await _auth.signInWithEmailAndPassword(
                email: email, password: password))
            .user!;

        Get.off(() => FirstPage());
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool("onboard", true);
        Get.snackbar("Success", "Logined Sucessfully",
            snackPosition: SnackPosition.BOTTOM);
      } on FirebaseAuthException catch (e) {
        print(e.message);
        if (e.code == 'user-not-found') {
          Get.snackbar(
            "Faild",
            "User Not Found",
            snackPosition: SnackPosition.BOTTOM,
          );
        }
      }
    }
  }
}
