import 'package:flutter/material.dart';

void main() {
  runApp(const RefrigerationACApp());
}

class RefrigerationACApp extends StatelessWidget {
  const RefrigerationACApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CoolTech Services',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MainScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const UsernameForm(),
    const LoginForm(),
    const MixedInputForm(),
    const RegistrationForm(),
    const ServiceRequestForm(),
    const DataCollectionForm(),
  ];

  final List<String> _screenTitles = [
    'Username Form',
    'Login Form',
    'Mixed Inputs',
    'Registration',
    'Service Request',
    'Data Collection',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_screenTitles[_selectedIndex]),
        backgroundColor: Colors.blue[800],
        foregroundColor: Colors.white,
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        selectedItemColor: Colors.blue[800],
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Username',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.login),
            label: 'Login',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Mixed',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.app_registration),
            label: 'Register',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.build),
            label: 'Service',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.data_usage),
            label: 'Data',
          ),
        ],
      ),
    );
  }
}

// 1. Simple Username Form
class UsernameForm extends StatefulWidget {
  const UsernameForm({super.key});

  @override
  State<UsernameForm> createState() => _UsernameFormState();
}

class _UsernameFormState extends State<UsernameForm> {
  final _usernameController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Enter Your Username',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: _usernameController,
            decoration: const InputDecoration(
              labelText: 'Username',
              hintText: 'Enter your username',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.person),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (_usernameController.text.isNotEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Welcome, ${_usernameController.text}!'),
                    backgroundColor: Colors.green,
                  ),
                );
              }
            },
            child: const Text('Submit Username'),
          ),
        ],
      ),
    );
  }
}

