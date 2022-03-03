import 'dart:convert';

import 'package:cse_450/assignment_02/list.dart';
import 'package:cse_450/assignment_03/dish_list.dart';
import 'package:cse_450/assignment_04/list_provider.dart';
import 'package:cse_450/assignment_04/task_list.dart';
import 'package:cse_450/counter_two.dart';
import 'package:cse_450/null_safety/null_safety_page.dart';
import 'package:cse_450/profile_screen.dart';
import 'package:cse_450/provider/counter_provider.dart';
import 'package:cse_450/provider/provider_main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ListProvider()),
        ChangeNotifierProvider(create: (_) => CounterProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blueGrey,
      ),
      home: const TasksListPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String myText = '';
  final TextEditingController _controller = TextEditingController();
  bool isTextFieldVisible = false;
  bool isLoading = false;

  List<User> _users = [];

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              // Center is a layout widget. It takes a single child and positions it
              // in the middle of the parent.
              child: Column(
                // Column is also a layout widget. It takes a list of children and
                // arranges them vertically. By default, it sizes itself to fit its
                // children horizontally, and tries to be as tall as its parent.
                //
                // Invoke "debug painting" (press "p" in the console, choose the
                // "Toggle Debug Paint" action from the Flutter Inspector in Android
                // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
                // to see the wireframe for each widget.
                //
                // Column has various properties to control how it sizes itself and
                // how it positions its children. Here we use mainAxisAlignment to
                // center the children vertically; the main axis here is the vertical
                // axis because Columns are vertical (the cross axis would be
                // horizontal).
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  if (isLoading)
                    const CircularProgressIndicator()
                  else
                    Expanded(
                      child: ListView.builder(
                          itemCount: _users.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(_users[index].name),
                              subtitle: Text(_users[index].email),
                            );
                          }),
                    ),
                  const Text(
                    'You have pushed the button this many times:',
                  ),
                  Text(
                    _counter.toString(),
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  Text('My name is $myText IBA'),
                  isTextFieldVisible ? TextField(controller: _controller) : const Text('Hello'),
                  ElevatedButton(
                    onPressed: () async {
                      _counter++;
                      setState(() {});
                      // isLoading = !isLoading;
                      // setState(() {});
                      // await Future.delayed(Duration(seconds: 2));
                      // isLoading = !isLoading;
                      // setState(() {});
                    },
                    child: const Text('Login'),
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        bool isLogout = false;
                        isLogout = await showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: Text('Do you want to log out?'),
                                  content: Text('This will log you out from the application'),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop(true);
                                        },
                                        child: Text('Yes')),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop(false);
                                        },
                                        child: Text('No')),
                                  ],
                                ));
                        print(isLogout);
                      },
                      child: Text('Show pop up'))
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          isLoading = true;
          setState(() {});
          await _fetchUsers();
          isLoading = false;
          setState(() {});
          // var profile = Profile(name: "waleed", email: "@gmail");
          // Navigator.of(context).push(
          //   MaterialPageRoute(
          //     builder: (context) => CounterTwo(
          //       counter: _counter,
          //       onCounterUpdated: (value) {
          //         _counter = value;
          //         setState(() {});
          //       },
          //     ),
          //   ),
          // );
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future _fetchUsers() async {
    var url = Uri.parse('https://jsonplaceholder.typicode.com/users');
    var response = await http.get(url);
    // print('Response status: ${response.statusCode}');
    // print('Response body: ${response.body}');

    final hello = jsonDecode(response.body) as List;
    var userName = hello.first['name'];

    var users = hello.map((e) => User(name: e['name'], email: e['email'])).toList();
    _users = users;
    setState(() {});
    // for (var element in users) {
    //   print(element.name);
    //   print(element.email);
    // }}
  }
}

class User {
  final String name;
  final String email;

  User({required this.name, required this.email});
}

class Profile {
  final String name;
  final String email;

  Profile({
    required this.name,
    required this.email,
  });
}
