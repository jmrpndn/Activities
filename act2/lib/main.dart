import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void main() {
  runApp(const CompleteServiceApp());
}

// ============================================================================
// MAIN APP - Demonstrates all Activity 1 and Activity 2 requirements
// ============================================================================

class CompleteServiceApp extends StatelessWidget {
  const CompleteServiceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Complete Service App - All Activities',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MainScreen(),
      routes: {
        '/hello-stateless': (context) => const HelloWorldStateless(),
        '/hello-stateful': (context) => const HelloWorldStateful(),
        '/services': (context) => const ServicesScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/layout-demo': (context) => const LayoutDemoScreen(),
      },
    );
  }
}

// ============================================================================
// MAIN SCREEN - Activity 1, Task 6: Navigation with Drawer and BottomNavigationBar
// ============================================================================

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const ServicesScreen(),
    const ProfileScreen(),
    const LayoutDemoScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ServiceHub - Complete Demo'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: _screens[_currentIndex],
      drawer: _buildDrawer(),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  // Activity 1, Task 6: Drawer navigation
  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.deepPurple),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.apps, size: 30, color: Colors.deepPurple),
                ),
                SizedBox(height: 10),
                Text(
                  'ServiceHub',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Complete Demo App',
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              setState(() => _currentIndex = 0);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.build),
            title: const Text('Services'),
            onTap: () {
              setState(() => _currentIndex = 1);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profile'),
            onTap: () {
              setState(() => _currentIndex = 2);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.grid_view),
            title: const Text('Layout Demo'),
            onTap: () {
              setState(() => _currentIndex = 3);
              Navigator.pop(context);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.waving_hand),
            title: const Text('Hello World - Stateless'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/hello-stateless');
            },
          ),
          ListTile(
            leading: const Icon(Icons.countertops),
            title: const Text('Hello World - Stateful'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/hello-stateful');
            },
          ),
        ],
      ),
    );
  }

  // Activity 1, Task 6: BottomNavigationBar
  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.deepPurple,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white70,
      currentIndex: _currentIndex,
      onTap: (index) => setState(() => _currentIndex = index),
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.build), label: 'Services'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        BottomNavigationBarItem(
          icon: Icon(Icons.grid_view),
          label: 'Layout Demo',
        ),
      ],
    );
  }
}

