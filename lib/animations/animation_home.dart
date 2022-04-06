import 'package:flutter/material.dart';

class AnimationHomePage extends StatefulWidget {
  const AnimationHomePage({Key? key}) : super(key: key);

  @override
  _AnimationHomePageState createState() => _AnimationHomePageState();
}

class _AnimationHomePageState extends State<AnimationHomePage> with SingleTickerProviderStateMixin {
  late Animation<double> animation;
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
          // Center(
          //   child: SizedBox(
          //     child: const FlutterLogo(),
          //     height: animation.value.toDouble(),
          //     width: animation.value.toDouble(),
          //   ),
          // ),
          Center(child: AnimatedLogo(animation: animation)),
        ],
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

  void initAnimation() async {
    animation = Tween<double>(begin: 0, end: 300).animate(controller);
    controller.forward();
    await Future.delayed(const Duration(seconds: 2));
  }
}

class AnimatedLogo extends AnimatedWidget {
  const AnimatedLogo({Key? key, required Animation<double> animation}) : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        height: animation.value,
        width: animation.value,
        child: const FlutterLogo(),
      ),
    );
  }
}
