import 'package:flutter/material.dart';

class MixedInputsScreen extends StatefulWidget {
  const MixedInputsScreen({super.key});

  @override
  State<MixedInputsScreen> createState() => _MixedInputsScreenState();
}

class _MixedInputsScreenState extends State<MixedInputsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();
  
  bool _isEmergencyService = false;
  bool _isWarrantyCovered = false;
  bool _hasExtendedWarranty = false;
  bool _isRegularCustomer = true;
  bool _acceptsMarketing = false;

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Service Request Submitted'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Name: ${_nameController.text}'),
                Text('Address: ${_addressController.text}'),
                Text('Phone: ${_phoneController.text}'),
                Text('Emergency Service: ${_isEmergencyService ? "Yes" : "No"}'),
                Text('Warranty Covered: ${_isWarrantyCovered ? "Yes" : "No"}'),
                Text('Extended Warranty: ${_hasExtendedWarranty ? "Yes" : "No"}'),
                Text('Regular Customer: ${_isRegularCustomer ? "Yes" : "No"}'),
                Text('Marketing Emails: ${_acceptsMarketing ? "Yes" : "No"}'),
              ],
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
      return 'Please enter your name';
    }
    return null;
  }

  String? _validateAddress(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter service address';
    }
    return null;
  }

  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your phone number';
    }
    if (value.length < 10) {
      return 'Phone number must be at least 10 digits';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Service Request Form'),
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
                Icons.settings_input_component,
                size: 60,
                color: Colors.blue,
              ),
              const SizedBox(height: 20),
              const Text(
                'Service Request Form',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              const Text(
                'Fill out the form to request refrigeration or AC service',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              
              // Text Fields
              const Text(
                'Customer Information',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Full Name',
                  hintText: 'Enter your full name',
                  prefixIcon: const Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: _validateName,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 16),
              
              TextFormField(
                controller: _addressController,
                decoration: InputDecoration(
                  labelText: 'Service Address',
                  hintText: 'Enter the service address',
                  prefixIcon: const Icon(Icons.location_on),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: _validateAddress,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 16),
              
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  hintText: 'Enter your phone number',
                  prefixIcon: const Icon(Icons.phone),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: _validatePhone,
                textInputAction: TextInputAction.done,
              ),
              
              const SizedBox(height: 30),
              
              // Checkboxes
              const Text(
                'Service Options',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              
              CheckboxListTile(
                title: const Text('Emergency Service (24/7)'),
                subtitle: const Text('Additional charges may apply'),
                value: _isEmergencyService,
                onChanged: (bool? value) {
                  setState(() {
                    _isEmergencyService = value ?? false;
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
              ),
              
              CheckboxListTile(
                title: const Text('Warranty Covered'),
                subtitle: const Text('Service is covered under warranty'),
                value: _isWarrantyCovered,
                onChanged: (bool? value) {
                  setState(() {
                    _isWarrantyCovered = value ?? false;
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
              ),
              
              CheckboxListTile(
                title: const Text('Extended Warranty'),
                subtitle: const Text('Has extended warranty coverage'),
                value: _hasExtendedWarranty,
                onChanged: (bool? value) {
                  setState(() {
                    _hasExtendedWarranty = value ?? false;
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
              ),
              
              CheckboxListTile(
                title: const Text('Accept Marketing Emails'),
                subtitle: const Text('Receive promotional offers and updates'),
                value: _acceptsMarketing,
                onChanged: (bool? value) {
                  setState(() {
                    _acceptsMarketing = value ?? false;
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
              ),
              
              const SizedBox(height: 20),
              
              // Switches
              const Text(
                'Preferences',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              
              SwitchListTile(
                title: const Text('Regular Customer'),
                subtitle: const Text('Apply regular customer discounts'),
                value: _isRegularCustomer,
                onChanged: (bool value) {
                  setState(() {
                    _isRegularCustomer = value;
                  });
                },
                secondary: const Icon(Icons.star),
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
                    'Submit Service Request',
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
