import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speechtotext/models/user_details.dart';
import 'package:speechtotext/views/details.dart';

class SignUp extends StatelessWidget {
  SignUp({Key? key}) : super(key: key);
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController firstcontroller = TextEditingController();
  final TextEditingController secondnamecontroller = TextEditingController();
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  final TextEditingController confirmpassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: ListView(
              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(
                  "assets/images/5526265.jpg",
                  width: 500,
                  height: 300,
                ),
                field(
                  "First Name",
                  firstcontroller,
                  Icons.person,
                  (value) {
                    RegExp regex = RegExp(r'^.{3,}$');
                    if (value!.isEmpty) {
                      return "First Name cannot be Empty";
                    } else if (!regex.hasMatch(value)) {
                      return "It Should be minimum 3 character";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 32,
                ),
                field("Second Name", secondnamecontroller, Icons.person,
                    (value) {
                  if (value!.isEmpty) {
                    return "Second Name cannot be Empty";
                  }
                  return null;
                }),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 32,
                ),
                field(
                  "Email",
                  emailcontroller,
                  Icons.email,
                  (value) {
                    if (value!.isEmpty) {
                      return "Please Enter Your Email";
                    } else if (!RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(value)) {
                      return "Please Enter a valid email";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 32,
                ),
                field(
                  "Password",
                  passwordcontroller,
                  Icons.lock,
                  (value) {
                    RegExp regex = RegExp(r'^.{6,}$');
                    if (value!.isEmpty) {
                      return "Please Enter Your Password";
                    } else if (!regex.hasMatch(value)) {
                      return "Please Enter valid passsword(min 6 character)";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 32,
                ),
                field("Confirm Password", confirmpassword, Icons.lock, (value) {
                  if (passwordcontroller.text != confirmpassword.text) {
                    return "Password don't match";
                  }
                  return null;
                }),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 32,
                ),
                ElevatedButton(
                    onPressed: () {
                      signupbutton(
                          emailcontroller.text, passwordcontroller.text);
                    },
                    child: const Text("Sign up"))
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextFormField field(String text, TextEditingController controller,
      IconData icon, String? Function(String?)? validator) {
    return TextFormField(
      validator: validator,
      controller: controller,
      onSaved: (newValue) => controller.text = newValue!,
      decoration: InputDecoration(
        label: Text(text),
        prefixIcon: Icon(icon),
        border: const OutlineInputBorder(),
      ),
      textInputAction: TextInputAction.next,
    );
  }

  void signupbutton(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) => {posttoFirestore()});
      } on FirebaseAuthException catch (e) {
        //  print(e.message);

        Get.snackbar("Faild", "Please Enter valid details");
      }
    }
  }

  void posttoFirestore() async {
//calling Firestore

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    final userModel = UserModel();
    userModel.email = user!.email;
    userModel.userid = user.uid;
    userModel.firstname = firstcontroller.text;
    userModel.secondname = secondnamecontroller.text;
    await firebaseFirestore
        .collection("user")
        .doc(user.uid)
        .set(userModel.toMap());
    Get.snackbar("Saved", "Account Created Sucessfully");
    Get.to(() => const FirstPage());
  }
}
