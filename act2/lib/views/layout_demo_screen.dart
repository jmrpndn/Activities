import 'package:flutter/material.dart';

class LayoutDemoScreen extends StatefulWidget {
  const LayoutDemoScreen({super.key});

  @override
  State<LayoutDemoScreen> createState() => _LayoutDemoScreenState();
}

class _LayoutDemoScreenState extends State<LayoutDemoScreen> {
  int _selectedIndex = 0;
  bool _isPortrait = true;

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    _isPortrait = orientation == Orientation.portrait;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Layout Demo'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: _buildSelectedLayout(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.deepPurple,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.grid_view), label: 'Stack'),
          BottomNavigationBarItem(
            icon: Icon(Icons.view_column),
            label: 'Flexible',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.grid_3x3), label: 'Grid'),
        ],
      ),
    );
  }

  Widget _buildSelectedLayout() {
    switch (_selectedIndex) {
      case 0:
        return _buildStackLayout();
      case 1:
        return _buildFlexibleLayout();
      case 2:
        return _buildGridLayout();
      default:
        return _buildStackLayout();
    }
  }

  // Activity 2, Task 7: Stack layout with background image and floating button overlay
  Widget _buildStackLayout() {
    return Stack(
      children: [
        // Background image
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.deepPurple.withOpacity(0.8),
                Colors.blue.withOpacity(0.6),
                Colors.green.withOpacity(0.4),
              ],
            ),
          ),
          child: const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.image, size: 100, color: Colors.white),
                SizedBox(height: 20),
                Text(
                  'Background Image',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),

        // Floating button overlay
        Positioned(
          bottom: 50,
          right: 20,
          child: FloatingActionButton.extended(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Floating button pressed!')),
              );
            },
            backgroundColor: Colors.white,
            foregroundColor: Colors.deepPurple,
            icon: const Icon(Icons.add),
            label: const Text('Action'),
          ),
        ),

        // Additional overlay elements
        Positioned(
          top: 100,
          left: 20,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Stack Layout',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text('Background + Overlays'),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Activity 2, Task 8: Flexible inside a Column to resize widgets dynamically
  Widget _buildFlexibleLayout() {
    return Column(
      children: [
        // Fixed height container
        Container(
          height: 100,
          width: double.infinity,
          color: Colors.blue,
          child: const Center(
            child: Text(
              'Fixed Height Container',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),

        // Flexible container that takes remaining space
        Flexible(
          flex: _isPortrait ? 2 : 1,
          child: Container(
            width: double.infinity,
            color: Colors.green,
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.expand, size: 50, color: Colors.white),
                  SizedBox(height: 10),
                  Text(
                    'Flexible Container',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Resizes with orientation',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
        ),

        // Another flexible container
        Flexible(
          flex: 1,
          child: Container(
            width: double.infinity,
            color: Colors.orange,
            child: const Center(
              child: Text(
                'Another Flexible Container',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),

        // Fixed height container at bottom
        Container(
          height: 80,
          width: double.infinity,
          color: Colors.red,
          child: const Center(
            child: Text(
              'Fixed Bottom Container',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Activity 2, Task 10: Row and Column in same widget tree to form grid-like layout
  Widget _buildGridLayout() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // First row
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.purple,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.home, color: Colors.white, size: 40),
                          SizedBox(height: 8),
                          Text(
                            'Home',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.work, color: Colors.white, size: 40),
                          SizedBox(height: 8),
                          Text(
                            'Work',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.school, color: Colors.white, size: 40),
                          SizedBox(height: 8),
                          Text(
                            'School',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Second row
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.favorite, color: Colors.white, size: 40),
                          SizedBox(height: 8),
                          Text(
                            'Health',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.shopping_cart,
                            color: Colors.white,
                            size: 40,
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Shopping',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.teal,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.travel_explore,
                            color: Colors.white,
                            size: 40,
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Travel',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Third row
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.indigo,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.music_note, color: Colors.white, size: 40),
                          SizedBox(height: 8),
                          Text(
                            'Music',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.pink,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.camera_alt, color: Colors.white, size: 40),
                          SizedBox(height: 8),
                          Text(
                            'Photos',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.brown,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.settings, color: Colors.white, size: 40),
                          SizedBox(height: 8),
                          Text(
                            'Settings',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
