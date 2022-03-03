import 'package:cse_450/assignment_04/create_task_page.dart';
import 'package:cse_450/assignment_04/list_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TasksListPage extends StatelessWidget {
  const TasksListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final list = context.watch<ListProvider>().list;
    return Scaffold(
      body: Center(
        child: list.isEmpty
            ? const Text('No Tasks')
            : ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return SizedBox(
                    height: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(list[index].title),
                        InkWell(
                          onTap: () {
                            if (!list[index].isDone) context.read<ListProvider>().markAsDone(list[index]);
                          },
                          child: Icon(list[index].isDone ? Icons.done : Icons.ac_unit),
                        ),
                        Container(
                          width: 20,
                          color: Colors.red,
                        )
                      ],
                    ),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => CreateTaskPage(),
            ),
          );
        },
      ),
    );
  }
}
