import 'package:cse_450/assignment_02/user.dart';
import 'package:flutter/material.dart';

class FormPage extends StatefulWidget {
  const FormPage({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  late TextEditingController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.text = widget.user.name;
    controller = TextEditingController(text: widget.user.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextField(
            controller: TextEditingController(text: widget.user.name),
          )
        ],
      ),
    );
  }
}
