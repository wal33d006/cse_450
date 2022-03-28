import 'package:flutter/material.dart';

class AnimationHomePage extends StatefulWidget {
  const AnimationHomePage({Key? key}) : super(key: key);

  @override
  _AnimationHomePageState createState() => _AnimationHomePageState();
}

class _AnimationHomePageState extends State<AnimationHomePage> with SingleTickerProviderStateMixin {
  late Animation<int> animation;
  late AnimationController controller;

  double height = 100;
  double width = 100;

  @override
  void initState() {
    // TODO: implement initState
    controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    // animation = Tween<double>(begin: 50, end: 300).animate(controller);

    final Animation<double> curve =
    CurvedAnimation(parent: controller, curve: Curves.elasticInOut);
    animation = IntTween(begin: 50, end: 255).animate(curve);
    animation.addListener(() {
      print(animation.value);
      setState(() {});
    });

    animation.addStatusListener((status) {
      if(status == AnimationStatus.completed) {
        controller.reverse();
      }
      if(status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });

    // controller.forward();
    // super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          child: const FlutterLogo(),
          height: animation.value.toDouble(),
          width: animation.value.toDouble(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            controller.forward();
          });
        },
      ),
    );
  }
}
