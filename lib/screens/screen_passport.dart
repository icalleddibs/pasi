import 'package:flutter/material.dart';
import 'package:turnable_page/turnable_page.dart';
import 'screen_map.dart';
import 'package:pasi/data/country_data.dart';

// Next Steps:
// - finish customizing the stamps in figma
  // - add date in figma, no need to do dynamically for now
  // - add stamps to assets\stamps folder, named as stamp_{countryCode}.png
  // - add the dates visited in country_data.dart for testing
// - start with a closed book to begin the homepage (and flip back to closed)
  // - possibly a passport page with ID and profile

class PassportPageData {
  final String countryCode; // 'ca', 'us'
  final DateTime visitDate;

  const PassportPageData({
    required this.countryCode,
    required this.visitDate,
  });
}

// build sorted list of all stamps from data page
List<PassportPageData> buildPassportPages() {
  final List<PassportPageData> pages = [];

  // get stamped based on being visited in countryData, coming from country_data.dart (customized data)
  // organize by date visited in the 'dates' parameter
  // currently chronological, can change.
  // so far temporary dates in canada and france in order to verify that flipping works when exceeding 12 stamps

  countryData.forEach((countryCode, data) {
    final List<DateTime> dates =
        (data['dates'] as List?)?.whereType<DateTime>().toList() ?? [];

    for (final date in dates) {
      pages.add(
        PassportPageData(
          countryCode: countryCode,
          visitDate: date,
        ),
      );
    }
  });

  // Sort chronologically
  pages.sort((a, b) => a.visitDate.compareTo(b.visitDate));
  return pages;
}

// Chunk the stamps into pages of 6
List<List<PassportPageData>> chunkPages(List<PassportPageData> allStamps, int perPage) {
  final List<List<PassportPageData>> pages = [];
  for (var i = 0; i < allStamps.length; i += perPage) {
    pages.add(
      allStamps.sublist(
        i,
        (i + perPage > allStamps.length) ? allStamps.length : i + perPage,
      ),
    );
  }
  return pages;
}

class PassportPage extends StatelessWidget {
  final List<PassportPageData> stamps;
  final double spacing;

  // this.spacing is the space between stamps and edges, need to adjust based on size of window later
  const PassportPage({super.key, required this.stamps, this.spacing = 36});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double pageWidth = constraints.maxWidth;
        final double pageHeight = constraints.maxHeight;
        final double stampWidth = (pageWidth - spacing * 3) / 2;  // 2 columns + spacing
        final double stampHeight = (pageHeight - spacing * 4) / 3; // 3 rows + spacing

        List<Widget> rows = [];
        for (int row = 0; row < 3; row++) {
          List<Widget> rowChildren = [];
          for (int col = 0; col < 2; col++) {
            int index = row * 2 + col;
            // here i will edit so that i can make a cover page always, or start with closed book maybe
            if (index < stamps.length) {
              rowChildren.add(
                SizedBox(
                  width: stampWidth,
                  height: stampHeight,
                  child: Padding(
                    padding: EdgeInsets.all(spacing / 2),
                    child: Image.asset(
                      'assets/stamps/stamp_${stamps[index].countryCode}.png', // make sure all stamps are using this naming convention
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              );
            } else {
              rowChildren.add(SizedBox(width: stampWidth, height: stampHeight));
            }
          }

          rows.add(
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: rowChildren,
            ),
          );

          if (row < 2) rows.add(SizedBox(height: spacing)); // vertical spacing between rows
        }

        return Container(
          color: Colors.white,
          padding: EdgeInsets.all(spacing),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: rows,
          ),
        );
      },
    );
  }
}

class PassportScreen extends StatefulWidget {
  const PassportScreen({super.key});

  @override
  State<PassportScreen> createState() => _PassportScreenState();
}

class _PassportScreenState extends State<PassportScreen> {
  int currentIndex = 0;
  late final List<PassportPageData> allStamps;
  late final List<List<PassportPageData>> pagesPerPage;

  @override
  void initState() {
    super.initState();
    allStamps = buildPassportPages();
    pagesPerPage = chunkPages(allStamps, 6); // 6 stamps per page because of the 3x2 layout
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Passport'),
      ),
      body: Center(
        child: AspectRatio(
          aspectRatio: 792 / 512, // this is the book shape but not pages, need to adjust figma background size to the page
          child: TurnablePage(
            pageCount: pagesPerPage.length,
            autoResponseSize: true,
            settings: FlipSettings(
              flippingTime: 700,
            ),
            builder: (context, pageIndex, constraints) {
              return PassportPage(stamps: pagesPerPage[pageIndex]);
            },
          ),
        ),
      ),

      // navigation bar, consistent across screens
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Passport',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        onTap: (index) {
          setState(() => currentIndex = index);

          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const MapScreen(),
              ),
            );
          }
        },
      ),
    );
  }
}