// 2. Login Form with Validation
class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!value.contains('@')) {
      return 'Email must contain @';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    return null;
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login successful!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Login to CoolTech Services',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              validator: _validateEmail,
              decoration: const InputDecoration(
                labelText: 'Email',
                hintText: 'Enter your email',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              validator: _validatePassword,
              decoration: const InputDecoration(
                labelText: 'Password',
                hintText: 'Enter your password',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitForm,
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}

// 3. Form with Different Input Types
class MixedInputForm extends StatefulWidget {
  const MixedInputForm({super.key});

  @override
  State<MixedInputForm> createState() => _MixedInputFormState();
}

class _MixedInputFormState extends State<MixedInputForm> {
  final _formKey = GlobalKey<FormState>();
  final _textController = TextEditingController();
  final _controller = TextEditingController();
  bool _checkboxValue = false;
  bool _switchValue = false;
  String _displayText = '';

  @override
  void dispose() {
    _textController.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _displayTextFromController() {
    setState(() {
      _displayText = _controller.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Service Preferences Form',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _textController,
              decoration: const InputDecoration(
                labelText: 'Customer Name',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 16),
            CheckboxListTile(
              title: const Text('I agree to receive service notifications'),
              value: _checkboxValue,
              onChanged: (value) {
                setState(() {
                  _checkboxValue = value ?? false;
                });
              },
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              title: const Text('Enable automatic scheduling'),
              subtitle: const Text('Allow system to suggest optimal service times'),
              value: _switchValue,
              onChanged: (value) {
                setState(() {
                  _switchValue = value;
                });
              },
            ),
            const SizedBox(height: 20),
            const Divider(),
            const Text(
              'Text Controller Demo',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Enter service notes',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.note),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _displayTextFromController,
              child: const Text('Display Text'),
            ),
            if (_displayText.isNotEmpty) ...[
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Captured Text: $_displayText',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// 4. Registration Form
class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  String _selectedRole = 'User';

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!value.contains('@')) {
      return 'Email must contain @';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != _passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  void _submitRegistration() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Registration successful for $_selectedRole: ${_nameController.text}'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Register for CoolTech Services',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _nameController,
              validator: _validateName,
              decoration: const InputDecoration(
                labelText: 'Full Name',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              validator: _validateEmail,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              validator: _validatePassword,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _confirmPasswordController,
              obscureText: true,
              validator: _validateConfirmPassword,
              decoration: const InputDecoration(
                labelText: 'Confirm Password',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock_outline),
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _selectedRole,
              decoration: const InputDecoration(
                labelText: 'User Role',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.admin_panel_settings),
              ),
              items: const [
                DropdownMenuItem(value: 'Admin', child: Text('Admin')),
                DropdownMenuItem(value: 'User', child: Text('User')),
                DropdownMenuItem(value: 'Technician', child: Text('Technician')),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedRole = value!;
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitRegistration,
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}

// 5. Service Request Form with Date/Time Pickers
class ServiceRequestForm extends StatefulWidget {
  const ServiceRequestForm({super.key});

  @override
  State<ServiceRequestForm> createState() => _ServiceRequestFormState();
}

class _ServiceRequestFormState extends State<ServiceRequestForm> {
  final _formKey = GlobalKey<FormState>();
  final _customerNameController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  String _serviceType = 'Maintenance';

  @override
  void dispose() {
    _customerNameController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  void _submitServiceRequest() {
    if (_formKey.currentState!.validate() && _selectedDate != null && _selectedTime != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Service request submitted for $_selectedDate at $_selectedTime'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all fields and select date/time'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Schedule Service Request',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _customerNameController,
              validator: (value) => value?.isEmpty == true ? 'Customer name is required' : null,
              decoration: const InputDecoration(
                labelText: 'Customer Name',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _addressController,
              validator: (value) => value?.isEmpty == true ? 'Address is required' : null,
              decoration: const InputDecoration(
                labelText: 'Service Address',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.location_on),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              validator: (value) => value?.isEmpty == true ? 'Phone number is required' : null,
              decoration: const InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.phone),
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _serviceType,
              decoration: const InputDecoration(
                labelText: 'Service Type',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.build),
              ),
              items: const [
                DropdownMenuItem(value: 'Maintenance', child: Text('Maintenance')),
                DropdownMenuItem(value: 'Repair', child: Text('Repair')),
                DropdownMenuItem(value: 'Installation', child: Text('Installation')),
                DropdownMenuItem(value: 'Emergency', child: Text('Emergency')),
              ],
              onChanged: (value) {
                setState(() {
                  _serviceType = value!;
                });
              },
            ),
            const SizedBox(height: 16),
            ListTile(
              title: Text(_selectedDate == null ? 'Select Date' : 'Date: ${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'),
              leading: const Icon(Icons.calendar_today),
              onTap: _selectDate,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              tileColor: Colors.grey[100],
            ),
            const SizedBox(height: 16),
            ListTile(
              title: Text(_selectedTime == null ? 'Select Time' : 'Time: ${_selectedTime!.format(context)}'),
              leading: const Icon(Icons.access_time),
              onTap: _selectTime,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              tileColor: Colors.grey[100],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitServiceRequest,
              child: const Text('Submit Service Request'),
            ),
          ],
        ),
      ),
    );
  }
}

// 6. Data Collection Form with Local Storage
class DataCollectionForm extends StatefulWidget {
  const DataCollectionForm({super.key});

  @override
  State<DataCollectionForm> createState() => _DataCollectionFormState();
}

class _DataCollectionFormState extends State<DataCollectionForm> {
  final _formKey = GlobalKey<FormState>();
  final _customerNameController = TextEditingController();
  final _serviceTypeController = TextEditingController();
  final _issueController = TextEditingController();
  final List<Map<String, String>> _submittedData = [];

  @override
  void dispose() {
    _customerNameController.dispose();
    _serviceTypeController.dispose();
    _issueController.dispose();
    super.dispose();
  }

  void _submitData() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _submittedData.add({
          'customer': _customerNameController.text,
          'service': _serviceTypeController.text,
          'issue': _issueController.text,
          'timestamp': DateTime.now().toString().substring(0, 19),
        });
      });

      // Clear form
      _customerNameController.clear();
      _serviceTypeController.clear();
      _issueController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Data saved successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  void _clearAllData() {
    setState(() {
      _submittedData.clear();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('All data cleared!'),
        backgroundColor: Colors.orange,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Service Data Collection',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _customerNameController,
              validator: (value) => value?.isEmpty == true ? 'Customer name is required' : null,
              decoration: const InputDecoration(
                labelText: 'Customer Name',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _serviceTypeController,
              validator: (value) => value?.isEmpty == true ? 'Service type is required' : null,
              decoration: const InputDecoration(
                labelText: 'Service Type (AC/Refrigeration)',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.ac_unit),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _issueController,
              maxLines: 3,
              validator: (value) => value?.isEmpty == true ? 'Issue description is required' : null,
              decoration: const InputDecoration(
                labelText: 'Issue Description',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.description),
                alignLabelWithHint: true,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitData,
              child: const Text('Save Data'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _clearAllData,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
              child: const Text('Clear All Data'),
            ),
            const SizedBox(height: 20),
            const Divider(),
            const Text(
              'Submitted Data:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            if (_submittedData.isEmpty)
              const Card(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'No data submitted yet. Fill the form above to see entries here.',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
              )
            else
              ...(_submittedData.asMap().entries.map((entry) {
                final index = entry.key;
                final data = entry.value;
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Entry ${index + 1}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text('Customer: ${data['customer']}'),
                        Text('Service: ${data['service']}'),
                        Text('Issue: ${data['issue']}'),
                        Text(
                          'Time: ${data['timestamp']}',
                          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList()),
          ],
        ),
      ),
    );
  }
}
