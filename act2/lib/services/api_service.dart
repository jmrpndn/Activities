import '../models/user.dart';
import '../models/service.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();

  // Mock data for demonstration
  Future<List<Service>> getServices() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    return [
      Service(
        id: '1',
        title: 'House Cleaning',
        description: 'Professional house cleaning services',
        price: 50.0,
        category: 'Cleaning',
        imageUrl:
            'https://via.placeholder.com/300x200/4CAF50/FFFFFF?text=Cleaning',
        rating: 4.8,
        reviewCount: 124,
      ),
      Service(
        id: '2',
        title: 'Plumbing Repair',
        description: 'Expert plumbing repair and maintenance',
        price: 75.0,
        category: 'Repair',
        imageUrl:
            'https://via.placeholder.com/300x200/2196F3/FFFFFF?text=Plumbing',
        rating: 4.6,
        reviewCount: 89,
      ),
      Service(
        id: '3',
        title: 'Tutoring Services',
        description: 'Personal tutoring for various subjects',
        price: 30.0,
        category: 'Education',
        imageUrl:
            'https://via.placeholder.com/300x200/FF9800/FFFFFF?text=Tutoring',
        rating: 4.9,
        reviewCount: 156,
      ),
      Service(
        id: '4',
        title: 'Garden Maintenance',
        description: 'Professional garden care and maintenance',
        price: 40.0,
        category: 'Outdoor',
        imageUrl:
            'https://via.placeholder.com/300x200/4CAF50/FFFFFF?text=Garden',
        rating: 4.7,
        reviewCount: 67,
      ),
    ];
  }

  Future<User> getCurrentUser() async {
    await Future.delayed(const Duration(milliseconds: 500));

    return User(
      id: '1',
      name: 'John Doe',
      email: 'john.doe@example.com',
      profileImageUrl:
          'https://via.placeholder.com/100x100/9C27B0/FFFFFF?text=JD',
      bio: 'Service provider with 5+ years of experience',
    );
  }
}