// ============================================================================
// HOME SCREEN - Demonstrates Activity 2, Tasks 1-2
// ============================================================================

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Activity 2, Task 1: Three Text widgets in a Row with equal spacing
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                Text(
                  'Discover',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Services',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Near You',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),

          // Activity 2, Task 2: Two buttons in a Column, centered vertically and horizontally
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomButton(
                      text: 'View Services',
                      onPressed: () =>
                          Navigator.pushNamed(context, '/services'),
                      backgroundColor: Colors.deepPurple,
                      width: 150,
                    ),
                    CustomButton(
                      text: 'My Profile',
                      onPressed: () => Navigator.pushNamed(context, '/profile'),
                      backgroundColor: Colors.green,
                      width: 150,
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Service cards grid
          Padding(
            padding: const EdgeInsets.all(16),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 0.8,
              ),
              itemCount: 4,
              itemBuilder: (context, index) {
                final services = [
                  {'title': 'House Cleaning', 'price': 50, 'rating': 4.8},
                  {'title': 'Plumbing Repair', 'price': 75, 'rating': 4.6},
                  {'title': 'Tutoring', 'price': 30, 'rating': 4.9},
                  {'title': 'Garden Care', 'price': 40, 'rating': 4.7},
                ];
                return ServiceCard(service: services[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// HELLO WORLD STATELESS - Activity 1, Task 2
// ============================================================================

class HelloWorldStateless extends StatelessWidget {
  const HelloWorldStateless({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hello World - Stateless'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.waving_hand, size: 80, color: Colors.deepPurple),
            SizedBox(height: 20),
            Text(
              'Hello World!',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'This is a StatelessWidget',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// HELLO WORLD STATEFUL - Activity 1, Task 3
// ============================================================================

class HelloWorldStateful extends StatefulWidget {
  const HelloWorldStateful({super.key});

  @override
  State<HelloWorldStateful> createState() => _HelloWorldStatefulState();
}

class _HelloWorldStatefulState extends State<HelloWorldStateful> {
  int _counter = 0;

  void _incrementCounter() => setState(() => _counter++);
  void _decrementCounter() => setState(() => _counter > 0 ? _counter-- : null);
  void _resetCounter() => setState(() => _counter = 0);

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

// ============================================================================
// SERVICES SCREEN - Activity 1, Task 5: Material Design and Cupertino Widgets
// ============================================================================

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({super.key});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  bool _useMaterialDesign = true;

  @override
  Widget build(BuildContext context) {
    if (_useMaterialDesign) {
      return _buildMaterialDesign();
    } else {
      return _buildCupertinoDesign();
    }
  }

  Widget _buildMaterialDesign() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Services - Material Design'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.apple),
            onPressed: () => setState(() => _useMaterialDesign = false),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Material Design Services',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          ...List.generate(4, (index) {
            final services = [
              {
                'title': 'House Cleaning',
                'price': 50,
                'rating': 4.8,
                'description': 'Professional cleaning services',
              },
              {
                'title': 'Plumbing Repair',
                'price': 75,
                'rating': 4.6,
                'description': 'Expert plumbing maintenance',
              },
              {
                'title': 'Tutoring',
                'price': 30,
                'rating': 4.9,
                'description': 'Personal tutoring services',
              },
              {
                'title': 'Garden Care',
                'price': 40,
                'rating': 4.7,
                'description': 'Garden maintenance services',
              },
            ];
            return ServiceCard(service: services[index]);
          }),
        ],
      ),
    );
  }

  Widget _buildCupertinoDesign() {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Services - Cupertino Design'),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Icon(CupertinoIcons.phone),
          onPressed: () => setState(() => _useMaterialDesign = true),
        ),
      ),
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text(
              'Cupertino Design Services',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ...List.generate(4, (index) {
              final services = [
                {
                  'title': 'House Cleaning',
                  'price': 50,
                  'rating': 4.8,
                  'description': 'Professional cleaning services',
                },
                {
                  'title': 'Plumbing Repair',
                  'price': 75,
                  'rating': 4.6,
                  'description': 'Expert plumbing maintenance',
                },
                {
                  'title': 'Tutoring',
                  'price': 30,
                  'rating': 4.9,
                  'description': 'Personal tutoring services',
                },
                {
                  'title': 'Garden Care',
                  'price': 40,
                  'rating': 4.7,
                  'description': 'Garden maintenance services',
                },
              ];
              return CupertinoServiceCard(service: services[index]);
            }),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// PROFILE SCREEN - Activity 2, Tasks 3-6, 9
// ============================================================================

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Activity 2, Task 4: Profile card layout with Row and Column
          const ProfileCard(),

          // Activity 2, Task 3: Container with padding, margin, and background color
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.deepPurple.withOpacity(0.1),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.deepPurple, width: 2),
            ),
            child: const Column(
              children: [
                Text(
                  'Profile Information',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                ),
                SizedBox(height: 16),
                Text('Name: John Doe'),
                Text('Email: john.doe@example.com'),
                Text('Bio: Service provider with 5+ years experience'),
              ],
            ),
          ),

          // Activity 2, Task 5: Responsive layout using Expanded
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Column(
                      children: [
                        Icon(Icons.star, color: Colors.blue, size: 30),
                        SizedBox(height: 8),
                        Text(
                          'Rating',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text('4.8'),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Column(
                      children: [
                        Icon(Icons.work, color: Colors.green, size: 30),
                        SizedBox(height: 8),
                        Text(
                          'Services',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text('12'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Activity 2, Task 6: Navigation bar using Row with icons
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildNavItem(Icons.edit, 'Edit'),
                _buildNavItem(Icons.settings, 'Settings'),
                _buildNavItem(Icons.help, 'Help'),
                _buildNavItem(Icons.logout, 'Logout'),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Activity 2, Task 9: Chat bubble UI
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Recent Messages',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                ChatBubble(
                  message: 'Hello! How can I help you today?',
                  isMe: false,
                  timestamp: '2:30 PM',
                ),
                ChatBubble(
                  message: 'I need help with my plumbing issue.',
                  isMe: true,
                  timestamp: '2:32 PM',
                ),
                ChatBubble(
                  message: 'I can schedule a visit for tomorrow morning.',
                  isMe: false,
                  timestamp: '2:35 PM',
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Custom buttons using reusable widget
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomButton(
                text: 'Edit Profile',
                onPressed: () {},
                backgroundColor: Colors.deepPurple,
                width: 120,
              ),
              CustomButton(
                text: 'Settings',
                onPressed: () {},
                backgroundColor: Colors.green,
                width: 120,
              ),
            ],
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.deepPurple),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Colors.deepPurple),
        ),
      ],
    );
  }
}

