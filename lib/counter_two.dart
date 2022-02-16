import 'package:cse_450/provider/counter_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CounterTwo extends StatefulWidget {
  const CounterTwo({
    Key? key,
  }) : super(key: key);

  @override
  _CounterTwoState createState() => _CounterTwoState();
}

class _CounterTwoState extends State<CounterTwo> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  context.read<CounterProvider>().increment();
                },
                child: Text('Reassign counter')),
            Hello(
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class Hello extends StatelessWidget {
  final VoidCallback onTap;

  const Hello({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Text(context.watch<CounterProvider>().count.toString()),
        ),
        Text('Google'),
        Text('Facebook'),
      ],
    );
  }
}
