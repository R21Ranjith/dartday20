import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Auto Counter App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: CounterPage(),
    );
  }
}

class CounterPage extends StatefulWidget {
  @override
  _CounterPageState createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int counter = 0;
  bool isCounting = false;
  Timer? timer;

  void startCounting() {
    if (!isCounting) {
      isCounting = true;
      timer = Timer.periodic(Duration(seconds: 1), (t) {
        setState(() {
          counter++;
        });
      });
    }
  }

  void stopCounting() {
    if (isCounting) {
      isCounting = false;
      timer?.cancel();
    }
  }

  void resetCounter() {
    stopCounting();
    setState(() {
      counter = 0;
    });
  }

  @override
  void dispose() {
    timer?.cancel(); // clean up when widget is destroyed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Auto Counter")),
      body: Column(
        children: [
          // HEADER
          Container(
            height: 80,
            color: Colors.blue,
            child: Center(
              child: Text(
                "Auto Counter",
                style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          ),

          // BODY
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Count:", style: TextStyle(fontSize: 20)),
                  Text(
                    "$counter",
                    style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold, color: Colors.blue),
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(Icons.play_circle_fill, size: 60, color: Colors.green),
                        onPressed: startCounting,
                      ),
                      SizedBox(width: 20),
                      IconButton(
                        icon: Icon(Icons.stop_circle, size: 60, color: Colors.red),
                        onPressed: stopCounting,
                      ),
                      SizedBox(width: 20),
                      IconButton(
                        icon: Icon(Icons.refresh, size: 60, color: Colors.orange),
                        onPressed: resetCounter,
                      ),
                    ],
                  ),
                  Text("Play = Start, Stop = Pause, Refresh = Reset"),
                ],
              ),
            ),
          ),

          // FOOTER
          Container(
            height: 50,
            color: Colors.black,
            child: Center(
              child: Text("Footer © 2025", style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}
