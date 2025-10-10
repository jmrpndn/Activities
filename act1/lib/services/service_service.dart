import '../models/service.dart';

class ServiceService {
  static final List<Service> _services = [
    const Service(
      id: '1',
      name: 'Haircut & Styling',
      description: 'Professional haircut with modern styling techniques',
      price: 45.0,
      imageUrl:
          'https://images.unsplash.com/photo-1560066984-138dadb4c035?w=400',
      category: 'Hair',
      duration: 60,
      rating: 4.8,
    ),
    const Service(
      id: '2',
      name: 'Facial Treatment',
      description: 'Deep cleansing facial with moisturizing treatment',
      price: 80.0,
      imageUrl:
          'https://images.unsplash.com/photo-1616394584738-fc6e612e71b9?w=400',
      category: 'Skincare',
      duration: 90,
      rating: 4.9,
    ),
    const Service(
      id: '3',
      name: 'Manicure & Pedicure',
      description: 'Complete nail care with polish application',
      price: 65.0,
      imageUrl:
          'https://images.unsplash.com/photo-1604654894610-df63bc536371?w=400',
      category: 'Nails',
      duration: 75,
      rating: 4.7,
    ),
    const Service(
      id: '4',
      name: 'Massage Therapy',
      description: 'Relaxing full-body massage to relieve stress',
      price: 120.0,
      imageUrl:
          'https://images.unsplash.com/photo-1540555700478-4be289fbecef?w=400',
      category: 'Wellness',
      duration: 120,
      rating: 4.9,
    ),
    const Service(
      id: '5',
      name: 'Eyebrow Shaping',
      description: 'Professional eyebrow shaping and tinting',
      price: 35.0,
      imageUrl:
          'https://images.unsplash.com/photo-1522335789203-aabd1fc54bc9?w=400',
      category: 'Beauty',
      duration: 30,
      rating: 4.6,
    ),
    const Service(
      id: '6',
      name: 'Hair Coloring',
      description: 'Professional hair coloring with premium products',
      price: 150.0,
      imageUrl:
          'https://images.unsplash.com/photo-1522337360788-8b13dee7a37e?w=400',
      category: 'Hair',
      duration: 180,
      rating: 4.8,
    ),
  ];

  static List<Service> getAllServices() {
    return List.from(_services);
  }

  static List<Service> getServicesByCategory(String category) {
    return _services.where((service) => service.category == category).toList();
  }

  static List<String> getCategories() {
    return _services.map((service) => service.category).toSet().toList();
  }

  static Service? getServiceById(String id) {
    try {
      return _services.firstWhere((service) => service.id == id);
    } catch (e) {
      return null;
    }
  }

  static List<Service> searchServices(String query) {
    if (query.isEmpty) return _services;

    return _services
        .where(
          (service) =>
              service.name.toLowerCase().contains(query.toLowerCase()) ||
              service.description.toLowerCase().contains(query.toLowerCase()) ||
              service.category.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();
  }
}
