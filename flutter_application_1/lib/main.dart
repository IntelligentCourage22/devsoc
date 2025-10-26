import 'package:flutter/material.dart';

void main() => runApp(const CombinedApp());

class CombinedApp extends StatelessWidget {
  const CombinedApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Assignments',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomeScreen(),
    );
  }
}

// home navigation
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final assignments = [
      {
        'title': 'Assignment 1: Hello World',
        'widget': const HelloWorldScreen(),
      },
      {
        'title': 'Assignment 2: Text Input & Display',
        'widget': const TextInputScreen(),
      },
      {
        'title': 'Assignment 3: Dynamic List (Bonus Included)',
        'widget': const DynamicListScreen(),
      },
      {'title': 'Assignment 4: Navigation', 'widget': const FirstNavScreen()},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Assignments')),
      body: ListView.builder(
        itemCount: assignments.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              title: Text(assignments[index]['title'] as String),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        assignments[index]['widget'] as Widget,
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

//assignment 1
class HelloWorldScreen extends StatelessWidget {
  const HelloWorldScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hello World App')),
      body: const Center(
        child: Text(
          'Hello World',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

//assignment2
class TextInputScreen extends StatefulWidget {
  const TextInputScreen({super.key});

  @override
  State<TextInputScreen> createState() => _TextInputScreenState();
}

class _TextInputScreenState extends State<TextInputScreen> {
  final TextEditingController _controller = TextEditingController();
  String _displayText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Text Input & Display')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(labelText: 'Enter text'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _displayText = _controller.text;
                });
              },
              child: const Text('Show Text'),
            ),
            const SizedBox(height: 20),
            Text(_displayText, style: const TextStyle(fontSize: 22)),
          ],
        ),
      ),
    );
  }
}

//assignment3
class DynamicListScreen extends StatefulWidget {
  const DynamicListScreen({super.key});

  @override
  State<DynamicListScreen> createState() => _DynamicListScreenState();
}

class _DynamicListScreenState extends State<DynamicListScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _items = ['Apple', 'Banana', 'Mango'];

  void _addItem() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        _items.add(text);
        _controller.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dynamic List')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Enter a fruit name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _addItem,
              child: const Text('Add to List'),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        _items[index],
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//assignment 4
class FirstNavScreen extends StatelessWidget {
  const FirstNavScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('First Screen')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SecondNavScreen()),
            );
          },
          child: const Text('Go to Second Screen'),
        ),
      ),
    );
  }
}

class SecondNavScreen extends StatelessWidget {
  const SecondNavScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Second Screen')),
      body: const Center(
        child: Text(
          'Welcome to the Second Screen!',
          style: TextStyle(fontSize: 22),
        ),
      ),
    );
  }
}
