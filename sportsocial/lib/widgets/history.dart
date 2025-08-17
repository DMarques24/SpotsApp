import 'package:flutter/material.dart';

class HistoryWidget extends StatelessWidget {
  final String image;
  final String name;

  const HistoryWidget({super.key, required this.image, required this.name});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 61,
          height: 61,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: const Color.fromARGB(255, 255, 31, 68),
              width: 3,
            ),
          ),
          child: ClipOval(
            child: Image.asset(image, width: 55, height: 55, fit: BoxFit.cover),
          ),
        ),
        const SizedBox(height: 8),
        Text(name, style: const TextStyle(fontSize: 12, color: Colors.white)),
      ],
    );
  }
}
