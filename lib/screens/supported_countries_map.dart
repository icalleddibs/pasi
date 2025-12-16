// ignore_for_file: use_super_parameters, library_private_types_in_public_api

import 'dart:convert';
import 'dart:math';

import 'package:countries_world_map/countries_world_map.dart';
import 'package:countries_world_map/data/maps/world_map.dart';
import 'package:flutter/material.dart';
import 'package:pasi/data/country_data.dart';
import 'package:pasi/designs/postcard_border.dart';

class SupportedCountriesMap extends StatefulWidget {
  const SupportedCountriesMap({Key? key}) : super(key: key);

  @override
  _SupportedCountriesMapState createState() => _SupportedCountriesMapState();
}

final Random _random = Random();
final List<Color> randomColors = [
  const Color.fromARGB(255, 21, 86, 25),
  const Color.fromARGB(255, 34, 105, 38),
  Colors.green.shade700,
  Colors.green.shade600,
  Colors.green.shade400,
  Colors.green.shade300,
  const Color.fromARGB(255, 155, 214, 158),
];

class _SupportedCountriesMapState extends State<SupportedCountriesMap> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: InteractiveViewer(
            maxScale: 75.0,
            child: Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.92,
                  // Actual widget from the Countries_world_map package.
                  child: SimpleMap(
                    instructions: SMapWorld.instructions, // <- THIS is the world map
                    defaultColor: Colors.grey.shade300, // <- default color
                    colors: countryData.map<String, Color?>(
                      (key, value) => MapEntry(
                        key,
                        value['visited'] == true
                            ? randomColors[_random.nextInt(randomColors.length)]
                            : null,
                      ),
                    ),
                    callback: (id, name, tapDetails) {
                      goToCountry(id);
                    },
                  ),
                ),
                // Creates 8% from right side so the map looks more centered.
                Container(width: MediaQuery.of(context).size.width * 0.08),
              ],
            ),
          ),
        ),
        Positioned(
            bottom: 36,
            left: 0,
            right: 0,
            child: Text('Tap on a country to read its details and blog posts!',
                style: TextStyle(fontSize: 18), textAlign: TextAlign.center)),
      ],
    );
  }

  void goToCountry(String country) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CountryPage(country: country),
      ),
    );
  }
}

class CountryPage extends StatefulWidget {
  final String country;

  const CountryPage({required this.country, Key? key}) : super(key: key);

  @override
  _CountryPageState createState() => _CountryPageState();
}

class _CountryPageState extends State<CountryPage> {
  late String state;
  late String instruction;

  late List<Map<String, dynamic>> properties;

  late Map<String, Color?> keyValuesPaires;

  @override
  void initState() {
    super.initState();

    instruction = getInstructions(widget.country);

    if (instruction != "NOT SUPPORTED") {
      properties = getProperties(instruction, widget.country);
      properties.sort((a, b) => a['name'].compareTo(b['name']));

      // Initialize colors based on 'checkedState'
      keyValuesPaires = {};
      for (var element in properties) {
        keyValuesPaires[element['id']] = element['color'];
      }

    // MOVE THIS STATISTIC SOMEWHERE ELSE
      state = '${properties.where((prop) => prop['color'] != null).length} / ${properties.length} visited';
    } else {
      state = 'This country is not supported';
    }
  }

