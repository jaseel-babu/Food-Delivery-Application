import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speechtotext/models/onboards.dart';
import 'package:get/state_manager.dart';
import 'package:get/utils.dart';

class Controller extends GetxController {
  var selectedIndex = 0.obs;
  var pageController = PageController();
  String? uid;
  bool lastpage = false;
  bool? value = false;
  String? _verificationCode;
  String? mobilenumber;
  bool verifyornext = false;
  bool googlesignedornot = false;
  User? user;
  bool? userishere = false;
  var _googleSignin = GoogleSignIn();
  bool? gmailtry = false;

  GoogleSignInAccount? googleaccount;
  @override
  void onInit() {
    getshared();
    userloged();
    alreadylogged();
    super.onInit();
  }
userloged()async{
   SharedPreferences prefs = await SharedPreferences.getInstance();
   
    gmailtry = prefs.getBool("login");
    update();
}
  loginWithGmail() async {
    this.googleaccount = await _googleSignin.signIn();
     final googleAuth = await googleaccount!.authentication;
  final credential = GoogleAuthProvider.credential(
    idToken: googleAuth.idToken,
    accessToken: googleAuth.accessToken,
  );
  await FirebaseAuth.instance.signInWithCredential(credential);
    googlesignedornot = true;

    uid = "userhere";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("login", true);
    gmailtry = prefs.getBool("login");
    update();
  }

  logoutWithGmail() async {
    this.googleaccount = await _googleSignin.signOut();
    googlesignedornot = false;
    update();
  }

  void getshared() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    value = prefs.getBool("onboard");
    update();
    print(value);
  }

  void alreadylogged() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userishere = prefs.getBool("login");
    uid = prefs.getString("uid");
    update();
  }

  pageforward() {
    selectedIndex.value == onboardingpage.length - 1
        ? lastpage = true
        : lastpage = false;
    if (lastpage == true) {}

    pageController.nextPage(duration: 300.milliseconds, curve: Curves.ease);
  }

  List<Onboardmodel> onboardingpage = [
    Onboardmodel(
        imageAsset: "assets/images/3697355.jpg", title: "Fast Delivery"),
    Onboardmodel(
        imageAsset: "assets/images/pngwing.com.png", title: "Fast Delivery"),
    Onboardmodel(
      imageAsset: "assets/images/foodpanda-right-header.png",
      title: "Fast Delivery",
    )
  ];
  // verfimobilenumber() async {
  //   await FirebaseAuth.instance.verifyPhoneNumber(
  //       timeout: Duration(seconds: 60),
  //       phoneNumber: mobilenumber!,
  //       verificationCompleted: (PhoneAuthCredential credential) async {
  //         await FirebaseAuth.instance
  //             .signInWithCredential(credential)
  //             .then((value) async {
  //           if (value.user != null) {
  //             print("success");
  //           }
  //         });
  //       },
  //       verificationFailed: (FirebaseAuthException e) {
  //         print(e);
  //       },
  //       codeSent: (verficationid, resendtoken) {
  //         _verificationCode = verficationid;
  //         update();
  //       },
  //       codeAutoRetrievalTimeout: (verificationId) {
  //         _verificationCode = verificationId;
  //         update();
  //       });
  // }
}
