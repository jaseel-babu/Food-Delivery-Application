import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speechtotext/views/details.dart';

class Phonenumber extends StatelessWidget {
  Phonenumber({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  final TextEditingController mobilenumbercontroller = TextEditingController();
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
                children: [
                  Image.asset("assets/images/5526265.jpg"),
                  TextFormField(
                    autofocus: false,
                    controller: mobilenumbercontroller,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please Enter Your Mobile Number";
                      } else if (value.length != 10) {
                        return "Please Enter a valid Mobile Number";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.phone_android),
                      label: Text("Mobile Number"),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text("Verify"),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  verify() async {
    if (_formKey.currentState!.validate()) {
      await Get.to(() => const FirstPage());
    }
  }
}
