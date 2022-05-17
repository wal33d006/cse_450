import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cse_450/animations/animation_home.dart';
import 'package:cse_450/architecture/network_layer/network_call.dart';
import 'package:cse_450/assignment_02/list.dart';
import 'package:cse_450/assignment_03/dish_list.dart';
import 'package:cse_450/assignment_04/list_provider.dart';
import 'package:cse_450/assignment_04/task_list.dart';
import 'package:cse_450/counter_two.dart';
import 'package:cse_450/null_safety/null_safety_page.dart';
import 'package:cse_450/profile_screen.dart';
import 'package:cse_450/provider/counter_provider.dart';
import 'package:cse_450/provider/provider_main.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:get_it/get_it.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });

  await FirebaseMessaging.instance.subscribeToTopic('topic');

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
      home: const MyHomePage(title: 'title'),
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
  void initState() {
    // TODO: implement initState
    super.initState();
    // getUsers();
    getSample();
    initDependencies();
  }

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
          // isLoading = true;
          // setState(() {});
          // await _fetchUsers();
          // isLoading = false;
          // setState(() {});
          addUser();
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

  Future<void> addUser() async {
    // Call the user's CollectionReference to add a new user
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    final user = User(name: 'Waleed', email: 'waleed@gmail.com');
    users
        .add(user.toJson())
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  void getUsers() {
    isLoading = true;
    setState(() {});
    FirebaseFirestore.instance.collection('users').get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        _users.add(User.fromJson(doc.data() as Map<String, dynamic>));
      });
      isLoading = false;
      setState(() {});
    });
  }

  final List<Main> _mainList = [];

  void getSample() {
    isLoading = true;
    setState(() {});
    FirebaseFirestore.instance.collection('sample').get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        _mainList.add(Main.fromJson(doc.data() as Map<String, dynamic>));
      });
      isLoading = false;
      setState(() {});
    });
  }
}

void initDependencies() {
  GetIt.instance.registerSingleton<NetworkCall>(HttpNetworkCall());
}

class User {
  final String name;
  final String email;

  User({required this.name, required this.email});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['name'] = name;
    data['company'] = email;

    return data;
  }

  static User fromJson(Map<String, dynamic> json) => User(
        name: json['full_name'],
        email: json['company'],
      );
}

class Profile {
  final String name;
  final String email;

  Profile({
    required this.name,
    required this.email,
  });
}

class Main {
  final String email;
  final String name;
  final List<Routine> routines;

  Main({
    required this.email,
    required this.name,
    required this.routines,
  });

  static Main fromJson(Map<String, dynamic> json) {
    return Main(
      email: json['email'],
      name: json['userName'],
      routines: (json['Routines'] as List).map((e) => Routine.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }
}

class Routine {
  final String routineName;
  final int numberOfProducts;
  final List<RoutineProduct> routineProducts;

  Routine({
    required this.numberOfProducts,
    required this.routineName,
    required this.routineProducts,
  });

  static Routine fromJson(Map<String, dynamic> json) {
    return Routine(
      numberOfProducts: json['NumberOfProducts'],
      routineName: json['RoutineName'],
      routineProducts:
          (json['RoutineProducts'] as List).map((e) => RoutineProduct.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }
}

class RoutineProduct {
  final String category;

  RoutineProduct({required this.category});

  static RoutineProduct fromJson(Map<String, dynamic> json) {
    return RoutineProduct(category: json['Category']);
  }
}
