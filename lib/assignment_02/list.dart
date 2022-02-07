import 'package:cse_450/assignment_02/form.dart';
import 'package:cse_450/assignment_02/user.dart';
import 'package:flutter/material.dart';

class ListViewPage extends StatelessWidget {
  ListViewPage({Key? key}) : super(key: key);

  final List<User> users = [
    User(
      name: 'Waleed',
      email: '@gmail.com',
    ),
    User(
      name: 'Hello',
      email: '@gmail.com',
    ),
    User(
      name: 'Facebook',
      email: '@gmail.com',
    ),
    User(
      name: 'Google',
      email: '@gmail.com',
    ),
    User(
      name: 'Apple',
      email: '@gmail.com',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(
            users[index].name,
          ),
          subtitle: Text(users[index].email),
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => FormPage(
                user: users[index],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
