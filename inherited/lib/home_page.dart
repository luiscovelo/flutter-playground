import 'package:flutter/material.dart';
import 'package:inherited/home_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = HomeController.of(context);

    return Scaffold(
      body: Center(
        child: Text("Você clicou: ${controller!.value}"),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FloatingActionButton(
              child: const Text("-1"),
              onPressed: () {
                controller.decrement();
              },
            ),
            FloatingActionButton(
              child: const Text("+1"),
              onPressed: () {
                controller.increment();
              },
            ),
          ],
        ),
      ),
    );
  }
}
