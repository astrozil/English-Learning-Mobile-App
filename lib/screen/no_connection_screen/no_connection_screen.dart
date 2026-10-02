import 'package:flutter/material.dart';
import 'package:intern_project/controller/connectivity_controller.dart';

class NoConnectionScreen extends StatefulWidget {
  const NoConnectionScreen({super.key});

  @override
  State<NoConnectionScreen> createState() => _NoConnectionScreenState();
}

class _NoConnectionScreenState extends State<NoConnectionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          const Text("No Internet Connection"),
          ElevatedButton(
              onPressed: () {
                ConnectivityController.to.checkConnectivity();
              },
              child: const Text("Retry"))
        ],
      ),
    );
  }
}
