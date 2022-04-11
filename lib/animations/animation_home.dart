import 'package:flutter/material.dart';

class AnimationHomePage extends StatefulWidget {
  const AnimationHomePage({Key? key}) : super(key: key);

  @override
  _AnimationHomePageState createState() => _AnimationHomePageState();
}

class _AnimationHomePageState extends State<AnimationHomePage> with SingleTickerProviderStateMixin {
  late Animation<int> animation;
  late Animation<double> offsetAnimation;
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

    initAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(child: AnimatedLogo(animation: animation)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            controller.reverse();
          });
        },
      ),
    );
  }

  void initAnimation() async {
    final Animation<double> curve =
    CurvedAnimation(parent: controller, curve: Curves.easeOut);
    animation = IntTween(begin: 0, end: 255).animate(curve);
    // animation = Tween<int>(begin: 0, end: 300).animate(controller);
    controller.forward();
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) controller.reverse();
      if (status == AnimationStatus.dismissed) controller.forward();
    });
    await Future.delayed(const Duration(seconds: 2));
  }
}

class AnimatedLogo extends AnimatedWidget {
  const AnimatedLogo({Key? key, required Animation<int> animation}) : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<int>;
    return Center(
      child: Transform.translate(
        offset: Offset(0, animation.value.toDouble()),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          height: animation.value.toDouble(),
          width: animation.value.toDouble(),
          child: const FlutterLogo(),
        ),
      ),
    );
  }
}
