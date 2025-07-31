import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Row(
          children: [
      //      IconButton(icon: const Icon(Icons.search, color: Colors.white), i),
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
              backgroundColor: const Color(0x191919),

              child: IconButton(
                icon: const Icon(Icons.search, color: Colors.white),
                onPressed: () {
                  // Ação de busca
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: CircleAvatar(
              backgroundColor: const Color(0x191919),
              child: IconButton(
                icon: const Icon(Icons.notifications, color: Colors.white),
                onPressed: () {
                  // Ação de notificações
                },
              ),
            ),
          ),
        ],
      ),
      body: const Center(
        child: Text('Bem-vindo à Home!', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
