import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Widget Timer App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TimerScreen(),
    );
  }
}

class TimerScreen extends StatefulWidget {
  @override
  _TimerScreenState createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  late Timer _timer;
  int _counter = 0;
  int _selectedMinutes = 0;
  int _selectedSeconds = 0;

  void _startTimer() {
    int totalTimeInSeconds = (_selectedMinutes * 60) + _selectedSeconds;
    if (totalTimeInSeconds > 0) {
      _counter = totalTimeInSeconds;
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          if (_counter > 0) {
            _counter--;
          } else {
            _timer.cancel();
            _showTimeUpDialog();
          }
        });
      });
    }
  }

  void _stopTimer() {
    _timer.cancel();
  }

  void _resetTimer() {
    _timer.cancel();
    setState(() {
      _counter = 0;
    });
  }

  void _showTimeUpDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Waktu Telah Habis!"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Widget Timer By Firmansyah(222410102058)', textAlign: TextAlign.center),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Atur Waktu (menit): '),
                SizedBox(width: 10.0),
                Container(
                  width: 100.0,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        _selectedMinutes = int.tryParse(value) ?? 0;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Menit',
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Atur Waktu (detik): '),
                SizedBox(width: 10.0),
                Container(
                  width: 100.0,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        _selectedSeconds = int.tryParse(value) ?? 0;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Detik',
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Text(
              'Waktu: ${(_counter ~/ 60).toString().padLeft(2, '0')}:${(_counter % 60).toString().padLeft(2, '0')}',
              style: TextStyle(fontSize: 48.0),
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: _startTimer,
                  child: Text('Start'),
                ),
                SizedBox(width: 20.0),
                ElevatedButton(
                  onPressed: _stopTimer,
                  child: Text('Stop'),
                ),
                SizedBox(width: 20.0),
                ElevatedButton(
                  onPressed: _resetTimer,
                  child: Text('Reset'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
