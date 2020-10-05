import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Custom Animated Button',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Custom Animated Button'),
        centerTitle: true,
      ),
      body: Body(),
    );
  }
}

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 100,
        height: 100,
        child: AnimatedIconButton(),
      ),
    );
  }
}

class AnimatedIconButton extends StatefulWidget {
  @override
  _AnimatedIconButtonState createState() => _AnimatedIconButtonState();
}

class _AnimatedIconButtonState extends State<AnimatedIconButton> with TickerProviderStateMixin{
  AnimationController _iconAnimationController;
  AnimationController _colorAnimationController;
  Animation _iconColorAnimation;
  Animation _backgroundColorAnimation;
  bool _active = false;

  @override
  void initState() {
    _iconAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 125),
      value: 1.0,
      lowerBound: 1.0,
      upperBound: 1.75,
    );

    _colorAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 125),
    );

    _iconColorAnimation = ColorTween(
      begin: Colors.black,
      end: Colors.red,
    ).animate(_colorAnimationController)..addListener(() {
      setState(() {});
    });

    _backgroundColorAnimation = ColorTween(
      begin: Colors.white,
      end: Colors.black,
    ).animate(_colorAnimationController)..addListener(() {
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          border: Border.all(color: Colors.black),
          color: _backgroundColorAnimation.value
        ),
        child: ScaleTransition(
          scale: _iconAnimationController,
          child: Icon(Icons.favorite,
            size: 40,
            color: _iconColorAnimation.value,
          ),
        ),
      ),
    );
  }

  void _onTap() {
    _iconAnimationController.forward().then((value) {
      _active
          ? _colorAnimationController.forward()
          : _colorAnimationController.reverse();
      _iconAnimationController.reverse();
    });

    _active = !_active;
  }
}



