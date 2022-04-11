import 'package:cse_450/architecture/controllers/main_provider.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  MainProvider mainProvider = MainProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: Text(mainProvider.counter.toString()),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          mainProvider.increment();
          setState(() {});
        },
      ),
    );
  }
}
