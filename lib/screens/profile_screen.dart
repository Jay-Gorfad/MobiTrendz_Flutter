import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobitrendz/constants/app_constants.dart';
import 'package:mobitrendz/controllers/google_sign_in_controller.dart';
import 'package:mobitrendz/screens/adress_list_screen.dart';
import 'package:mobitrendz/screens/edit_profile_view.dart';
import 'package:mobitrendz/screens/signin_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String fullName = '';
  String email = '';
  String profilePicture = '';
  bool _isLoading = true;
  String? authType;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString('userId');
      authType = prefs.getString('authType');

      if (authType == 'Google') {
        User? user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          setState(() {
            fullName = user.displayName ?? '';
            email = user.email ?? '';
            profilePicture = user.photoURL ?? '';
            _isLoading = false;
          });
          return;
        }
      }

      if (userId == null) {
        Get.snackbar("Error", "User ID not found");
        return;
      }

      final response =
          await http.get(Uri.parse("${AppConstants.baseUrl}/users/$userId"));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          fullName = "${data['firstName'] ?? ''} ${data['lastName'] ?? ''}";
          email = data['email'] ?? '';
          profilePicture = data['profilePicture'] ?? '';
          _isLoading = false;
        });
      } else {
        setState(() => _isLoading = false);
        Get.snackbar("Error", "Failed to load user data");
      }
    } catch (e) {
      setState(() => _isLoading = false);
      Get.snackbar("Error", "Error: $e");
    }
  }

  void logout() async {
    final prefs = await SharedPreferences.getInstance();
    final authType = prefs.getString('authType');

    if (authType == 'Google') {
      final googleSignInController = Get.put(GoogleSignInController());
      await googleSignInController.signOut();
    }

    await prefs.remove('token');
    await prefs.remove('userId');
    await prefs.remove('authType');

    Get.snackbar(
      'Logged Out',
      'You have been logged out successfully!',
      backgroundColor: Colors.green,
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 2),
    );

    Get.offAll(() => const SignInScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text("Profile",
            style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold)),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                const SizedBox(height: 20),
                CircleAvatar(
                  radius: 50,
                  backgroundImage: profilePicture.isNotEmpty
                      ? NetworkImage(profilePicture)
                      : const AssetImage("assets/img/default_profile.png")
                          as ImageProvider,
                ),
                const SizedBox(height: 10),
                Text(fullName,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
                Text(email,
                    style:
                        TextStyle(fontSize: 14, color: Colors.grey.shade700)),
                const SizedBox(height: 20),
                const Divider(),

                // Edit Profile only if NOT Google
                if (authType != 'Google')
                  ProfileOption(
                    icon: Icons.person,
                    title: "Edit Profile",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const EditProfileView()),
                      );
                    },
                  ),

                ProfileOption(
                  icon: Icons.location_on,
                  title: "Address",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddressListView()),
                    );
                  },
                ),
                ProfileOption(
                    icon: Icons.logout,
                    title: "Logout",
                    color: Colors.red,
                    onTap: logout),
              ],
            ),
    );
  }
}

class ProfileOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color? color;
  final VoidCallback? onTap;

  const ProfileOption({
    required this.icon,
    required this.title,
    this.color,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: color ?? Colors.black),
      title: Text(title, style: TextStyle(color: color ?? Colors.black)),
      trailing:
          const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: onTap,
    );
  }
}
