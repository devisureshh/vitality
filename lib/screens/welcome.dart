import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:vitality/screens/login.dart';
import 'package:vitality/screens/register.dart';
import 'package:vitality/components/button.dart';

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
  static const String id = '/';
}

class _WelcomeState extends State<Welcome> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;
  Animation animation2;
  Animation animation3;
  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(duration: Duration(seconds: 5), vsync: this);
    animation = ColorTween(begin: Colors.black, end: Color(0xff8ab6d6))
        .animate(controller);
    animation2 = ColorTween(begin: Colors.black, end: Color(0xff222831))
        .animate(controller);
    controller.forward();
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xFF602247),
          toolbarHeight: 50.0,
          centerTitle: true,
          title: Text(
            'VITALITY',
            style: Theme.of(context).textTheme.headline4,
          )),
      //backgroundColor: animation.value,
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: NetworkImage(
              'https://www.fonewalls.com/wp-content/uploads/2019/10/Gradient-Background-Wallpaper-002-300x585.jpg'),
          fit: BoxFit.cover,
          colorFilter: new ColorFilter.mode(
              Colors.black.withOpacity(0.8), BlendMode.dstATop),
        )),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                child: DefaultTextStyle(
                  style: const TextStyle(
                    fontSize: 75.0,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        blurRadius: 15.0,
                        color: Colors.white,
                        offset: Offset(0, 0),
                      ),
                    ],
                  ),
                  child: AnimatedTextKit(
                    totalRepeatCount: 1,
                    //repeatForever: false,
                    animatedTexts: [
                      FlickerAnimatedText('VITALITY'),
                    ],
                    onTap: () {
                      print("Tap Event");
                    },
                  ),
                ),
              ),
              DelayedDisplay(
                delay: Duration(seconds: 4),
                child: Column(children: <Widget>[
                  ConstrainedBox(
                    constraints:
                        BoxConstraints.tightFor(width: 200.0, height: 60),
                    child: Button(
                        text: 'LOGIN',
                        onPressed: () {
                          Navigator.pushNamed(context, LoginScreen.id);
                        }),
                  ),
                  SizedBox(height: 60.0),
                  ConstrainedBox(
                    constraints:
                        BoxConstraints.tightFor(width: 200.0, height: 60),
                    child: Button(
                        text: 'REGISTER',
                        onPressed: () {
                          Navigator.pushNamed(context, Register.id);
                        }),
                  )
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
