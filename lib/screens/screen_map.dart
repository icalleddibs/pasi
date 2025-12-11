import 'package:flutter/material.dart';
import 'supported_countries_map.dart';
import 'screen_passport.dart';
import 'screen_profile.dart';

// Example usage of countries_world_map package
// https://pub.dev/packages/countries_world_map/example
// https://examples.simplewidgets.dev/#/countries_world_map

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('World Map')),
      body: Center(
        child: SupportedCountriesMap(),
        //child: SimpleMap(
          //instructions: SMapWorld.instructions,   // <- THIS is the world map
          //defaultColor: Colors.grey.shade300,     // <- default color

        //),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Passport'),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Map'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        onTap: (index) {
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PassportScreen()),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProfileScreen()),
            );
          }
        },
      ),
    );
  }
}