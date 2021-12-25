import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speechtotext/models/onboards.dart';
import 'package:get/state_manager.dart';
import 'package:get/utils.dart';

class Controller extends GetxController {
  var selectedIndex = 0.obs;
  var pageController = PageController();
  bool lastpage = false;
  bool? value = false;
  @override
  void onInit() {
    getshared();

    super.onInit();
  }

  void getshared() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    value = prefs.getBool("onboard");
    update();
    print(value);
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
        title: "Fast Delivery")
  ];
}
