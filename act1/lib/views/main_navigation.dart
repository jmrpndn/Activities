import 'package:flutter/material.dart';
import 'hello_world_stateless.dart';
import 'hello_world_stateful.dart';
import 'design_comparison.dart';
import 'services_screen.dart';
import 'bookings_screen.dart';

/// Task 6: Main navigation screen with Drawer and BottomNavigationBar
class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  final List<NavigationItem> _navigationItems = [
    NavigationItem(
      title: 'Services',
      icon: Icons.spa,
      screen: const ServicesScreen(),
    ),
    NavigationItem(
      title: 'Bookings',
      icon: Icons.calendar_today,
      screen: const BookingsScreen(),
    ),
    NavigationItem(
      title: 'Design Demo',
      icon: Icons.palette,
      screen: const DesignComparison(),
    ),
  ];

  final List<DrawerItem> _drawerItems = [
    DrawerItem(
      title: 'Hello World Stateless',
      icon: Icons.widgets,
      screen: const HelloWorldStateless(),
    ),
    DrawerItem(
      title: 'Hello World Stateful',
      icon: Icons.touch_app,
      screen: const HelloWorldStateful(),
    ),
    DrawerItem(
      title: 'Services',
      icon: Icons.spa,
      screen: const ServicesScreen(),
    ),
    DrawerItem(
      title: 'Bookings',
      icon: Icons.calendar_today,
      screen: const BookingsScreen(),
    ),
    DrawerItem(
      title: 'Design Comparison',
      icon: Icons.palette,
      screen: const DesignComparison(),
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_navigationItems[_selectedIndex].title),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.info),
            onPressed: () => _showAppInfo(),
          ),
        ],
      ),
      drawer: _buildDrawer(),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() => _selectedIndex = index);
        },
        children: _navigationItems.map((item) => item.screen).toList(),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          _buildDrawerHeader(),
          ..._drawerItems.map(_buildDrawerItem),
          const Divider(),
          _buildDrawerFooter(),
        ],
      ),
    );
  }

  Widget _buildDrawerHeader() {
    return DrawerHeader(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.deepPurple, Colors.purple],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Icon(Icons.spa, size: 48, color: Colors.white),
          SizedBox(height: 8),
          Text(
            'Service Booking App',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Your beauty & wellness partner',
            style: TextStyle(color: Colors.white70, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(DrawerItem item) {
    return ListTile(
      leading: Icon(item.icon),
      title: Text(item.title),
      onTap: () {
        Navigator.pop(context); // Close drawer
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => item.screen),
        );
      },
    );
  }

  Widget _buildDrawerFooter() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'About This App',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'This app demonstrates Flutter concepts including:',
            style: TextStyle(fontSize: 12),
          ),
          const SizedBox(height: 4),
          const Text(
            '• StatelessWidget vs StatefulWidget\n'
            '• Custom reusable widgets\n'
            '• Material Design vs Cupertino\n'
            '• Navigation patterns\n'
            '• Third-party packages\n'
            '• Service architecture',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: (index) {
        setState(() => _selectedIndex = index);
        _pageController.animateToPage(
          index,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      },
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.deepPurple,
      unselectedItemColor: Colors.grey,
      items: _navigationItems.map((item) {
        return BottomNavigationBarItem(
          icon: Icon(item.icon),
          label: item.title,
        );
      }).toList(),
    );
  }

  Widget _buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () => _showQuickActions(),
      backgroundColor: Colors.deepPurple,
      child: const Icon(Icons.add, color: Colors.white),
    );
  }

  void _showQuickActions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Quick Actions',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.spa),
              title: const Text('Browse Services'),
              onTap: () {
                Navigator.pop(context);
                _navigateToIndex(0);
              },
            ),
            ListTile(
              leading: const Icon(Icons.calendar_today),
              title: const Text('View Bookings'),
              onTap: () {
                Navigator.pop(context);
                _navigateToIndex(1);
              },
            ),
            ListTile(
              leading: const Icon(Icons.palette),
              title: const Text('Design Demo'),
              onTap: () {
                Navigator.pop(context);
                _navigateToIndex(2);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToIndex(int index) {
    setState(() => _selectedIndex = index);
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _showAppInfo() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.info, color: Colors.deepPurple),
            SizedBox(width: 8),
            Text('App Information'),
          ],
        ),
        content: const Text(
          'This Flutter app demonstrates various concepts:\n\n'
          '• Project organization (models, views, widgets, services)\n'
          '• StatelessWidget vs StatefulWidget\n'
          '• Custom reusable widgets\n'
          '• Material Design vs Cupertino\n'
          '• Navigation with Drawer and BottomNavigationBar\n'
          '• Third-party packages (flutter_staggered_grid_view)\n'
          '• Service booking functionality',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}

class NavigationItem {
  final String title;
  final IconData icon;
  final Widget screen;

  NavigationItem({
    required this.title,
    required this.icon,
    required this.screen,
  });
}

class DrawerItem {
  final String title;
  final IconData icon;
  final Widget screen;

  DrawerItem({required this.title, required this.icon, required this.screen});
}
