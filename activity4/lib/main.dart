import 'package:flutter/material.dart';

void main() {
  runApp(RefrigerationApp());
}

class RefrigerationApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Refrigeration & AC Services',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/register': (context) => RegistrationScreen(),
        '/home': (context) => HomeScreen(),
        '/about': (context) => AboutScreen(),
        '/contact': (context) => ContactScreen(),
      },
    );
  }
}

// Registration Screen with Form Validation (Activity 3)
class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  String _selectedRole = 'Customer';
  bool _acceptTerms = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
        backgroundColor: Colors.blue[700],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Full Name',
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) => 
                    value!.isEmpty ? 'Name is required' : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                ),
                validator: (value) =>
                    !value!.contains('@') ? 'Invalid email' : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                ),
                validator: (value) =>
                    value!.length < 6 ? 'Password too short' : null,
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedRole,
                decoration: InputDecoration(
                  labelText: 'Role',
                  prefixIcon: Icon(Icons.work),
                ),
                items: ['Customer', 'Technician', 'Admin']
                    .map((role) => DropdownMenuItem(
                          value: role,
                          child: Text(role),
                        ))
                    .toList(),
                onChanged: (value) => setState(() => _selectedRole = value!),
              ),
              SizedBox(height: 16),
              CheckboxListTile(
                title: Text('I accept terms and conditions'),
                value: _acceptTerms,
                onChanged: (value) => setState(() => _acceptTerms = value!),
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate() && _acceptTerms) {
                    // Registration logic here
                    Navigator.pushReplacementNamed(context, '/home');
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[700],
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
                child: Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Login Screen with Form Validation
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.blue[300]!, Colors.blue[900]!],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.ac_unit, size: 80, color: Colors.white),
                  Text(
                    'Refrigeration & AC Services',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 30),
                  Card(
                    elevation: 8,
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              prefixIcon: Icon(Icons.email),
                            ),
                            validator: (value) =>
                                !value!.contains('@') ? 'Invalid email' : null,
                          ),
                          SizedBox(height: 16),
                          TextFormField(
                            controller: _passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              prefixIcon: Icon(Icons.lock),
                            ),
                            validator: (value) =>
                                value!.isEmpty ? 'Password required' : null,
                          ),
                          SizedBox(height: 24),
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                Navigator.pushReplacementNamed(context, '/home');
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue[700],
                              padding: EdgeInsets.symmetric(
                                  horizontal: 50, vertical: 15),
                            ),
                            child: Text('Login'),
                          ),
                          TextButton(
                            onPressed: () =>
                                Navigator.pushNamed(context, '/register'),
                            child: Text('Create an Account'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  late TabController _tabController;

  final List<Widget> _pages = [
    ServicesTab(),
    AppointmentsTab(),
    MaintenanceTab(),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Refrigeration & AC Services'),
        backgroundColor: Colors.blue[700],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.ac_unit), text: 'Services'),
            Tab(icon: Icon(Icons.calendar_today), text: 'Appointments'),
            Tab(icon: Icon(Icons.build), text: 'Maintenance'),
          ],
        ),
      ),
      drawer: AppDrawer(),
      body: TabBarView(
        controller: _tabController,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_repair_service),
            label: 'Services',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule),
            label: 'Schedule',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.engineering),
            label: 'Maintenance',
          ),
        ],
      ),
    );
  }
}

class ServicesTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        ServiceCard(
          title: 'AC Repair & Service',
          icon: Icons.ac_unit,
          description: '24/7 Emergency AC repair and maintenance',
        ),
        ServiceCard(
          title: 'Commercial Refrigeration',
          icon: Icons.kitchen,
          description: 'Commercial cooling systems installation & repair',
        ),
        ServiceCard(
          title: 'Preventive Maintenance',
          icon: Icons.build,
          description: 'Regular system checkups and maintenance',
        ),
      ],
    );
  }
}

class ServiceCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final String description;

  ServiceCard({
    required this.title,
    required this.icon,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.only(bottom: 16),
      child: ListTile(
        leading: Icon(icon, size: 40, color: Colors.blue[700]),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(description),
        trailing: ElevatedButton(
          onPressed: () {},
          child: Text('Book Now'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue[700], // Changed from primary
          ),
        ),
      ),
    );
  }
}

// Add these new widget classes
class AppointmentsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Appointments Schedule'));
  }
}

class MaintenanceTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Maintenance Records'));
  }
}

// ---------------- ABOUT PAGE ----------------
class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('About')),
      body: Center(
        child: Text('This is the About Page', style: TextStyle(fontSize: 20)),
      ),
    );
  }
}

// ---------------- CONTACT PAGE ----------------
class ContactScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Contact')),
      body: Center(
        child: Text('This is the Contact Page', style: TextStyle(fontSize: 20)),
      ),
    );
  }
}

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('Rica Mea'),
            accountEmail: Text('ricamea@leones.com'),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person, size: 40, color: Colors.blue),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/home');
            },
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('About'),
            onTap: () {
              Navigator.pushNamed(context, '/about');
            },
          ),
          ListTile(
            leading: Icon(Icons.contact_page),
            title: Text('Contact'),
            onTap: () {
              Navigator.pushNamed(context, '/contact');
            },
          ),
          Spacer(),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ],
      ),
    );
  }
}
