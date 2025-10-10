import 'package:flutter/material.dart';

class ControllerFormScreen extends StatefulWidget {
  const ControllerFormScreen({super.key});

  @override
  State<ControllerFormScreen> createState() => _ControllerFormScreenState();
}

class _ControllerFormScreenState extends State<ControllerFormScreen> {
  final _textController = TextEditingController();
  String _capturedText = '';
  List<String> _capturedTexts = [];

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _captureText() {
    setState(() {
      _capturedText = _textController.text;
      if (_capturedText.isNotEmpty) {
        _capturedTexts.add(_capturedText);
      }
    });
    
    if (_capturedText.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Text captured: "$_capturedText"'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  void _clearAll() {
    setState(() {
      _capturedText = '';
      _capturedTexts.clear();
      _textController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Text Controller Demo'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(
              Icons.text_fields,
              size: 60,
              color: Colors.blue,
            ),
            const SizedBox(height: 20),
            const Text(
              'Text Controller Demo',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            const Text(
              'Enter text and press the button to capture and display it',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            
            TextField(
              controller: _textController,
              decoration: InputDecoration(
                labelText: 'Enter Service Notes',
                hintText: 'Type your service notes here...',
                prefixIcon: const Icon(Icons.note),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                    width: 2,
                  ),
                ),
              ),
              maxLines: 3,
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => _captureText(),
            ),
            
            const SizedBox(height: 20),
            
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _captureText,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Capture Text'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _clearAll,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Clear All'),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 30),
            
            if (_capturedText.isNotEmpty) ...[
              const Text(
                'Last Captured Text:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.blue.shade200),
                ),
                child: Text(
                  _capturedText,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 20),
            ],
            
            if (_capturedTexts.isNotEmpty) ...[
              const Text(
                'All Captured Texts:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: _capturedTexts.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Theme.of(context).colorScheme.primary,
                          child: Text(
                            '${index + 1}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        title: Text(_capturedTexts[index]),
                        subtitle: Text('Captured at ${DateTime.now().toString().substring(11, 19)}'),
                      ),
                    );
                  },
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
