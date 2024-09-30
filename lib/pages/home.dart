import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:untitled/pages/NextPage.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome to Your Recipe App',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Image.asset(
              'assets/Logo.png', // Replace with the actual path to your image
              width: 350,
              height: 350,
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                // Navigate to the next page when the button is pressed
                Navigator.of(context).push(
                  PageTransition(
                    type: PageTransitionType.bottomToTop, // Specify the scroll-down animation type
                    child: const NextPage(),
                  ),
                );
              },
              child: const Text(
                'Start',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                  color: Colors.deepOrange,
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await deleteDatabaseFile();
              },
              child: const Text(
                'Delete Database',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> deleteDatabaseFile() async {
  // Get the path to the database
  String path = join(await getDatabasesPath(), 'recipes.db');

  // Check if the database file exists
  if (await File(path).exists()) {
    // Delete the database file
    await deleteDatabase(path);
    print('Database deleted successfully.');
  } else {
    print('Database file does not exist.');
  }
}
