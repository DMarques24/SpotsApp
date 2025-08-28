import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:sportsocial/screens/chat.dart';
import 'package:sportsocial/screens/home.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  int _selectedIndex = 0;
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  void _onItemTapped(int index) {
    if (index == 0) {
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

  /// Stream de todos os chats do utilizador atual
  Stream<QuerySnapshot> _userChatsStream(String uid) {
    return _firestore
        .collection('chats')
        .where('participants', arrayContains: uid)
        .snapshots();
  }

  /// Busca o último texto da conversa
  Future<String> _getLastMessage(String chatId) async {
    final messages =
        await _firestore
            .collection('chats')
            .doc(chatId)
            .collection('messages')
            .orderBy('timestamp', descending: true)
            .limit(1)
            .get();

    if (messages.docs.isNotEmpty) {
      return messages.docs.first['text'] ?? '';
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = _auth.currentUser;
    if (currentUser == null) {
      return const Scaffold(body: Center(child: Text('Não autenticado')));
    }

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
              backgroundColor: Color(0x00191919),
              child: IconButton(
                icon: Icon(Icons.search, color: Colors.white),
                onPressed: () {},
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: CircleAvatar(
              backgroundColor: Color(0x00191919),
              child: IconButton(
                icon: Icon(Icons.notifications, color: Colors.white),
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: const Color(0xFF191919),
                borderRadius: BorderRadius.circular(40),
                border: Border.all(color: const Color(0xFF3F3F3F), width: 1),
              ),
              child: TextField(
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: 'Search message',
                  hintStyle: TextStyle(color: Colors.white54),
                  border: InputBorder.none,
                  suffixIcon: Icon(Icons.search, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _userChatsStream(currentUser.uid),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(
                      child: Text(
                        "Sem conversas ainda...",
                        style: TextStyle(color: Colors.white54),
                      ),
                    );
                  }
                  final chats = snapshot.data!.docs;
                  return ListView.builder(
                    itemCount: chats.length,
                    itemBuilder: (context, index) {
                      final chat = chats[index];
                      final chatId = chat.id;
                      final participants = List<String>.from(
                        chat['participants'],
                      );
                      // Mostra o outro utilizador
                      final otherUid = participants.firstWhere(
                        (uid) => uid != currentUser.uid,
                      );

                      return FutureBuilder<String>(
                        future: _getLastMessage(chatId),
                        builder: (context, msgSnapshot) {
                          final lastMsg = msgSnapshot.data ?? '';
                          return Card(
                            color: const Color(0xFF191919),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            child: ListTile(
                              leading: const CircleAvatar(
                                backgroundImage: AssetImage(
                                  '/Users/diogodemouramarques/Desktop/SpotsApp/sportsocial/assets/person1.jpg',
                                ),
                              ),
                              title: Text(
                                otherUid,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                lastMsg,
                                style: const TextStyle(color: Colors.white70),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (ctx) => ChatScreen(chatId: chatId),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
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
                child: const CircleAvatar(
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
