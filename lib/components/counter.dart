import 'package:flutter/material.dart';

class Counter extends StatefulWidget {
  int counter = 0;

  Counter({Key key, this.counter}) : super(key: key);

  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(widget.counter.toString()),
    );
  }
}
