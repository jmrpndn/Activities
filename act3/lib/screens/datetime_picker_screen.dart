import 'package:flutter/material.dart';

class DateTimePickerScreen extends StatefulWidget {
  const DateTimePickerScreen({super.key});

  @override
  State<DateTimePickerScreen> createState() => _DateTimePickerScreenState();
}

class _DateTimePickerScreenState extends State<DateTimePickerScreen> {
  final _formKey = GlobalKey<FormState>();
  final _customerNameController = TextEditingController();
  final _serviceAddressController = TextEditingController();
  final _phoneController = TextEditingController();
  final _serviceDescriptionController = TextEditingController();
  
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  DateTime? _preferredStartDate;
  TimeOfDay? _preferredStartTime;
  DateTime? _preferredEndDate;
  TimeOfDay? _preferredEndTime;

  @override
  void dispose() {
    _customerNameController.dispose();
    _serviceAddressController.dispose();
    _phoneController.dispose();
    _serviceDescriptionController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context, String type) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: type == 'service' 
          ? (_selectedDate ?? DateTime.now())
          : type == 'start'
              ? (_preferredStartDate ?? DateTime.now())
              : (_preferredEndDate ?? DateTime.now()),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Theme.of(context).colorScheme.primary,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    
    if (picked != null) {
      setState(() {
        if (type == 'service') {
          _selectedDate = picked;
        } else if (type == 'start') {
          _preferredStartDate = picked;
        } else {
          _preferredEndDate = picked;
        }
      });
    }
  }

  Future<void> _selectTime(BuildContext context, String type) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: type == 'service'
          ? (_selectedTime ?? TimeOfDay.now())
          : type == 'start'
              ? (_preferredStartTime ?? TimeOfDay.now())
              : (_preferredEndTime ?? TimeOfDay.now()),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Theme.of(context).colorScheme.primary,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    
    if (picked != null) {
      setState(() {
        if (type == 'service') {
          _selectedTime = picked;
        } else if (type == 'start') {
          _preferredStartTime = picked;
        } else {
          _preferredEndTime = picked;
        }
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate() && 
        _selectedDate != null && 
        _selectedTime != null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Service Appointment Scheduled'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Customer: ${_customerNameController.text}'),
                  Text('Address: ${_serviceAddressController.text}'),
                  Text('Phone: ${_phoneController.text}'),
                  Text('Service: ${_serviceDescriptionController.text}'),
                  Text('Date: ${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'),
                  Text('Time: ${_selectedTime!.format(context)}'),
                  if (_preferredStartDate != null)
                    Text('Preferred Start: ${_preferredStartDate!.day}/${_preferredStartDate!.month}/${_preferredStartDate!.year} at ${_preferredStartTime?.format(context)}'),
                  if (_preferredEndDate != null)
                    Text('Preferred End: ${_preferredEndDate!.day}/${_preferredEndDate!.month}/${_preferredEndDate!.year} at ${_preferredEndTime?.format(context)}'),
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
      return 'Please enter customer name';
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
      return 'Please enter phone number';
    }
    return null;
  }

  String? _validateDescription(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please describe the service needed';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Schedule Service'),
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
                Icons.schedule,
                size: 60,
                color: Colors.blue,
              ),
              const SizedBox(height: 20),
              const Text(
                'Schedule Service Appointment',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              const Text(
                'Book your refrigeration or AC service appointment',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              
              // Customer Information
              const Text(
                'Customer Information',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              
              TextFormField(
                controller: _customerNameController,
                decoration: InputDecoration(
                  labelText: 'Customer Name',
                  hintText: 'Enter customer name',
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
              const SizedBox(height: 16),
              
              TextFormField(
                controller: _serviceAddressController,
                decoration: InputDecoration(
                  labelText: 'Service Address',
                  hintText: 'Enter service address',
                  prefixIcon: const Icon(Icons.location_on),
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
                validator: _validateAddress,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 16),
              
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  hintText: 'Enter phone number',
                  prefixIcon: const Icon(Icons.phone),
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
                validator: _validatePhone,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 16),
              
              TextFormField(
                controller: _serviceDescriptionController,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'Service Description',
                  hintText: 'Describe the refrigeration or AC service needed',
                  prefixIcon: const Icon(Icons.description),
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
                validator: _validateDescription,
                textInputAction: TextInputAction.done,
              ),
              
              const SizedBox(height: 30),
              
              // Service Date & Time
              const Text(
                'Service Schedule',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              
              Row(
                children: [
                  Expanded(
                    child: ListTile(
                      title: Text(_selectedDate == null 
                          ? 'Select Date' 
                          : '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'),
                      subtitle: const Text('Service Date'),
                      leading: const Icon(Icons.calendar_today),
                      trailing: const Icon(Icons.arrow_drop_down),
                      onTap: () => _selectDate(context, 'service'),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(color: Colors.grey.shade300),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ListTile(
                      title: Text(_selectedTime == null 
                          ? 'Select Time' 
                          : _selectedTime!.format(context)),
                      subtitle: const Text('Service Time'),
                      leading: const Icon(Icons.access_time),
                      trailing: const Icon(Icons.arrow_drop_down),
                      onTap: () => _selectTime(context, 'service'),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(color: Colors.grey.shade300),
                      ),
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 20),
              
              // Preferred Time Range
              const Text(
                'Preferred Time Range (Optional)',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 16),
              
              Row(
                children: [
                  Expanded(
                    child: ListTile(
                      title: Text(_preferredStartDate == null 
                          ? 'Start Date' 
                          : '${_preferredStartDate!.day}/${_preferredStartDate!.month}/${_preferredStartDate!.year}'),
                      subtitle: const Text('Preferred Start'),
                      leading: const Icon(Icons.play_arrow),
                      trailing: const Icon(Icons.arrow_drop_down),
                      onTap: () => _selectDate(context, 'start'),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(color: Colors.grey.shade300),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ListTile(
                      title: Text(_preferredStartTime == null 
                          ? 'Start Time' 
                          : _preferredStartTime!.format(context)),
                      subtitle: const Text('Preferred Start Time'),
                      leading: const Icon(Icons.access_time),
                      trailing: const Icon(Icons.arrow_drop_down),
                      onTap: () => _selectTime(context, 'start'),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(color: Colors.grey.shade300),
                      ),
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 16),
              
              Row(
                children: [
                  Expanded(
                    child: ListTile(
                      title: Text(_preferredEndDate == null 
                          ? 'End Date' 
                          : '${_preferredEndDate!.day}/${_preferredEndDate!.month}/${_preferredEndDate!.year}'),
                      subtitle: const Text('Preferred End'),
                      leading: const Icon(Icons.stop),
                      trailing: const Icon(Icons.arrow_drop_down),
                      onTap: () => _selectDate(context, 'end'),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(color: Colors.grey.shade300),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ListTile(
                      title: Text(_preferredEndTime == null 
                          ? 'End Time' 
                          : _preferredEndTime!.format(context)),
                      subtitle: const Text('Preferred End Time'),
                      leading: const Icon(Icons.access_time),
                      trailing: const Icon(Icons.arrow_drop_down),
                      onTap: () => _selectTime(context, 'end'),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(color: Colors.grey.shade300),
                      ),
                    ),
                  ),
                ],
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
                    'Schedule Appointment',
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
