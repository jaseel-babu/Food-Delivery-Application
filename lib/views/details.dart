import 'package:flutter/material.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: ListTile(
          title: Text("Location"),
          leading: Icon(Icons.location_on_outlined),
        ),
      ),
    );
  }
}
