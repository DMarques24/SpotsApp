import 'package:firebase_database/firebase_database.dart';
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
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref().child(
    "users",
  );
  Map<dynamic, dynamic>? userData;
  int _selectedIndex = 3;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  void _fetchUserData() async {
    DatabaseEvent event =
        await _dbRef.child("UWrkg2rKiXdBhP13ef3PpZHaLgV2").once();
    setState(() {
      userData = event.snapshot.value as Map?;
    });
  }

  void _onItemTapped(int index) {
    if (index == 2) {
      // Navegação futura para mensagens
    } else if (index == 0) {
      Navigator.pushReplacement(
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
      body:
          userData == null
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 20.0,
                ),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 48,
                      backgroundImage: AssetImage(
                        '/Users/diogodemouramarques/Desktop/SpotsApp/sportsocial/assets/person1.jpg',
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      userData!['name'] ?? 'No Name',
                      style: const TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '@lindo',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                      style: const TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    const SizedBox(height: 24),
                    // Stats Container
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
                          _buildStatItem('100', 'Followers'),
                          Container(
                            height: 40,
                            width: 1,
                            color: Colors.white24,
                          ),
                          _buildStatItem('20', 'Following'),
                          Container(
                            height: 40,
                            width: 1,
                            color: Colors.white24,
                          ),
                          _buildStatItem(
                            userData!['height']?.toString() ?? '0',
                            'Height (cm)',
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Column(
                      children: [
                        FieldCardsWidget(
                          fieldName: 'Email',
                          value: userData!['email'] ?? 'No Email',
                        ),
                        const SizedBox(height: 12),
                        FieldCardsWidget(
                          fieldName: 'Sports',
                          value: userData!['sports'] ?? 'N/A',
                        ),
                        const SizedBox(height: 12),
                        FieldCardsWidget(
                          fieldName: 'Club',
                          value: userData!['club'] ?? 'N/A',
                        ),
                        const SizedBox(height: 12),
                        FieldCardsWidget(
                          fieldName: 'Position',
                          value: userData!['position'] ?? 'N/A',
                        ),
                        const SizedBox(height: 12),
                        FieldCardsWidget(
                          fieldName: 'Age',
                          value: userData!['age']?.toString() ?? 'N/A',
                        ),
                        const SizedBox(height: 80),
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
