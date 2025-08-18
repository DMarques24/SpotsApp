import 'package:flutter/material.dart';
import 'package:sportsocial/screens/messages.dart';
import 'package:sportsocial/screens/profile.dart';
import 'package:sportsocial/widgets/history.dart';
import 'package:sportsocial/widgets/post.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (ctx) => const MessagesScreen()),
      );
    } else if (index == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (ctx) => const ProfileScreen()),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Row(
          children: [
            SizedBox(width: 8),
            Icon(Icons.sports_soccer, color: Colors.white),
            SizedBox(width: 8),
            Text('Logoipsum', style: TextStyle(color: Colors.white)),
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: CircleAvatar(
              backgroundColor: Color(0x191919),
              child: IconButton(
                icon: Icon(Icons.search, color: Colors.white),
                onPressed: () {
                  // Ação de busca
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: CircleAvatar(
              backgroundColor: Color(0x191919),
              child: IconButton(
                icon: Icon(Icons.notifications, color: Colors.white),
                onPressed: () {
                  // Ação de notificações
                },
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
        child: const Center(
          child: Column(
            children: [
              Row(
                children: [
                  HistoryWidget(
                    image:
                        '/Users/diogodemouramarques/Desktop/SpotsApp/sportsocial/assets/person1.jpg',
                    name: 'Kelly',
                  ),
                ],
              ),
              SizedBox(height: 24),
              PostWidget(
                personImage:
                    '/Users/diogodemouramarques/Desktop/SpotsApp/sportsocial/assets/person1.jpg',
                personName: 'John Smith',
                personappName: '@johnsmith122',
                postImage:
                    '/Users/diogodemouramarques/Desktop/SpotsApp/sportsocial/assets/postImage.jpg',
                numLiks: 4500,
                numComments: 254,
                description:
                    'Lorem Ipsum is simply dummy text of the printing and typesetting industry',
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.7), // fundo translúcido
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
