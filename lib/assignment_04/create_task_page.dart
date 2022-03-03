import 'package:cse_450/assignment_04/list_provider.dart';
import 'package:cse_450/assignment_04/task.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateTaskPage extends StatelessWidget {
  CreateTaskPage({Key? key}) : super(key: key);

  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextField(
          controller: controller,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<ListProvider>().addTask(
                Task(
                  title: controller.text,
                ),
              );
        },
      ),
    );
  }
}
