import 'package:daily_planner/components/counter.dart';
import 'package:flutter/material.dart';

class CounterScreen extends StatefulWidget {
  @override
  _CounterScreenState createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  int _counter = 0;

  initState() {
    super.initState();
    startCounter(); // fetchData
  }

  startCounter() async {
    _counter = await init(); // http.get()
    setState(() {});
  }

  init() async {
    return 100;
  }

  increase() {
    _counter++;
    this.setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: EdgeInsets.all(50),
          child: Column(
            children: [
              Counter(counter: _counter),
              IconButton(
                icon: Icon(Icons.ac_unit),
                onPressed: () => increase(),
              )
            ],
          )),
    );
  }
}
