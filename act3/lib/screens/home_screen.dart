import 'package:flutter/material.dart';
import 'username_form_screen.dart';
import 'login_form_screen.dart';
import 'mixed_inputs_screen.dart';
import 'registration_form_screen.dart';
import 'dropdown_form_screen.dart';
import 'datetime_picker_screen.dart';
import 'controller_form_screen.dart';
import 'data_collection_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Refrigeration & AC Services'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Welcome to Refrigeration & AC Services',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            const Text(
              'Choose a form to demonstrate different input handling techniques:',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _buildFormCard(
                    context,
                    'Username Form',
                    'Simple TextFormField for username',
                    Icons.person,
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const UsernameFormScreen(),
                      ),
                    ),
                  ),
                  _buildFormCard(
                    context,
                    'Login Form',
                    'Email and password with validation',
                    Icons.login,
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginFormScreen(),
                      ),
                    ),
                  ),
                  _buildFormCard(
                    context,
                    'Mixed Inputs',
                    'TextField, Checkbox, and Switch',
                    Icons.settings_input_component,
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MixedInputsScreen(),
                      ),
                    ),
                  ),
                  _buildFormCard(
                    context,
                    'Registration',
                    'Complete registration form',
                    Icons.app_registration,
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegistrationFormScreen(),
                      ),
                    ),
                  ),
                  _buildFormCard(
                    context,
                    'Role Selection',
                    'Dropdown menu for user roles',
                    Icons.admin_panel_settings,
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DropdownFormScreen(),
                      ),
                    ),
                  ),
                  _buildFormCard(
                    context,
                    'Date & Time',
                    'Date and time picker inputs',
                    Icons.schedule,
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DateTimePickerScreen(),
                      ),
                    ),
                  ),
                  _buildFormCard(
                    context,
                    'Controller Demo',
                    'TextController capture and display',
                    Icons.text_fields,
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ControllerFormScreen(),
                      ),
                    ),
                  ),
                  _buildFormCard(
                    context,
                    'Data Collection',
                    'Save and display form submissions',
                    Icons.data_usage,
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DataCollectionScreen(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormCard(
    BuildContext context,
    String title,
    String description,
    IconData icon,
    VoidCallback onTap,
  ) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 48,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