  @override
  Widget build(BuildContext context) {
    // Widget for the list of properties
    Widget propertyList() {
  return ListView.builder(
    padding: EdgeInsets.zero,
    itemCount: properties.length + 1,
    itemBuilder: (context, i) {
      // home tab for each list, separate from list built by properties (provinces)
      if (i == 0) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: ClipPath(
          clipper: RibbonClipper(),
          child: Container(
            color: const Color.fromARGB(255, 236, 178, 92),
            height: 35, // height of each ribbon
            child: Padding(
              // pushes content away from the left ribbon notch
              padding: const EdgeInsets.only(left: 22, right: 2),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Overview",
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }

      final int j = i - 1; // remaining index for properties list
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4), // space between ribbons
        child: ClipPath(
          clipper: RibbonClipper(), // these are the ribbons that each of the tiles is gonna go in
          child: Container(
            color: properties[j]['color'] ?? const Color.fromARGB(255, 199, 199, 199),
            height: 35, // height of each ribbon
            child: Padding(
              // pushes content away from the left ribbon notch
              padding: const EdgeInsets.only(left: 24, right: 6),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  properties[j]['id'],
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        )
      );
    },
  );
}


    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 190, 190, 190),
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.blue.shade800),
        title: Text(
          // ignore: prefer_interpolation_to_compose_strings
          (countryData[widget.country]?['name'] ?? 'Unknown Country'),
          style: TextStyle(color: Colors.blue.shade800),
        ),
      ),
      body: instruction == "NOT SUPPORTED"
          ? Center(child: Text("This country is not supported! Will just display a bare page with no states/provinces added. Need to get a close up version of the map."))
          : Column(
              children: [
                // Map + optional side panel for wide screens
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: EdgeInsets.only(top: 75, bottom: 75, left: 60, right: 50),
                            child: FractionallySizedBox(
                              widthFactor: 1.0,
                              heightFactor: 0.8,
                            child: PostcardContainer(
                              strokeWidth: 36,
                              borderRadius: 16,
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment(-0.1, -0.2),
                                tileMode: TileMode.repeated,
                                stops: [
                                        0.00, 0.05, 0.05, 0.10, 0.10, 0.15, 0.15, 0.20,
                                        0.20, 0.25, 0.25, 0.30, 0.30, 0.35, 0.35, 0.40,
                                        0.40, 0.45, 0.45, 0.50, 0.50, 0.55, 0.55, 0.60,
                                        0.60, 0.65, 0.65, 0.70, 0.70, 0.75, 0.75, 0.80,
                                        0.80, 0.85, 0.85, 0.90, 0.90, 0.95, 0.95, 1.00,
                                      ],
                                colors: [
                                  const Color.fromARGB(255, 255, 23, 23),
                                  const Color.fromARGB(255, 255, 23, 23),
                                  Colors.white,
                                  Colors.white,
                                  const Color.fromARGB(255, 19, 66, 147),
                                  const Color.fromARGB(255, 19, 66, 147),
                                  Colors.white,
                                  Colors.white,
                                  const Color.fromARGB(255, 255, 23, 23),
                                  const Color.fromARGB(255, 255, 23, 23),
                                  Colors.white,
                                  Colors.white,
                                  const Color.fromARGB(255, 19, 66, 147),
                                  const Color.fromARGB(255, 19, 66, 147),
                                  Colors.white,
                                  Colors.white,
                                  const Color.fromARGB(255, 255, 23, 23),
                                  const Color.fromARGB(255, 255, 23, 23),
                                  Colors.white,
                                  Colors.white,
                                  const Color.fromARGB(255, 19, 66, 147),
                                  const Color.fromARGB(255, 19, 66, 147),
                                  Colors.white,
                                  Colors.white,
                                  const Color.fromARGB(255, 255, 23, 23),
                                  const Color.fromARGB(255, 255, 23, 23),
                                  Colors.white,
                                  Colors.white,
                                  const Color.fromARGB(255, 19, 66, 147),
                                  const Color.fromARGB(255, 19, 66, 147),
                                  Colors.white,
                                  Colors.white,
                                  const Color.fromARGB(255, 255, 23, 23),
                                  const Color.fromARGB(255, 255, 23, 23),
                                  Colors.white,
                                  Colors.white,
                                  const Color.fromARGB(255, 19, 66, 147),
                                  const Color.fromARGB(255, 19, 66, 147),
                                  Colors.white,
                                  Colors.white,
                                ],
                              ),
                              child: Container(
                                color: Colors.white,
                                width: 700,   // fixed postcard size
                                height: 400,
                                padding: EdgeInsets.all(24),

                                child: Row(
                                  children: [

                                    /// LEFT COLUMN — MAP
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        color: Colors.white,
                                        child: SimpleMap(
                                          defaultColor: Colors.grey.shade300,
                                          key: Key(properties.toString()),
                                          colors: keyValuesPaires,
                                          instructions: instruction,
                                        ),
                                      ),
                                    ),

                                    /// SEPARATOR LINE
                                    Container(
                                      width: 2,
                                      margin: EdgeInsets.symmetric(horizontal: 24),
                                      color: Colors.black12, // thin grey line
                                    ),

                                    /// RIGHT COLUMN — TEXT
                                    Expanded(
                                      flex: 1, 
                                      child: Container(
                                        color: Colors.white,
                                        padding: const EdgeInsets.all(8),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            // stamp image at the top (to be resized), make sure to name properly by country code
                                            Image.asset(
                                              "assets/stamps/stamp_${widget.country}.png",
                                              height: 120,
                                              fit: BoxFit.contain,
                                            ),
                                            const SizedBox(height: 16),
                                            Text(
                                              "${countryData[widget.country]?['name'] ?? 'Unknown Country'}",
                                              style: const TextStyle(
                                                fontSize: 20,
                                                height: 1.4,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Divider(
                                              thickness: 1,
                                              height: 20,      // vertical space around it
                                              color: Colors.black12,
                                            ),
                                            Text(
                                              state,
                                              style: const TextStyle(
                                                fontSize: 20,
                                                height: 1.4,
                                              ),
                                            ),
                                            Divider(
                                              thickness: 1,
                                              height: 20,      // vertical space around it
                                              color: Colors.black12,
                                            ),
                                            Text(
                                              "More details TBA...",
                                              style: const TextStyle(
                                                fontSize: 20,
                                                height: 1.4,
                                              ),
                                            ),
                                            Divider(
                                              thickness: 1,
                                              height: 20,      // vertical space around it
                                              color: Colors.black12,
                                            ),
                                            Text(
                                              "...",
                                              style: const TextStyle(
                                                fontSize: 20,
                                                height: 1.4,
                                              ),
                                            ),
                                            Divider(
                                              thickness: 1,
                                              height: 20,      // vertical space around it
                                              color: Colors.black12,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ),
                          ),
                        ),
                      ),
                      if (MediaQuery.of(context).size.width > 800)
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 16, top: 50, bottom: 50, right: 20),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                // LEFT: ribbon list (NO background)
                                SizedBox(
                                  width: 80,
                                  child: propertyList(),
                                ),

                                // RIGHT: content card (rounded box)
                                Expanded(
                                  child: Card(
                                    elevation: 8,
                                    color: Colors.brown.shade100,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(topRight: Radius.circular(16), bottomRight: Radius.circular(16)),
                                      side: const BorderSide(color: Colors.brown, width: 5),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: Text(
                                        'Right-side content goes here',
                                        style: Theme.of(context).textTheme.bodyLarge,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Bottom panel for narrow screens. Needs to be redesigned afterwards.
                  if (MediaQuery.of(context).size.width <= 800)
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: Card(
                        margin: const EdgeInsets.all(16),
                        elevation: 8,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // LEFT: ribbon list (constrained width)
                            SizedBox(
                              width: 80,
                              child: propertyList(),
                            ),

                            // RIGHT: future content
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Text(
                                  'Right-side content goes here',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }

    List<Map<String, dynamic>> getProperties(String input, String countryId) {
    Map<String, dynamic> instructions = json.decode(input);
    List paths = instructions['i'];

    // Pull checked states from your external data source
    List visitedStates = countryData[widget.country]?['visitedStates'] ?? [];

    List<Map<String, dynamic>> properties = [];

    for (var element in paths) {
      String stateName = element['n'];
      bool isVisited = visitedStates.contains(stateName);
      Color? assignedColor =
          isVisited ? randomColors[_random.nextInt(randomColors.length)] : null;
      properties.add({
        'name': stateName,
        'id': element['u'],
        'visitedState': visitedStates.contains(stateName), // true if visited
        'color': assignedColor,
      });
    }

    return properties;
  }

  // listing out all the countries and setting them to return instructions
  String getInstructions(String id) {
    switch (id) {
      case 'ar':
        return SMapArgentina.instructions;

      case 'at':
        return SMapAustria.instructions;

      case 'ad':
        return SMapAndorra.instructions;

      case 'ao':
        return SMapAngola.instructions;

      case 'am':
        return SMapArmenia.instructions;

      case 'au':
        return SMapAustralia.instructions;

      case 'az':
        return SMapAzerbaijan.instructions;

      case 'bs':
        return SMapBahamas.instructions;

      case 'bh':
        return SMapBahrain.instructions;

      case 'bd':
        return SMapBangladesh.instructions;

      case 'by':
        return SMapBelarus.instructions;

      case 'be':
        return SMapBelgium.instructions;

      case 'bt':
        return SMapBhutan.instructions;

      case 'bo':
        return SMapBolivia.instructions;

      case 'bw':
        return SMapBotswana.instructions;

      case 'br':
        return SMapBrazil.instructions;

      case 'bn':
        return SMapBrunei.instructions;

      case 'bg':
        return SMapBulgaria.instructions;

      case 'bf':
        return SMapBurkinaFaso.instructions;

      case 'bi':
        return SMapBurundi.instructions;

      case 'ca':
        return SMapCanada.instructions;

      case 'cm':
        return SMapCameroon.instructions;

      case 'cf':
        return SMapCentralAfricanRepublic.instructions;

      case 'cv':
        return SMapCapeVerde.instructions;

      case 'td':
        return SMapChad.instructions;

      case 'cn':
        return SMapChina.instructions;

      case 'ch':
        return SMapSwitzerland.instructions;

      case 'cd':
        return SMapCongoDR.instructions;

      case 'cg':
        return SMapCongoBrazzaville.instructions;

      case 'co':
        return SMapColombia.instructions;

      case 'cr':
        return SMapCostaRica.instructions;

      case 'hr':
        return SMapCroatia.instructions;

      case 'cu':
        return SMapCuba.instructions;

      case 'cl':
        return SMapChile.instructions;

      case 'ci':
        return SMapIvoryCoast.instructions;

      case 'cy':
        return SMapCyprus.instructions;

      case 'cz':
        return SMapCzechRepublic.instructions;

      case 'dk':
        return SMapDenmark.instructions;

      case 'dj':
        return SMapDjibouti.instructions;

      case 'do':
        return SMapDominicanRepublic.instructions;

      case 'ec':
        return SMapEcuador.instructions;

      case 'es':
        return SMapSpain.instructions;

      case 'eg':
        return SMapEgypt.instructions;

      case 'et':
        return SMapEthiopia.instructions;

      case 'sv':
        return SMapElSalvador.instructions;

      case 'ee':
        return SMapEstonia.instructions;

      case 'fo':
        return SMapFaroeIslands.instructions;

      case 'fi':
        return SMapFinland.instructions;

      case 'fr':
        return SMapFrance.instructions;

      case 'gb':
        return SMapUnitedKingdom.instructions;

      case 'ge':
        return SMapGeorgia.instructions;

      case 'de':
        return SMapGermany.instructions;

      case 'gr':
        return SMapGreece.instructions;

      case 'gt':
        return SMapGuatemala.instructions;

      case 'gn':
        return SMapGuinea.instructions;

      case 'hi':
        return SMapHaiti.instructions;

      case 'hk':
        return SMapHongKong.instructions;

      case 'hn':
        return SMapHonduras.instructions;

      case 'hu':
        return SMapHungary.instructions;

      case 'in':
        return SMapIndia.instructions;

      case 'id':
        return SMapIndonesia.instructions;

      case 'il':
        return SMapIsrael.instructions;

      case 'ir':
        return SMapIran.instructions;

      case 'iq':
        return SMapIraq.instructions;

      case 'ie':
        return SMapIreland.instructions;

      case 'it':
        return SMapItaly.instructions;

      case 'jm':
        return SMapJamaica.instructions;

      case 'jp':
        return SMapJapan.instructions;

      case 'kz':
        return SMapKazakhstan.instructions;

      case 'ke':
        return SMapKenya.instructions;

      case 'xk':
        return SMapKosovo.instructions;

      case 'kg':
        return SMapKyrgyzstan.instructions;

      case 'la':
        return SMapLaos.instructions;

      case 'lv':
        return SMapLatvia.instructions;

      case 'li':
        return SMapLiechtenstein.instructions;

      case 'lt':
        return SMapLithuania.instructions;

      case 'lu':
        return SMapLuxembourg.instructions;

      case 'mk':
        return SMapMacedonia.instructions;

      case 'ml':
        return SMapMali.instructions;

      case 'mt':
        return SMapMalta.instructions;

      case 'mz':
        return SMapMozambique.instructions;

      case 'mx':
        return SMapMexico.instructions;

      case 'md':
        return SMapMoldova.instructions;

      case 'me':
        return SMapMontenegro.instructions;

      case 'ma':
        return SMapMorocco.instructions;

      case 'mm':
        return SMapMyanmar.instructions;

      case 'my':
        return SMapMalaysia.instructions;

      case 'na':
        return SMapNamibia.instructions;

      case 'np':
        return SMapNepal.instructions;

      case 'nl':
        return SMapNetherlands.instructions;

      case 'nz':
        return SMapNewZealand.instructions;

      case 'ni':
        return SMapNicaragua.instructions;

      case 'ng':
        return SMapNigeria.instructions;

      case 'no':
        return SMapNorway.instructions;

      case 'om':
        return SMapOman.instructions;

      case 'ps':
        return SMapPalestine.instructions;

      case 'pk':
        return SMapPakistan.instructions;

      case 'ph':
        return SMapPhilippines.instructions;

      case 'pa':
        return SMapPanama.instructions;

      case 'pe':
        return SMapPeru.instructions;

      case 'pr':
        return SMapPuertoRico.instructions;

      case 'py':
        return SMapParaguay.instructions;

      case 'pl':
        return SMapPoland.instructions;

      case 'pt':
        return SMapPortugal.instructions;

      case 'qa':
        return SMapQatar.instructions;

      case 'ro':
        return SMapRomania.instructions;

      case 'ru':
        return SMapRussia.instructions;

      case 'rw':
        return SMapRwanda.instructions;

      case 'sa':
        return SMapSaudiArabia.instructions;

      case 'rs':
        return SMapSerbia.instructions;

      case 'sd':
        return SMapSudan.instructions;

      case 'sg':
        return SMapSingapore.instructions;

      case 'sl':
        return SMapSierraLeone.instructions;

      case 'sk':
        return SMapSlovakia.instructions;

      case 'si':
        return SMapSlovenia.instructions;

      case 'kr':
        return SMapSouthKorea.instructions;

      case 'lk':
        return SMapSriLanka.instructions;

      case 'se':
        return SMapSweden.instructions;

      case 'sy':
        return SMapSyria.instructions;

      case 'tw':
        return SMapTaiwan.instructions;

      case 'tj':
        return SMapTajikistan.instructions;

      case 'th':
        return SMapThailand.instructions;

      case 'tr':
        return SMapTurkey.instructions;

      case 'ug':
        return SMapUganda.instructions;

      case 'ua':
        return SMapUkraine.instructions;

      case 'ae':
        return SMapUnitedArabEmirates.instructions;

      case 'us':
        return SMapUnitedStates.instructions;

      case 'uy':
        return SMapUruguay.instructions;

      case 'uz':
        return SMapUzbekistan.instructions;

      case 've':
        return SMapVenezuela.instructions;

      case 'vn':
        return SMapVietnam.instructions;

      case 'ye':
        return SMapYemen.instructions;

      case 'za':
        return SMapSouthAfrica.instructions;

      case 'zm':
        return SMapZambia.instructions;

      case 'zw':
        return SMapZimbabwe.instructions;

      default:
        return 'NOT SUPPORTED';
    }
  }
}





