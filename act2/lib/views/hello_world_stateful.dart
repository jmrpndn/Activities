import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';

class HelloWorldStateful extends StatefulWidget {
  const HelloWorldStateful({super.key});

  @override
  State<HelloWorldStateful> createState() => _HelloWorldStatefulState();
}

class _HelloWorldStatefulState extends State<HelloWorldStateful> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      if (_counter > 0) _counter--;
    });
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hello World - Stateful'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.countertops, size: 80, color: Colors.deepPurple),
            const SizedBox(height: 20),
            const Text(
              'Hello World!',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.deepPurple.withOpacity(0.1),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.deepPurple, width: 2),
              ),
              child: Column(
                children: [
                  const Text(
                    'Counter Value:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '$_counter',
                    style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomButton(
                  text: 'Decrease',
                  onPressed: _decrementCounter,
                  backgroundColor: Colors.red,
                  width: 100,
                ),
                CustomButton(
                  text: 'Reset',
                  onPressed: _resetCounter,
                  backgroundColor: Colors.orange,
                  width: 100,
                ),
                CustomButton(
                  text: 'Increase',
                  onPressed: _incrementCounter,
                  backgroundColor: Colors.green,
                  width: 100,
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'This is a StatefulWidget with state management',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