// ============================================================================
// LAYOUT DEMO SCREEN - Activity 2, Tasks 7-8, 10
// ============================================================================

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
        onTap: (index) => setState(() => _selectedIndex = index),
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

  // Activity 2, Task 7: Stack layout with background and floating button
  Widget _buildStackLayout() {
    return Stack(
      children: [
        SizedBox.expand(
          child: Image.asset('web/favicon.png', fit: BoxFit.cover),
        ),
        Positioned(
          bottom: 50,
          right: 20,
          child: FloatingActionButton.extended(
            onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Floating button pressed!')),
            ),
            backgroundColor: Colors.white,
            foregroundColor: Colors.deepPurple,
            icon: const Icon(Icons.add),
            label: const Text('Action'),
          ),
        ),
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

  // Activity 2, Task 8: Flexible inside a Column
  Widget _buildFlexibleLayout() {
    return Column(
      children: [
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

  // Activity 2, Task 10: Row and Column grid layout
  Widget _buildGridLayout() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: _buildGridItem(Colors.purple, Icons.home, 'Home'),
                ),
                Expanded(
                  child: _buildGridItem(Colors.blue, Icons.work, 'Work'),
                ),
                Expanded(
                  child: _buildGridItem(Colors.green, Icons.school, 'School'),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: _buildGridItem(
                    Colors.orange,
                    Icons.favorite,
                    'Health',
                  ),
                ),
                Expanded(
                  child: _buildGridItem(
                    Colors.red,
                    Icons.shopping_cart,
                    'Shopping',
                  ),
                ),
                Expanded(
                  child: _buildGridItem(
                    Colors.teal,
                    Icons.travel_explore,
                    'Travel',
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: _buildGridItem(
                    Colors.indigo,
                    Icons.music_note,
                    'Music',
                  ),
                ),
                Expanded(
                  child: _buildGridItem(
                    Colors.pink,
                    Icons.camera_alt,
                    'Photos',
                  ),
                ),
                Expanded(
                  child: _buildGridItem(
                    Colors.brown,
                    Icons.settings,
                    'Settings',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGridItem(Color color, IconData icon, String label) {
    return Container(
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 40),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// CUSTOM WIDGETS - Activity 1, Task 4: Reusable button widget
// ============================================================================

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final double? width;
  final double? height;
  final bool useCupertino;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.width,
    this.height,
    this.useCupertino = false,
  });

  @override
  Widget build(BuildContext context) {
    if (useCupertino) {
      return SizedBox(
        width: width,
        height: height ?? 50,
        child: CupertinoButton(
          onPressed: onPressed,
          color: backgroundColor ?? CupertinoColors.systemBlue,
          child: Text(
            text,
            style: TextStyle(
              color: textColor ?? CupertinoColors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );
    }

    return SizedBox(
      width: width,
      height: height ?? 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? Theme.of(context).primaryColor,
          foregroundColor: textColor ?? Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
      ),
    );
  }
}

class ServiceCard extends StatelessWidget {
  final Map<String, dynamic> service;

  const ServiceCard({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () => ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Selected: ${service['title']}')),
        ),
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 120,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
              ),
              clipBehavior: Clip.antiAlias,
              child: Image.asset('web/icons/Icon-512.png', fit: BoxFit.cover),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    service['title'],
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    service['description'],
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${service['price']}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            service['rating'].toString(),
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CupertinoServiceCard extends StatelessWidget {
  final Map<String, dynamic> service;

  const CupertinoServiceCard({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: CupertinoColors.systemBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: CupertinoColors.separator),
      ),
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Selected: ${service['title']}')),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 120,
              width: double.infinity,
              decoration: BoxDecoration(
                color: CupertinoColors.systemGrey5,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
              ),
              clipBehavior: Clip.antiAlias,
              child: Image.asset('web/icons/Icon-512.png', fit: BoxFit.cover),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    service['title'],
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    service['description'],
                    style: TextStyle(
                      fontSize: 14,
                      color: CupertinoColors.systemGrey,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${service['price']}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: CupertinoColors.systemGreen,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(
                            CupertinoIcons.star_fill,
                            color: CupertinoColors.systemYellow,
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            service['rating'].toString(),
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 40,
              backgroundColor: Colors.grey,
              child: Icon(Icons.person, size: 40, color: Colors.white),
            ),
            const SizedBox(width: 16),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'John Doe',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'john.doe@example.com',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Service provider with 5+ years experience',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isMe;
  final String? timestamp;

  const ChatBubble({
    super.key,
    required this.message,
    this.isMe = true,
    this.timestamp,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      child: Row(
        mainAxisAlignment: isMe
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          if (!isMe) const SizedBox(width: 50),
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: isMe ? Colors.blue : Colors.grey[300],
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(20),
                  topRight: const Radius.circular(20),
                  bottomLeft: Radius.circular(isMe ? 20 : 4),
                  bottomRight: Radius.circular(isMe ? 4 : 20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message,
                    style: TextStyle(
                      color: isMe ? Colors.white : Colors.black,
                      fontSize: 16,
                    ),
                  ),
                  if (timestamp != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      timestamp!,
                      style: TextStyle(
                        color: isMe ? Colors.white70 : Colors.grey[600],
                        fontSize: 12,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          if (isMe) const SizedBox(width: 50),
        ],
      ),
    );
  }
}

// ============================================================================
// WIDGET TREE DOCUMENTATION - Activity 1, Task 7
// ============================================================================

/*
WIDGET TREE HIERARCHY:

CompleteServiceApp (MaterialApp)
├── MainScreen (StatefulWidget)
│   ├── Scaffold
│   │   ├── AppBar
│   │   │   ├── Text (title)
│   │   │   └── IconButton (actions)
│   │   ├── body: _screens[_currentIndex]
│   │   │   ├── HomeScreen
│   │   │   ├── ServicesScreen
│   │   │   ├── ProfileScreen
│   │   │   └── LayoutDemoScreen
│   │   ├── drawer: Drawer
│   │   │   └── ListView
│   │   │       ├── DrawerHeader
│   │   │       └── ListTile (multiple)
│   │   └── bottomNavigationBar: BottomNavigationBar
│   │       └── BottomNavigationBarItem (4 items)
│   └── State Management
│       └── _currentIndex (int)

HomeScreen (StatelessWidget)
├── SingleChildScrollView
│   └── Column
│       ├── Container (Row with 3 Text widgets - Activity 2, Task 1)
│       ├── Container (Column with 2 buttons - Activity 2, Task 2)
│       └── GridView.builder
│           └── ServiceCard (multiple)

ServiceCard (StatelessWidget) - Activity 1, Task 8: Refactored widget
├── Card
│   └── InkWell
│       └── Column
│           ├── Container (image placeholder)
│           └── Padding
│               └── Column
│                   ├── Text (title)
│                   ├── Text (description)
│                   └── Row
│                       ├── Text (price)
│                       └── Row (rating)

CustomButton (StatelessWidget) - Activity 1, Task 4: Reusable widget
├── SizedBox
│   └── ElevatedButton (Material) OR CupertinoButton (Cupertino)
│       └── Text

This hierarchy demonstrates:
- Parent-child relationships between widgets
- State management in StatefulWidgets
- Reusable components (CustomButton, ServiceCard)
- Navigation structure (Drawer, BottomNavigationBar)
- Layout patterns (Row, Column, Stack, Grid)
- Platform-specific widgets (Material vs Cupertino)
*/
