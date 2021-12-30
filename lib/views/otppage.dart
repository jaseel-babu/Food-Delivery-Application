import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:speechtotext/controller/controller.dart';
import 'package:speechtotext/views/details.dart';

class OtpPage extends StatelessWidget {
  OtpPage({Key? key}) : super(key: key);
  String? _verificationCode;
  final TextEditingController otpcontroller = TextEditingController();
  final controller = Controller();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Center(
            child: Form(
              //  key: _formKey,
              child: ListView(
                children: [
                  Image.asset("assets/images/5526265.jpg"),
                  TextFormField(
                    controller: otpcontroller,
                    autofocus: false,
                    onChanged: (pin) async {
                      try {
                        await FirebaseAuth.instance
                            .signInWithCredential(PhoneAuthProvider.credential(
                                verificationId: _verificationCode!,
                                smsCode: pin))
                            .then(
                          (value) async {
                            if (value.user != null) {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => FirstPage()),
                                  (route) => false);
                            }
                          },
                        );
                      } catch (e) {
                        // FocusScope.of(context).unfocus();
                        print("invalid");
                      }
                    },
                    //  controller: mobilenumbercontroller,
                    // validator: (value) {
                    //   if (value!.isEmpty) {
                    //     return "Please Enter Your Mobile Number";
                    //   } else if (value.length != 10) {
                    //     return "Please Enter a valid Mobile Number";
                    //   }
                    //   return null;
                    // },
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.phone_android),
                      label: Text("otp"),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      controller.update();
                    },
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
}
