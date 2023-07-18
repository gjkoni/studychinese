import 'package:flutter/material.dart';
import 'package:studychinese/pages/provider/user_model1.dart';
import 'package:provider/provider.dart';
 
class ChangeNotifierProviderExample extends StatelessWidget {
  const ChangeNotifierProviderExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ChangeNotifierProvider"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer<UserModel1>(
              builder: (_, userModel, child) {
                return Text(userModel.name,
                    style: const TextStyle(
                        color: Colors.red,
                        fontSize: 30
                    )
                );
              },
            ),
            Consumer<UserModel1>(
              builder: (_, userModel, child) {
                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: ElevatedButton(
                    onPressed: (){
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