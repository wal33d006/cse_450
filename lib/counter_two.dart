import 'package:flutter/material.dart';

class CounterTwo extends StatefulWidget {
  final Function(int) onCounterUpdated;
  final int counter;

  const CounterTwo({
    Key? key,
    required this.counter,
    required this.onCounterUpdated,
  }) : super(key: key);

  @override
  _CounterTwoState createState() => _CounterTwoState();
}

class _CounterTwoState extends State<CounterTwo> {
  int myCounter = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myCounter = widget.counter;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(myCounter.toString()),
            ElevatedButton(
                onPressed: () {
                  myCounter++;
                  setState(() {});
                  widget.onCounterUpdated(myCounter);
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
          child: Text('Hello'),
        ),
        Text('Google'),
        Text('Facebook'),
      ],
    );
  }
}
