import 'package:flutter/material.dart';

class CountryDetailScreen extends StatelessWidget {
  final String countryName;

  const CountryDetailScreen({
    super.key,
    required this.countryName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(countryName)),
      body: const Center(
        child: Text(
          'Cities, photos, notes, and country map will go here',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
