import 'package:flutter/material.dart';

class MessageChatWidget extends StatelessWidget {
  final bool myMessage;
  final String? profileImage;
  final String message;
  final String time;

  const MessageChatWidget({
    super.key,
    required this.myMessage,
    this.profileImage,
    required this.message,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: myMessage ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
        child: Column(
          crossAxisAlignment:
              myMessage ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            if (!myMessage) _buildOtherMessage(),
            if (myMessage) _buildMyMessage(),
            const SizedBox(height: 4),
            Text(
              time,
              style: const TextStyle(fontSize: 10, color: Colors.white54),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOtherMessage() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (profileImage != null)
          ClipOval(
            child: Image.asset(
              profileImage!,
              width: 32,
              height: 32,
              fit: BoxFit.cover,
            ),
          ),
        const SizedBox(width: 8),
        Flexible(
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF191919),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              message,
              style: const TextStyle(fontSize: 14, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMyMessage() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF4B39EF),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        message,
        style: const TextStyle(fontSize: 14, color: Colors.white),
      ),
    );
  }
}
