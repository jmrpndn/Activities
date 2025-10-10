import 'package:flutter/material.dart';

/// Task 3: Hello World app converted to StatefulWidget with counter button
class HelloWorldStateful extends StatefulWidget {
  const HelloWorldStateful({super.key});

  @override
  State<HelloWorldStateful> createState() => _HelloWorldStatefulState();
}

class _HelloWorldStatefulState extends State<HelloWorldStateful> {
  int _counter = 0;
  String _message = 'Welcome to our Service Booking App!';

  void _incrementCounter() {
    setState(() {
      _counter++;
      if (_counter == 1) {
        _message = 'Great! You\'re exploring our services.';
      } else if (_counter == 5) {
        _message = 'You seem interested! Check out our services.';
      } else if (_counter == 10) {
        _message = 'Wow! You\'re really engaged. Ready to book?';
      } else if (_counter > 10) {
        _message = 'Amazing! Let\'s book your service now!';
      }
    });
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
      _message = 'Welcome to our Service Booking App!';
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
            Icon(
              Icons.waving_hand,
              size: 80,
              color: Colors.deepPurple.withOpacity(0.8),
            ),
            const SizedBox(height: 20),
            const Text(
              'Hello, World!',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'This is a StatefulWidget',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 30),
            Text(
              _message,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.deepPurple.withOpacity(0.1),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.deepPurple.withOpacity(0.3)),
              ),
              child: Column(
                children: [
                  const Text(
                    'Button pressed:',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  Text(
                    '$_counter',
                    style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                  const Text(
                    'times',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: _incrementCounter,
                  icon: const Icon(Icons.add),
                  label: const Text('Increment'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                  ),
                ),
                const SizedBox(width: 10),
                OutlinedButton.icon(
                  onPressed: _counter > 0 ? _resetCounter : null,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Reset'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.deepPurple,
                    side: const BorderSide(color: Colors.deepPurple),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
