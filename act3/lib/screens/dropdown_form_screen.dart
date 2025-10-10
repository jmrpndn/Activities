import 'package:flutter/material.dart';

class DropdownFormScreen extends StatefulWidget {
  const DropdownFormScreen({super.key});

  @override
  State<DropdownFormScreen> createState() => _DropdownFormScreenState();
}

class _DropdownFormScreenState extends State<DropdownFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _employeeIdController = TextEditingController();
  
  String? _selectedRole;
  String? _selectedDepartment;
  String? _selectedExperience;
  String? _selectedShift;
  
  final List<String> _roles = [
    'Service Technician',
    'Senior Technician',
    'Installation Specialist',
    'Maintenance Engineer',
    'Customer Service Rep',
    'Team Lead',
    'Manager',
    'Admin'
  ];
  
  final List<String> _departments = [
    'Refrigeration Services',
    'Air Conditioning Services',
    'Commercial HVAC',
    'Residential HVAC',
    'Emergency Services',
    'Installation Team',
    'Maintenance Team',
    'Customer Support'
  ];
  
  final List<String> _experienceLevels = [
    'Entry Level (0-1 years)',
    'Junior (1-3 years)',
    'Mid-level (3-5 years)',
    'Senior (5-10 years)',
    'Expert (10+ years)'
  ];
  
  final List<String> _shifts = [
    'Day Shift (8 AM - 5 PM)',
    'Evening Shift (3 PM - 11 PM)',
    'Night Shift (11 PM - 7 AM)',
    'Weekend Only',
    'On-Call'
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _employeeIdController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Employee Assignment Complete'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Name: ${_nameController.text}'),
                  Text('Employee ID: ${_employeeIdController.text}'),
                  Text('Role: $_selectedRole'),
                  Text('Department: $_selectedDepartment'),
                  Text('Experience: $_selectedExperience'),
                  Text('Shift: $_selectedShift'),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter employee name';
    }
    return null;
  }

  String? _validateEmployeeId(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter employee ID';
    }
    if (value.length < 3) {
      return 'Employee ID must be at least 3 characters';
    }
    return null;
  }

  String? _validateDropdown(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return 'Please select $fieldName';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee Role Assignment'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(
                Icons.admin_panel_settings,
                size: 60,
                color: Colors.blue,
              ),
              const SizedBox(height: 20),
              const Text(
                'Employee Role Assignment',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              const Text(
                'Assign roles and responsibilities for refrigeration & AC services',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              
              // Name Field
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Employee Name',
                  hintText: 'Enter full name',
                  prefixIcon: const Icon(Icons.person),
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
                validator: _validateName,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 20),
              
              // Employee ID Field
              TextFormField(
                controller: _employeeIdController,
                decoration: InputDecoration(
                  labelText: 'Employee ID',
                  hintText: 'Enter employee ID',
                  prefixIcon: const Icon(Icons.badge),
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
                validator: _validateEmployeeId,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 20),
              
              // Role Dropdown
              DropdownButtonFormField<String>(
                value: _selectedRole,
                decoration: InputDecoration(
                  labelText: 'Select Role',
                  prefixIcon: const Icon(Icons.work),
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
                items: _roles.map((String role) {
                  return DropdownMenuItem<String>(
                    value: role,
                    child: Text(role),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedRole = newValue;
                  });
                },
                validator: (value) => _validateDropdown(value, 'a role'),
              ),
              const SizedBox(height: 20),
              
              // Department Dropdown
              DropdownButtonFormField<String>(
                value: _selectedDepartment,
                decoration: InputDecoration(
                  labelText: 'Select Department',
                  prefixIcon: const Icon(Icons.business),
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
                items: _departments.map((String department) {
                  return DropdownMenuItem<String>(
                    value: department,
                    child: Text(department),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedDepartment = newValue;
                  });
                },
                validator: (value) => _validateDropdown(value, 'a department'),
              ),
              const SizedBox(height: 20),
              
              // Experience Level Dropdown
              DropdownButtonFormField<String>(
                value: _selectedExperience,
                decoration: InputDecoration(
                  labelText: 'Experience Level',
                  prefixIcon: const Icon(Icons.trending_up),
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
                items: _experienceLevels.map((String experience) {
                  return DropdownMenuItem<String>(
                    value: experience,
                    child: Text(experience),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedExperience = newValue;
                  });
                },
                validator: (value) => _validateDropdown(value, 'experience level'),
              ),
              const SizedBox(height: 20),
              
              // Shift Dropdown
              DropdownButtonFormField<String>(
                value: _selectedShift,
                decoration: InputDecoration(
                  labelText: 'Work Shift',
                  prefixIcon: const Icon(Icons.schedule),
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
                items: _shifts.map((String shift) {
                  return DropdownMenuItem<String>(
                    value: shift,
                    child: Text(shift),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedShift = newValue;
                  });
                },
                validator: (value) => _validateDropdown(value, 'a work shift'),
              ),
              
              const SizedBox(height: 30),
              
              // Submit Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 3,
                  ),
                  child: const Text(
                    'Assign Role',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
