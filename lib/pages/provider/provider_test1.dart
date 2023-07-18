import 'package:flutter/material.dart';
import 'package:studychinese/pages/provider/user_model.dart';
import 'package:provider/provider.dart';

class ProviderExample extends StatelessWidget {
  const ProviderExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ProviderExample"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer<UserModel>(
              builder: (_, userModel, child) {
                return Text(userModel.name,
                    style: const TextStyle(color: Colors.red, fontSize: 30));
              },
            ),
            Consumer<UserModel>(
              builder: (_, userModel, child) {
                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: ElevatedButton(
                    onPressed: () {
                      userModel.changeName();
                    },
                    child: const Text("改变值"),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
