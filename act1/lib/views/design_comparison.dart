import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../widgets/custom_button.dart';

/// Task 5: Implement both Material Design and Cupertino Widgets for the same UI screen
class DesignComparison extends StatefulWidget {
  const DesignComparison({super.key});

  @override
  State<DesignComparison> createState() => _DesignComparisonState();
}

class _DesignComparisonState extends State<DesignComparison> {
  bool _useMaterialDesign = true;
  String _selectedService = 'Haircut & Styling';
  double _sliderValue = 50.0;
  bool _switchValue = false;

  final List<String> _services = [
    'Haircut & Styling',
    'Facial Treatment',
    'Manicure & Pedicure',
    'Massage Therapy',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _useMaterialDesign
          ? _buildMaterialAppBar()
          : _buildCupertinoAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildToggleSection(),
            const SizedBox(height: 20),
            _buildButtonSection(),
            const SizedBox(height: 20),
            _buildInputSection(),
            const SizedBox(height: 20),
            _buildSliderSection(),
            const SizedBox(height: 20),
            _buildSwitchSection(),
            const SizedBox(height: 20),
            _buildListSection(),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildMaterialAppBar() {
    return AppBar(
      title: const Text('Design Comparison'),
      backgroundColor: Colors.deepPurple,
      foregroundColor: Colors.white,
      actions: [
        IconButton(
          icon: const Icon(Icons.info),
          onPressed: () => _showInfoDialog('Material Design'),
        ),
      ],
    );
  }

  PreferredSizeWidget _buildCupertinoAppBar() {
    return CupertinoNavigationBar(
      middle: const Text('Design Comparison'),
      backgroundColor: CupertinoColors.systemBackground,
      trailing: CupertinoButton(
        padding: EdgeInsets.zero,
        child: const Icon(CupertinoIcons.info_circle),
        onPressed: () => _showInfoDialog('Cupertino Design'),
      ),
    );
  }

  Widget _buildToggleSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Design System',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    text: 'Material Design',
                    onPressed: () => setState(() => _useMaterialDesign = true),
                    variant: _useMaterialDesign
                        ? ButtonVariant.primary
                        : ButtonVariant.outline,
                    width: double.infinity,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: CustomButton(
                    text: 'Cupertino',
                    onPressed: () => setState(() => _useMaterialDesign = false),
                    variant: !_useMaterialDesign
                        ? ButtonVariant.primary
                        : ButtonVariant.outline,
                    type: ButtonType.cupertino,
                    width: double.infinity,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButtonSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Custom Buttons',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                CustomButton(
                  text: 'Primary',
                  onPressed: () => _showSnackBar('Primary button pressed'),
                  variant: ButtonVariant.primary,
                  type: _useMaterialDesign
                      ? ButtonType.material
                      : ButtonType.cupertino,
                ),
                CustomButton(
                  text: 'Secondary',
                  onPressed: () => _showSnackBar('Secondary button pressed'),
                  variant: ButtonVariant.secondary,
                  type: _useMaterialDesign
                      ? ButtonType.material
                      : ButtonType.cupertino,
                ),
                CustomButton(
                  text: 'Outline',
                  onPressed: () => _showSnackBar('Outline button pressed'),
                  variant: ButtonVariant.outline,
                  type: _useMaterialDesign
                      ? ButtonType.material
                      : ButtonType.cupertino,
                ),
                CustomButton(
                  text: 'Loading',
                  onPressed: null,
                  isLoading: true,
                  type: _useMaterialDesign
                      ? ButtonType.material
                      : ButtonType.cupertino,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Text Input', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 10),
            _useMaterialDesign
                ? TextField(
                    decoration: const InputDecoration(
                      labelText: 'Enter your name',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person),
                    ),
                    onChanged: (value) {},
                  )
                : CupertinoTextField(
                    placeholder: 'Enter your name',
                    prefix: const Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: Icon(CupertinoIcons.person),
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: CupertinoColors.separator),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    onChanged: (value) {},
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildSliderSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Slider (Price Range: \$${_sliderValue.toInt()})',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 10),
            _useMaterialDesign
                ? Slider(
                    value: _sliderValue,
                    min: 0,
                    max: 200,
                    divisions: 20,
                    label: '\$${_sliderValue.toInt()}',
                    onChanged: (value) => setState(() => _sliderValue = value),
                  )
                : CupertinoSlider(
                    value: _sliderValue,
                    min: 0,
                    max: 200,
                    divisions: 20,
                    onChanged: (value) => setState(() => _sliderValue = value),
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildSwitchSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Enable Notifications',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            _useMaterialDesign
                ? Switch(
                    value: _switchValue,
                    onChanged: (value) => setState(() => _switchValue = value),
                  )
                : CupertinoSwitch(
                    value: _switchValue,
                    onChanged: (value) => setState(() => _switchValue = value),
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildListSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Service Selection',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 10),
            _useMaterialDesign
                ? DropdownButtonFormField<String>(
                    initialValue: _selectedService,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Select Service',
                    ),
                    items: _services.map((service) {
                      return DropdownMenuItem(
                        value: service,
                        child: Text(service),
                      );
                    }).toList(),
                    onChanged: (value) => setState(
                      () => _selectedService = value ?? _selectedService,
                    ),
                  )
                : CupertinoButton(
                    padding: EdgeInsets.zero,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border.all(color: CupertinoColors.separator),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(_selectedService),
                          const Icon(CupertinoIcons.chevron_down),
                        ],
                      ),
                    ),
                    onPressed: () => _showCupertinoPicker(),
                  ),
          ],
        ),
      ),
    );
  }

  void _showCupertinoPicker() {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => Container(
        height: 200,
        color: CupertinoColors.systemBackground,
        child: CupertinoPicker(
          itemExtent: 40,
          onSelectedItemChanged: (index) {
            setState(() => _selectedService = _services[index]);
          },
          children: _services
              .map((service) => Center(child: Text(service)))
              .toList(),
        ),
      ),
    );
  }

  void _showSnackBar(String message) {
    if (_useMaterialDesign) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    } else {
      // For Cupertino, we'd typically use a different approach
      // This is a simplified version
      showDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: const Text('Action'),
          content: Text(message),
          actions: [
            CupertinoDialogAction(
              child: const Text('OK'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      );
    }
  }

  void _showInfoDialog(String designSystem) {
    if (_useMaterialDesign) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('$designSystem Features'),
          content: const Text(
            'This screen demonstrates the differences between Material Design and Cupertino widgets. '
            'Material Design follows Google\'s design language with bold colors and elevation, '
            'while Cupertino follows Apple\'s iOS design guidelines with clean, minimal interfaces.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } else {
      showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: Text('$designSystem Features'),
          content: const Text(
            'This screen demonstrates the differences between Material Design and Cupertino widgets. '
            'Material Design follows Google\'s design language with bold colors and elevation, '
            'while Cupertino follows Apple\'s iOS design guidelines with clean, minimal interfaces.',
          ),
          actions: [
            CupertinoDialogAction(
              child: const Text('OK'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      );
    }
  }
}
