import 'package:flutter/material.dart';
import '../models/user.dart';
import '../services/api_service.dart';
import '../widgets/profile_card.dart';
import '../widgets/custom_button.dart';
import '../widgets/chat_bubble.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ApiService _apiService = ApiService();
  User? _user;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    try {
      final user = await _apiService.getCurrentUser();
      setState(() {
        _user = user;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error loading profile: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _user == null
          ? const Center(child: Text('Failed to load profile'))
          : SingleChildScrollView(
              child: Column(
                children: [
                  // Profile Card (Activity 2, Task 4)
                  ProfileCard(user: _user!),

                  // Container with padding, margin, and background color (Activity 2, Task 3)
                  Container(
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.deepPurple.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.deepPurple, width: 2),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'Profile Information',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple,
                          ),
                        ),
                        const SizedBox(height: 16),
                        _buildInfoRow('Name', _user!.name),
                        _buildInfoRow('Email', _user!.email),
                        _buildInfoRow('Bio', _user!.bio),
                      ],
                    ),
                  ),

                  // Responsive layout using Expanded (Activity 2, Task 5)
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.blue.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Column(
                              children: [
                                Icon(Icons.star, color: Colors.blue, size: 30),
                                SizedBox(height: 8),
                                Text(
                                  'Rating',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text('4.8'),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.green.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Column(
                              children: [
                                Icon(Icons.work, color: Colors.green, size: 30),
                                SizedBox(height: 8),
                                Text(
                                  'Services',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text('12'),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Navigation bar using Row (Activity 2, Task 6)
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildNavItem(Icons.edit, 'Edit'),
                        _buildNavItem(Icons.settings, 'Settings'),
                        _buildNavItem(Icons.help, 'Help'),
                        _buildNavItem(Icons.logout, 'Logout'),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Chat bubble UI example (Activity 2, Task 9)
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Recent Messages',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        ChatBubble(
                          message: 'Hello! How can I help you today?',
                          isMe: false,
                          timestamp: '2:30 PM',
                        ),
                        ChatBubble(
                          message: 'I need help with my plumbing issue.',
                          isMe: true,
                          timestamp: '2:32 PM',
                        ),
                        ChatBubble(
                          message:
                              'I can schedule a visit for tomorrow morning. Does that work?',
                          isMe: false,
                          timestamp: '2:35 PM',
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Custom buttons using our reusable widget
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomButton(
                        text: 'Edit Profile',
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Edit Profile clicked'),
                            ),
                          );
                        },
                        backgroundColor: Colors.deepPurple,
                        width: 120,
                      ),
                      CustomButton(
                        text: 'Settings',
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Settings clicked')),
                          );
                        },
                        backgroundColor: Colors.green,
                        width: 120,
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              '$label:',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.deepPurple),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Colors.deepPurple),
        ),
      ],
    );
  }
}
