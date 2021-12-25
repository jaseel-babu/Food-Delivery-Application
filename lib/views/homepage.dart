import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:speechtotext/controller/controller.dart';
import 'package:get/get.dart';
import 'package:speechtotext/views/loginpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = Controller();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Stack(
            alignment: AlignmentDirectional.bottomEnd,
            children: [
              PageView.builder(
                controller: controller.pageController,
                onPageChanged: controller.selectedIndex,
                scrollDirection: Axis.horizontal,
                itemCount: controller.onboardingpage.length,
                itemBuilder: (context, index) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset(
                            controller.onboardingpage[index].imageAsset),
                        Text(
                          controller.onboardingpage[index].title,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 22),
                        )
                      ],
                    ),
                  );
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  controller.onboardingpage.length,
                  (index) => Obx(
                    () {
                      return Container(
                        margin: const EdgeInsets.all(4),
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                            color: controller.selectedIndex == index
                                ? Colors.red
                                : Colors.grey,
                            shape: BoxShape.circle),
                      );
                    },
                  ),
                ),
              ),
              Positioned(
                right: 20,
                bottom: 20,
                child: Obx(
                  () => FloatingActionButton(
                    onPressed: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.setBool("onboard", true);
                      if (controller.selectedIndex ==
                          controller.onboardingpage.length - 1) {
                        Get.off(() => LoginPage());
                      }
                      controller.pageforward();
                    },
                    child: controller.selectedIndex ==
                            controller.onboardingpage.length - 1
                        ? Text("start")
                        : Text("Next"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
