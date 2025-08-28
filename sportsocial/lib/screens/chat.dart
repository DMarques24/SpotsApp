import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sportsocial/widgets/messageChat.dart';

class ChatScreen extends StatefulWidget {
  final String chatId; // o id da conversa entre 2 pessoas
  const ChatScreen({super.key, required this.chatId});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final User? currentUser = FirebaseAuth.instance.currentUser;

  /// Enviar mensagem para o Firestore
  Future<void> _sendMessage() async {
    if (_messageController.text.trim().isEmpty) return;

    // Buscar participantes do chat
    final chatDoc =
        await FirebaseFirestore.instance
            .collection('chats')
            .doc(widget.chatId)
            .get();

    final participants = List<String>.from(chatDoc['participants']);
    final receiverId = participants.firstWhere(
      (uid) => uid != currentUser!.uid,
    );

    // Atualizar o campo updatedAt
    await FirebaseFirestore.instance
        .collection('chats')
        .doc(widget.chatId)
        .update({'updatedAt': FieldValue.serverTimestamp()});

    await FirebaseFirestore.instance
        .collection('chats')
        .doc(widget.chatId)
        .collection('messages')
        .add({
          'text': _messageController.text.trim(),
          'senderId': currentUser!.uid,
          'reciverId': receiverId,
          'timestamp': FieldValue.serverTimestamp(),
        });

    _messageController.clear();
  }

  /// Stream das mensagens em tempo real
  Stream<QuerySnapshot> _messagesStream() {
    return FirebaseFirestore.instance
        .collection('chats')
        .doc(widget.chatId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          'Chat',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _messagesStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                "Sem mensagens ainda...",
                style: TextStyle(color: Colors.white54),
              ),
            );
          }

          final messages = snapshot.data!.docs;

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: messages.length,
            itemBuilder: (context, index) {
              final msg = messages[index];
              final isMe = msg['senderId'] == currentUser!.uid;

              return MessageChatWidget(
                myMessage: isMe,
                message: msg['text'],
                time:
                    msg['timestamp'] != null
                        ? (msg['timestamp'] as Timestamp)
                            .toDate()
                            .toLocal()
                            .toString()
                            .substring(11, 16)
                        : '',
                profileImage:
                    !isMe
                        ? '/Users/diogodemouramarques/Desktop/SpotsApp/sportsocial/assets/person1.jpg'
                        : null,
              );
            },
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: const Color(0xFF191919),
            borderRadius: BorderRadius.circular(40),
            border: Border.all(color: const Color(0xFF3F3F3F), width: 1),
          ),
          child: Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.attach_file, color: Colors.white),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  controller: _messageController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    hintText: 'Type message...',
                    hintStyle: TextStyle(color: Colors.white54),
                    border: InputBorder.none,
                  ),
                  onSubmitted: (_) => _sendMessage(),
                ),
              ),
              IconButton(
                onPressed: _sendMessage,
                icon: const Icon(Icons.send, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
