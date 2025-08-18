import 'package:flutter/material.dart';

class MessageCardWidget extends StatelessWidget {
  final String personImage;
  final String personName;
  final String message;

  const MessageCardWidget({
    super.key,
    required this.personImage,
    required this.personName,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start, // garante alinhamento
          children: [
            ClipOval(
              child: Image.asset(
                personImage,
                width: 40,
                height: 40,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              // ocupa o espaço todo e deixa o texto quebrar
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    personName,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    message,
                    style: const TextStyle(fontSize: 12, color: Colors.white70),
                    maxLines: 2, // limita a 2 linhas (se quiseres mais, altera)
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Divider(color: Colors.white24, thickness: 1, height: 1),
      ],
    );
  }
}
