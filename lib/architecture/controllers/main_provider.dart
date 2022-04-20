import 'dart:convert';

import 'package:cse_450/architecture/entities/user.dart';
import 'package:cse_450/architecture/models/user_model.dart';
import 'package:cse_450/architecture/network_layer/network_call.dart';
import 'package:get_it/get_it.dart';

class MainProvider {
  int counter = 0;
  List<User> users = [];

  NetworkCall networkCall = GetIt.I<NetworkCall>();

  void increment() {
    counter++;
  }

  Future<List<User>> getProviderUsers() async {
    // Firebase API call

    var response = await networkCall.getUsers();

    var tasks = await networkCall.getTasks();


    var list = jsonDecode(response) as List;

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
