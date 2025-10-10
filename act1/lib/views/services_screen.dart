import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../models/service.dart';
import '../services/service_service.dart';
import '../widgets/custom_button.dart';
import 'booking_form.dart';

/// Main services screen with staggered grid view using third-party package
class ServicesScreen extends StatefulWidget {
  const ServicesScreen({super.key});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  List<Service> _services = [];
  List<Service> _filteredServices = [];
  String _selectedCategory = 'All';
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadServices();
  }

  void _loadServices() {
    setState(() {
      _services = ServiceService.getAllServices();
      _filteredServices = _services;
    });
  }

  void _filterServices(String category) {
    setState(() {
      _selectedCategory = category;
      if (category == 'All') {
        _filteredServices = _services;
      } else {
        _filteredServices = ServiceService.getServicesByCategory(category);
      }
    });
  }

  void _searchServices(String query) {
    setState(() {
      _filteredServices = ServiceService.searchServices(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Our Services'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => _showSearchDialog(),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildCategoryFilter(),
          Expanded(
            child: _filteredServices.isEmpty
                ? const Center(
                    child: Text(
                      'No services found',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  )
                : _buildServicesGrid(),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryFilter() {
    final categories = ['All', ...ServiceService.getCategories()];

    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = _selectedCategory == category;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: FilterChip(
              label: Text(category),
              selected: isSelected,
              onSelected: (selected) => _filterServices(category),
              selectedColor: Colors.deepPurple.withOpacity(0.2),
              checkmarkColor: Colors.deepPurple,
              labelStyle: TextStyle(
                color: isSelected ? Colors.deepPurple : Colors.grey[700],
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildServicesGrid() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: MasonryGridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        itemCount: _filteredServices.length,
        itemBuilder: (context, index) {
          final service = _filteredServices[index];
          return _buildServiceCard(service);
        },
      ),
    );
  }

  Widget _buildServiceCard(Service service) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Service Image
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Container(
              height: 120,
              width: double.infinity,
              color: Colors.grey[300],
              child: const Icon(Icons.spa, size: 50, color: Colors.deepPurple),
            ),
          ),

          // Service Details
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  service.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  service.category,
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.star, size: 16, color: Colors.amber[600]),
                    const SizedBox(width: 4),
                    Text(
                      service.rating.toString(),
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$${service.price.toStringAsFixed(0)}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                    Text(
                      '${service.duration}min',
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: CustomButton(
                    text: 'Book Now',
                    onPressed: () => _navigateToBooking(service),
                    variant: ButtonVariant.primary,
                    height: 36,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToBooking(Service service) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BookingForm(service: service)),
    );
  }

  void _showSearchDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Search Services'),
        content: TextField(
          controller: _searchController,
          decoration: const InputDecoration(
            hintText: 'Enter service name or category...',
            border: OutlineInputBorder(),
          ),
          onChanged: _searchServices,
        ),
        actions: [
          TextButton(
            onPressed: () {
              _searchController.clear();
              _searchServices('');
              Navigator.pop(context);
            },
            child: const Text('Clear'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
