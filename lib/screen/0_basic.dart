import 'package:flutter/material.dart';

class ScoreCounter extends StatefulWidget {
  const ScoreCounter({super.key});

  @override
  State<ScoreCounter> createState() => _ScoreCounterState();
}

class _ScoreCounterState extends State<ScoreCounter> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decreasementCounter() {
    setState(() {
      _counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Score Counter'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Your Score',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text('$_counter',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                  ),
                  onPressed: _incrementCounter,
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                  ),
                  onPressed: _decreasementCounter,
                  child: const Icon(Icons.remove_rounded, color: Colors.white),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
