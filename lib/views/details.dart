import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:speechtotext/controller/controller.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:speechtotext/models/user_details.dart';

class FirstPage extends StatefulWidget {
  FirstPage({Key? key}) : super(key: key);

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  void initState() {
    //_determinePosition();

    super.initState();
  }

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  final controller = Get.put(Controller());

  // var latitude = "";

  // var longitude = "";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            ListTile(
              title: GetBuilder<Controller>(
                builder: (controller) {
                  return controller.gmailtry == true
                      ? StreamBuilder(
                          stream: FirebaseAuth.instance.authStateChanges(),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return CircularProgressIndicator();
                            }if(snapshot.connectionState==ConnectionState.waiting){
                                 return CircularProgressIndicator();
                            }final user = snapshot.data as User;
                            return Text(user.displayName!);
                          })
                      : StreamBuilder(
                          stream: controller.uid == null
                              ? firebaseFirestore
                                  .collection("user")
                                  .doc(controller.user!.uid)
                                  .snapshots()
                              : firebaseFirestore
                                  .collection("user")
                                  .doc(controller.uid)
                                  .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Text(
                                (snapshot.data as dynamic)["firstname"]
                                    .toString(),
                              );
                            }
                            return const SizedBox();
                          },
                        );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
