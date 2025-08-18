import 'package:flutter/material.dart';
import 'package:sportsocial/widgets/CustomTextField.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'Edit Profile',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Avatar centrado em cima
            Stack(
              children: [
                const CircleAvatar(
                  radius: 48,
                  backgroundImage: AssetImage(
                    '/Users/diogodemouramarques/Desktop/SpotsApp/sportsocial/assets/person1.jpg',
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: CircleAvatar(
                    radius: 14,
                    backgroundColor: Colors.red,
                    child: const Icon(Icons.add, color: Colors.white, size: 18),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Campos de texto
            const CustomTextField(label: "Full Name", value: "Curtney Henry"),
            const SizedBox(height: 16),

            const CustomTextField(label: "Email", value: "henry@gmail.com"),
            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(child: CustomTextField(label: "Age", value: "25")),
                const SizedBox(width: 12),
                Expanded(child: CustomTextField(label: "Height", value: "190")),
              ],
            ),
            const SizedBox(height: 16),
            const CustomTextField(label: "Sports", value: "Football"),
            const SizedBox(height: 16),
            const CustomTextField(label: "Club", value: "FC Porto"),
            const SizedBox(height: 16),
            const CustomTextField(label: "Position", value: "Striker"),
          ],
        ),
      ),

      // Botão no fundo
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: GestureDetector(
          onTap: () {
            // aqui colocas a lógica de update
            print("Update Profile pressed");
          },
          child: Container(
            height: 55,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Colors.redAccent, Colors.red],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(40),
              boxShadow: [
                BoxShadow(
                  color: Colors.red.withOpacity(0.4),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Center(
              child: Text(
                "Update Profile",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
