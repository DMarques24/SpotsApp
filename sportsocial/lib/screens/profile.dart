import 'package:flutter/material.dart';
import 'package:sportsocial/screens/editProfile.dart';
import 'package:sportsocial/screens/home.dart';
import 'package:sportsocial/widgets/FieldCards.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _selectedIndex = 3;

  void _onItemTapped(int index) {
    if (index == 2) {
      /* Navigator.push(
        context,
        MaterialPageRoute(builder: (ctx) => const MessagesScreen()),
      ); */
    } else if (index == 0) {
      Navigator.pop(
        context,
        MaterialPageRoute(builder: (ctx) => const HomeScreen()),
      );
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  Widget _buildNavItem(IconData icon, int index) {
    final isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Icon(
        icon,
        size: 28,
        color: isSelected ? Colors.white : Colors.white54,
      ),
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Colors.white70),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('My Profile', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: CircleAvatar(
              backgroundColor: const Color(0xFF191919),
              child: IconButton(
                icon: const Icon(Icons.lock_open, color: Colors.white),
                onPressed: () {
                  // Privacy action
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: CircleAvatar(
              backgroundColor: const Color(0xFF191919),
              child: IconButton(
                icon: const Icon(Icons.edit, color: Colors.white),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) => const EditProfileScreen(),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 48,
              backgroundImage: AssetImage(
                '/Users/diogodemouramarques/Desktop/SpotsApp/sportsocial/assets/person1.jpg',
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Courtney Henry',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              '@henrycourtney',
              style: TextStyle(fontSize: 16, color: Colors.white70),
            ),
            const SizedBox(height: 16),
            const Text(
              'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            const SizedBox(height: 24),
            // Stats Container (Top)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                color: const Color(0xFF191919),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildStatItem('25.2K', 'Followers'),
                  Container(height: 40, width: 1, color: Colors.white24),
                  _buildStatItem('254', 'Following'),
                  Container(height: 40, width: 1, color: Colors.white24),
                  _buildStatItem('198', 'Height (cm)'),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Column(
              children: [
                FieldCardsWidget(fieldName: 'Email', value: 'henry@gmail.com'),
                const SizedBox(height: 12),
                FieldCardsWidget(fieldName: 'Sports', value: 'Football'),
                const SizedBox(height: 12),
                FieldCardsWidget(fieldName: 'Club', value: 'FC Real Madrid'),
                const SizedBox(height: 12),
                FieldCardsWidget(fieldName: 'Position', value: 'Goal Keeper'),
                const SizedBox(height: 12),
                FieldCardsWidget(fieldName: 'Age', value: '25 Years'),
                const SizedBox(height: 80), // Extra space at bottom
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.7),
            borderRadius: BorderRadius.circular(40),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(Icons.home, 0),
              _buildNavItem(Icons.search, 1),
              _buildNavItem(Icons.chat_bubble_outline, 2),
              GestureDetector(
                onTap: () => _onItemTapped(3),
                child: CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage(
                    '/Users/diogodemouramarques/Desktop/SpotsApp/sportsocial/assets/person1.jpg',
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
