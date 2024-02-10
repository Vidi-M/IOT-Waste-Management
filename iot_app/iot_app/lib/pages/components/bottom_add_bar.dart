import 'package:flutter/material.dart';

class MyBottomAddBar extends StatelessWidget {
  const MyBottomAddBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        alignment: Alignment.bottomCenter,
        child: ElevatedButton(
          onPressed: () {},
          child: const Text("Add Bin"),
        ),
      ),
    );
  }
}
