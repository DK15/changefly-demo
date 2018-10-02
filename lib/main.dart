import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new FirstScreen(),
    );
  }
}

// Used StatefulWidget since the widget is going to be dynamic
class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen>
    with SingleTickerProviderStateMixin {
  Animation animation; // Animation object to guide the animation
  AnimationController
      animationController; // Animation Controller to control the animation object by starting it and giving them duration.

  // This method states that the animation will take 3.5 seconds
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        duration: Duration(milliseconds: 3500), vsync: this);

    animation = Tween(begin: 0.0, end: 1000.0).animate(animationController);
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return LogoAnimation(
      animation: animation,
    );
  }

  // This method is used to release the animation controller resources to avoid leaks.
  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}

// This class is used to implement AnimatedBuilder that creates a widget that can be animated with animation objects and controllers

class LogoAnimation extends AnimatedWidget {
  LogoAnimation({Key key, Animation animation})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    Animation animation = listenable;

    return new Scaffold(
      appBar: AppBar(
        title: new Text('Changefly Demo'),
      ),
      body: Container(
        padding: EdgeInsets.all(8.0),
        height: animation.value,
        width: animation.value,
        child: new Stack(
          // To properly club top, left and right images to complete the logo.
          children: <Widget>[
            new Image.asset('images/changefly-cube-top.png',
                width: 450.0, height: 150.0),
            new Image.asset('images/changefly-cube-left.png',
                width: 450.0, height: 150.0),
            new Image.asset('images/changefly-cube-right.png',
                width: 450.0, height: 150.0),
            new Image.asset('images/changefly-name.png',
                width: 450.0, height: 350.0),
            Align(
              // To place the button below the name image and at the center of the screen
              alignment: Alignment.center,
              child: new RaisedButton(
                color: Colors.blue,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              SecondScreen())); // navigates to second screen after tapping raised button
                },
                child: new Text('Tap Me For Another Surprise',
                    style: new TextStyle(color: Colors.black)),
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(10.0)),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// This class implements alternative animation for changefly logo

class SecondScreen extends StatefulWidget {
  @override
  _SecondScreenState createState() => new _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = new AnimationController(
      vsync: this,
      duration: new Duration(milliseconds: 2500),
    );

    animationController.forward(); // starts the animation
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: new Text('Another Changefly Demo'),
      ),
      body: Container(
        padding: EdgeInsets.all(8.0),
        child: new AnimatedBuilder(
          // To create rotation animation
          animation: animationController,
          child: new Stack(
            children: <Widget>[
              new Image.asset('images/changefly-cube-top.png',
                  width: 450.0, height: 150.0),
              new Image.asset(
                'images/changefly-cube-left.png',
                width: 450.0,
                height: 150.0,
              ),
              new Image.asset('images/changefly-cube-right.png',
                  width: 450.0, height: 150.0),
              new Image.asset(
                'images/changefly-name.png',
                width: 450.0,
                height: 350.0,
              ),
            ],
          ),
          builder: (BuildContext context, Widget _widget) {
            // To create AnimatedBuilder that takes 2 parameters, first is animation to get animation controller and other parameter is the builder which takes widget
            return new Transform.rotate(
              angle: animationController.value * 6.3,
              // 6.3 makes the widget to rotate 360 degrees
              child: _widget,
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}
