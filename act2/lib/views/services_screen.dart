import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../models/service.dart';
import '../services/api_service.dart';
import '../widgets/service_card.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({super.key});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen>
    with TickerProviderStateMixin {
  final ApiService _apiService = ApiService();
  List<Service> _services = [];
  bool _isLoading = true;
  bool _useMaterialDesign = true;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadServices();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadServices() async {
    try {
      final services = await _apiService.getServices();
      setState(() {
        _services = services;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error loading services: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_useMaterialDesign) {
      return _buildMaterialDesign();
    } else {
      return _buildCupertinoDesign();
    }
  }

  Widget _buildMaterialDesign() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Services - Material Design'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'All Services'),
            Tab(text: 'Categories'),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.apple),
            onPressed: () {
              setState(() {
                _useMaterialDesign = false;
              });
            },
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : TabBarView(
              controller: _tabController,
              children: [_buildServicesList(), _buildCategoriesView()],
            ),
    );
  }

  Widget _buildCupertinoDesign() {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Services - Cupertino Design'),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Icon(CupertinoIcons.phone),
          onPressed: () {
            setState(() {
              _useMaterialDesign = true;
            });
          },
        ),
      ),
      child: _isLoading
          ? const Center(child: CupertinoActivityIndicator())
          : SafeArea(
              child: Column(
                children: [
                  // Cupertino segmented control
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: CupertinoSlidingSegmentedControl<int>(
                      groupValue: 0,
                      children: const {
                        0: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Text('All Services'),
                        ),
                        1: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Text('Categories'),
                        ),
                      },
                      onValueChanged: (int? value) {
                        // Handle tab change
                      },
                    ),
                  ),
                  Expanded(child: _buildServicesList()),
                ],
              ),
            ),
    );
  }

  Widget _buildServicesList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _services.length,
      itemBuilder: (context, index) {
        return ServiceCard(
          service: _services[index],
          onTap: () {
            _showServiceDetails(_services[index]);
          },
        );
      },
    );
  }

  Widget _buildCategoriesView() {
    final categories = _services.map((s) => s.category).toSet().toList();

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        final categoryServices = _services
            .where((s) => s.category == category)
            .toList();

        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          child: ExpansionTile(
            title: Text(
              category,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text('${categoryServices.length} services'),
            children: categoryServices.map((service) {
              return ListTile(
                title: Text(service.title),
                subtitle: Text(service.description),
                trailing: Text('\$${service.price.toStringAsFixed(0)}'),
                onTap: () => _showServiceDetails(service),
              );
            }).toList(),
          ),
        );
      },
    );
  }

  void _showServiceDetails(Service service) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(service.title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(service.description),
            const SizedBox(height: 8),
            Text('Category: ${service.category}'),
            Text('Price: \$${service.price.toStringAsFixed(0)}'),
            Text('Rating: ${service.rating} (${service.reviewCount} reviews)'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Booked: ${service.title}')),
              );
            },
            child: const Text('Book Service'),
          ),
        ],
      ),
    );
  }
}
