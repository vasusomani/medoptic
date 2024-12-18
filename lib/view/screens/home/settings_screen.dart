import 'package:flutter/material.dart';

import '../../../Constants/colors.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: Theme.of(context)
              .textTheme
              .headlineMedium
              ?.copyWith(color: Colors.white),
        ),
        backgroundColor: CustomColors.primaryColor,
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        children: [
          SizedBox(height: 10),
          _buildOption(
            context,
            title: 'Change Language (English)',
            onTap: () {
              // Handle change language
            },
          ),
          _buildOption(
            context,
            title: 'About Us',
            onTap: () {
              // Handle about
            },
          ),
          _buildOption(
            context,
            title: 'Log Out',
            onTap: () => _showConfirmationDialog(
              context,
              title: 'Log Out',
              content: 'Are you sure you want to log out?',
              onConfirm: () {
                // Handle log out
              },
            ),
            isDangerous: true,
          ),
          _buildOption(
            context,
            title: 'Delete Account',
            onTap: () => _showConfirmationDialog(
              context,
              title: 'Delete Account',
              content: 'Are you sure you want to delete your account?',
              onConfirm: () {
                // Handle delete account
              },
            ),
            isDangerous: true,
          ),
        ],
      ),
    );
  }

  Widget _buildOption(BuildContext context,
      {required String title,
      required VoidCallback onTap,
      bool isDangerous = false}) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
            color: (isDangerous) ? Colors.red : CustomColors.secondaryColor),
        borderRadius: BorderRadius.circular(5),
      ),
      margin: const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
            color: isDangerous
                ? Colors.red
                : Theme.of(context).textTheme.bodyText1?.color,
          ),
        ),
        onTap: onTap,
      ),
    );
  }

  void _showConfirmationDialog(BuildContext context,
      {required String title,
      required String content,
      required VoidCallback onConfirm}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          content: Text(content),
          actions: [
            TextButton(
              child: Text(
                'Cancel',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: CustomColors.contrastColor1,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                'Confirm',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              onPressed: () {
                // prescriptions.removeAt(index);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
