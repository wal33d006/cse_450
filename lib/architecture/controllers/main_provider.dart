import 'dart:convert';

import 'package:cse_450/architecture/entities/user.dart';
import 'package:cse_450/architecture/models/user_model.dart';
import 'package:cse_450/architecture/network_layer/network_call.dart';



class MainProvider {
  int counter = 0;
  List<User> users = [];

  void increment() {
    counter++;
  }

  Future<List<User>> getUsers() async {
    // Firebase API call

    var response = NetworkCall.get('https://jsonplaceholder.typicode.com/users');

    var list = jsonDecode(response.body) as List;

    final userList = list.map((e) => UserModel.fromJson(e as Map<String, dynamic>)).toList();

    var users = userList
        .map((e) => User(
              name: e.firstName + ' ' + e.lastName,
            ))
        .toList();

    users.addAll(users);
    return users;
  }
}
