import 'package:flutter/material.dart';
import 'screen_map.dart';

class PassportScreen extends StatefulWidget {
  const PassportScreen({super.key});

  @override
  PassportScreenState createState() => PassportScreenState();
}

class PassportScreenState extends State<PassportScreen> {
  // Stamp positions relative to the middle area
  final List<Offset> stampPositions = const [
    Offset(40, 80),
    Offset(160, 120),
    Offset(80, 240),
    Offset(200, 260),
    Offset(60, 380),
    Offset(180, 420),
  ];

  final Map<String, String> countryStamps = {
    "Japan": "assets/stamps/japan.png",
    "France": "assets/stamps/france.png",
    "Canada": "assets/stamps/canada.png",
  };

  List<String?> placedStamps = [null, null, null, null, null, null];

  int get nextEmptySlot => placedStamps.indexWhere((s) => s == null);

  int currentIndex = 0; // For BottomNavigationBar highlighting

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Passport'),
        actions: [
          IconButton(
            icon: const Icon(Icons.clear),
            tooltip: 'Clear all stamps',
            onPressed: _clearStamps,
          ),
        ],
      ),

      // Everything between AppBar and BottomNavigationBar
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                // Passport background
                Positioned.fill(
                  child: Image.asset(
                    'assets/images/book_bg.jpg',
                    fit: BoxFit.contain,
                  ),
                ),

                // Placed stamps
                for (int i = 0; i < placedStamps.length; i++)
                  if (placedStamps[i] != null)
                    Positioned(
                      left: stampPositions[i].dx,
                      top: stampPositions[i].dy,
                      child: Image.asset(
                        placedStamps[i]!,
                        width: 80,
                      ),
                    ),

                // "+" icon at next empty slot
                if (nextEmptySlot != -1)
                  Positioned(
                    left: stampPositions[nextEmptySlot].dx,
                    top: stampPositions[nextEmptySlot].dy,
                    child: GestureDetector(
                      onTap: _openCountryPicker,
                      child: const Icon(Icons.add, size: 70, color: Colors.red),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Passport'),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Map'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });

          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MapScreen()),
            );
          } else if (index == 2) {
            // Implement ProfileScreen similarly
          }
        },
      ),
    );
  }

  // Open bottom sheet to pick a country
  void _openCountryPicker() async {
    final selected = await showModalBottomSheet<String>(
      context: context,
      builder: (context) {
        return ListView(
          children: countryStamps.keys.map((country) {
            return ListTile(
              title: Text(country),
              onTap: () => Navigator.pop(context, country),
            );
          }).toList(),
        );
      },
    );

    if (selected != null && nextEmptySlot != -1) {
      setState(() {
        placedStamps[nextEmptySlot] = countryStamps[selected];
      });
    }
  }

  // Clear all stamps
  void _clearStamps() {
    setState(() {
      placedStamps = List.filled(placedStamps.length, null);
    });
  }
}
