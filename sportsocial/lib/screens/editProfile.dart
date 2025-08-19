import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:sportsocial/widgets/CustomTextField.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final String name = "Edit Profile";
  final String email = "henry@gmail.com";
  final int age = 25;
  final int height = 190;
  final String sports = "Football";
  final String club = "FC Porto";
  final String position = "Striker";

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref("users");

  Future<void> _saveData() async {
    User? user = _auth.currentUser;

    if (user != null) {
      await _dbRef.child(user.uid).set({
        'name': name,
        'email': email,
        'age': age,
        'height': height,
        'sports': sports,
        'club': club,
        'position': position,
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Erro: utilizador não autenticado."),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

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
            CustomTextField(label: "Full Name", value: name),
            const SizedBox(height: 16),
            CustomTextField(label: "Email", value: email),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: CustomTextField(label: "Age", value: age.toString()),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: CustomTextField(
                    label: "Height",
                    value: height.toString(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            CustomTextField(label: "Sports", value: sports),
            const SizedBox(height: 16),
            CustomTextField(label: "Club", value: club),
            const SizedBox(height: 16),
            CustomTextField(label: "Position", value: position),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: GestureDetector(
          onTap: () async {
            await _saveData();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Profile updated successfully!"),
                backgroundColor: Colors.green,
              ),
            );
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
