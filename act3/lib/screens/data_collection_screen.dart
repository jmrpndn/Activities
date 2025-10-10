import 'package:flutter/material.dart';

class ServiceRequest {
  final String customerName;
  final String phoneNumber;
  final String address;
  final String serviceType;
  final String description;
  final String priority;
  final DateTime timestamp;

  ServiceRequest({
    required this.customerName,
    required this.phoneNumber,
    required this.address,
    required this.serviceType,
    required this.description,
    required this.priority,
    required this.timestamp,
  });
}

class DataCollectionScreen extends StatefulWidget {
  const DataCollectionScreen({super.key});

  @override
  State<DataCollectionScreen> createState() => _DataCollectionScreenState();
}

class _DataCollectionScreenState extends State<DataCollectionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _descriptionController = TextEditingController();
  
  String _selectedServiceType = 'Refrigeration Repair';
  String _selectedPriority = 'Medium';
  
  List<ServiceRequest> _serviceRequests = [];
  
  final List<String> _serviceTypes = [
    'Refrigeration Repair',
    'AC Repair',
    'AC Installation',
    'Refrigeration Installation',
    'Maintenance Service',
    'Emergency Repair',
    'System Upgrade',
    'Warranty Service'
  ];
  
  final List<String> _priorities = [
    'Low',
    'Medium',
    'High',
    'Emergency'
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final newRequest = ServiceRequest(
        customerName: _nameController.text,
        phoneNumber: _phoneController.text,
        address: _addressController.text,
        serviceType: _selectedServiceType,
        description: _descriptionController.text,
        priority: _selectedPriority,
        timestamp: DateTime.now(),
      );
      
      setState(() {
        _serviceRequests.insert(0, newRequest); // Add to beginning of list
      });
      
      // Clear form
      _nameController.clear();
      _phoneController.clear();
      _addressController.clear();
      _descriptionController.clear();
      _selectedServiceType = 'Refrigeration Repair';
      _selectedPriority = 'Medium';
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Service request added successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  void _clearAllRequests() {
    setState(() {
      _serviceRequests.clear();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('All service requests cleared'),
        backgroundColor: Colors.orange,
      ),
    );
  }

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter customer name';
    }
    return null;
  }

  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter phone number';
    }
    if (value.length < 10) {
      return 'Phone number must be at least 10 digits';
    }
    return null;
  }

  String? _validateAddress(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter service address';
    }
    return null;
  }

  String? _validateDescription(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please describe the service needed';
    }
    return null;
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case 'Emergency':
        return Colors.red;
      case 'High':
        return Colors.orange;
      case 'Medium':
        return Colors.yellow.shade700;
      case 'Low':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Service Request Collection'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        actions: [
          if (_serviceRequests.isNotEmpty)
            IconButton(
              onPressed: _clearAllRequests,
              icon: const Icon(Icons.clear_all),
              tooltip: 'Clear All Requests',
            ),
        ],
      ),
      body: Column(
        children: [
          // Form Section
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                border: Border(
                  bottom: BorderSide(color: Colors.grey.shade300),
                ),
              ),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'New Service Request',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      
                      TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          labelText: 'Customer Name',
                          prefixIcon: const Icon(Icons.person),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        validator: _validateName,
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: 12),
                      
                      TextFormField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          labelText: 'Phone Number',
                          prefixIcon: const Icon(Icons.phone),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        validator: _validatePhone,
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: 12),
                      
                      TextFormField(
                        controller: _addressController,
                        decoration: InputDecoration(
                          labelText: 'Service Address',
                          prefixIcon: const Icon(Icons.location_on),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        validator: _validateAddress,
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: 12),
                      
                      DropdownButtonFormField<String>(
                        value: _selectedServiceType,
                        decoration: InputDecoration(
                          labelText: 'Service Type',
                          prefixIcon: const Icon(Icons.build),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        items: _serviceTypes.map((String service) {
                          return DropdownMenuItem<String>(
                            value: service,
                            child: Text(service),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedServiceType = newValue!;
                          });
                        },
                      ),
                      const SizedBox(height: 12),
                      
                      DropdownButtonFormField<String>(
                        value: _selectedPriority,
                        decoration: InputDecoration(
                          labelText: 'Priority',
                          prefixIcon: const Icon(Icons.priority_high),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        items: _priorities.map((String priority) {
                          return DropdownMenuItem<String>(
                            value: priority,
                            child: Text(priority),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedPriority = newValue!;
                          });
                        },
                      ),
                      const SizedBox(height: 12),
                      
                      TextFormField(
                        controller: _descriptionController,
                        maxLines: 2,
                        decoration: InputDecoration(
                          labelText: 'Service Description',
                          prefixIcon: const Icon(Icons.description),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        validator: _validateDescription,
                        textInputAction: TextInputAction.done,
                      ),
                      const SizedBox(height: 16),
                      
                      ElevatedButton(
                        onPressed: _submitForm,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.primary,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: const Text(
                          'Add Service Request',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          
          // Display Section
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Service Requests (${_serviceRequests.length})',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: _serviceRequests.isEmpty
                        ? const Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.inbox,
                                  size: 64,
                                  color: Colors.grey,
                                ),
                                SizedBox(height: 16),
                                Text(
                                  'No service requests yet',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                  ),
                                ),
                                Text(
                                  'Add a service request above',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : ListView.builder(
                            itemCount: _serviceRequests.length,
                            itemBuilder: (context, index) {
                              final request = _serviceRequests[index];
                              return Card(
                                margin: const EdgeInsets.symmetric(vertical: 4),
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor: _getPriorityColor(request.priority),
                                    child: Text(
                                      '${index + 1}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  title: Text(
                                    request.customerName,
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(request.serviceType),
                                      Text(request.address),
                                      Text(
                                        '${request.timestamp.day}/${request.timestamp.month}/${request.timestamp.year} ${request.timestamp.hour}:${request.timestamp.minute.toString().padLeft(2, '0')}',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                    ],
                                  ),
                                  trailing: Chip(
                                    label: Text(
                                      request.priority,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                    backgroundColor: _getPriorityColor(request.priority),
                                  ),
                                  isThreeLine: true,
                                ),
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
