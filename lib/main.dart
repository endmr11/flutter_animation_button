import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with TickerProviderStateMixin {
//Bir veya birden fazla kontrol için TickerProviderStateMixin sınıfı kullanılır.

  Animation? _okAnimation;
  AnimationController? _okAnimationCntrllr;
  bool dokunduMu = false;

  @override
  void initState() {
    super.initState();
    _okAnimationCntrllr = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _okAnimation = Tween(begin: 0.0, end: pi).animate(_okAnimationCntrllr!);
    // ignore: avoid_print
    print("Animasyon Durumu: ${_okAnimationCntrllr!.status}");
  }

  @override
  void dispose() {
    super.dispose();
    _okAnimationCntrllr?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.pink,
        appBar: AppBar(),
        body: Center(
          child: InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onHighlightChanged: (value) {
              setState(() {
                dokunduMu = value;
              });
            },
            onTap: () {
              // ignore: avoid_print
              print(
                  "Animasyon Tamamlandı mı: ${_okAnimationCntrllr!.isCompleted}");
              // ignore: avoid_print
              print("Animasyon Durumu: ${_okAnimationCntrllr!.status}");
              setState(
                () {
                  _okAnimationCntrllr!.isCompleted
                      ? _okAnimationCntrllr!.reverse()
                      : _okAnimationCntrllr!.forward();
                },
              );
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.fastLinearToSlowEaseIn,
              height: dokunduMu ? 45 : 50,
              width: dokunduMu ? 45 : 50,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 30,
                    offset: const Offset(5, 5),
                  )
                ],
              ),
              child: AnimatedBuilder(
                animation: _okAnimationCntrllr!,
                builder: (context, child) => Transform.rotate(
                  angle: _okAnimation!.value,
                  child: const Icon(
                    Icons.expand_more,
                    size: 30.0,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
