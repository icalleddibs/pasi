// add only countries that have been visited along with visit dates

final Map<String, dynamic> countryData = {
  // NORTH AMERICA ---------------------------------------------------------------------------------------------------------------------------------
  // canada
  'ca': {
    'name': 'Canada',
    'visited': true,
    'dates': [ //temp
      DateTime(2018, 6, 12),
      DateTime(2022, 8, 4),
      DateTime(2023, 12, 25),
      DateTime(2024, 5, 1),
      DateTime(2024, 6, 15),
    ],
    'visitedStates': ['Ontario', 'Quebec', 'Alberta', 'British Columbia', 'Saskatchewan', 'Manitoba', 'Yukon'],
  },
  // united states
  'us': {
    'name': 'United States',
    'visited': true,
    'dates': [],
    'visitedStates': ['Alaska', 'California', 'Hawaii', 'New York', 'Washington', 'Maryland', 'Florida', 'Massachusetts', 'Philadelphia', 'New Jersey', 'South Dakota', 'North Dakota', 'Illinois', 'Nevada', 'Arizona', 'Georgia', 'Michigan'],
  },
  // mexico
  'mx': {
    'name': 'Mexico',
    'visited': true,
    'dates': [],
    'visitedStates': ['Yucatán', 'México', 'Quintana Roo'],
  },
  // CARIBBEAN ---------------------------------------------------------------------------------------------------------------------------------
  // dominica 
  'dm': {
    'name': 'Dominica',
    'visited': true,
    'dates': [],
    'visitedStates': [],
  },
  // dominican republic
  'do': {
    'name': 'Dominican Republic',
    'visited': true,
    'dates': [],
    'visitedStates': [],
  },
  // grenada
  'gd': {
    'name': 'Grenada',
    'visited': true,
    'dates': [],
    'visitedStates': [],
  },
  // bonaire, sint eustatius and saba
  'bq': {
    'name': 'Bonaire, Sint Eustatius and Saba',
    'visited': true,
    'dates': [],
    'visitedStates': [],
  },
  // sint maarten
  'sx': {
    'name': 'Sint Maarten',
    'visited': true,
    'dates': [],
    'visitedStates': [],
  },
  // st kitts and nevis
  'kn': {
    'name': 'St Kitts and Nevis',
    'visited': true,
    'dates': [],
    'visitedStates': [],
  },
  // anguilla
  'ai': {
    'name': 'Anguilla',
    'visited': true,
    'dates': [],
    'visitedStates': [],
  },
  // antigua and barbuda
  'ag': {
    'name': 'Antigua and Barbuda',
    'visited': true,
    'dates': [],
    'visitedStates': [],
  },
  // st. lucia
  'lc': {
    'name': 'St. Lucia',
    'visited': true,
    'dates': [],
    'visitedStates': [],
  },
  // trinidad and tobago
  'tt': {
    'name': 'Trinidad and Tobago',
    'visited': true,
    'dates': [],
    'visitedStates': [],
  },
  // british virgin islands
  'vg': {
    'name': 'British Virgin Islands',
    'visited': true,
    'dates': [],
    'visitedStates': [],
  },
  // st. vincent and the grenadines
  'vc': {
    'name': 'St. Vincent and the Grenadines',
    'visited': true,
    'dates': [],
    'visitedStates': [],
  },
  // cayman islands
  'ky': {
    'name': 'Cayman Islands',
    'visited': true,
    'dates': [],
    'visitedStates': [],
  },
  // haiti
  'ht': {
    'name': 'Haiti',
    'visited': true,
    'dates': [],
    'visitedStates': [],
  },
  // barbados
  'bb': {
    'name': 'Barbados',
    'visited': true,
    'dates': [],
    'visitedStates': [],
  },
  // bahamas
  'bs': {
    'name': 'Bahamas',
    'visited': true,
    'dates': [],
    'visitedStates': [],
  },
  // aruba
  'aw': {
    'name': 'Aruba',
    'visited': true,
    'dates': [],
    'visitedStates': [],
  },
  // jamaica
  'jm': {
    'name': 'Jamaica',
    'visited': true,
    'dates': [],
    'visitedStates': ['Kingston'],
  },
  // CENTRAL AMERICA ---------------------------------------------------------------------------------------------------------------------------------
  // belize
  'bz': {
    'name': 'Belize',
    'visited': true,
    'dates': [],
    'visitedStates': [],
  },
  // honduras
  'hn': {
    'name': 'Honduras',
    'visited': true,
    'dates': [],
    'visitedStates': ['Islas de la Bahía'],
  },
  // EUROPE ---------------------------------------------------------------------------------------------------------------------------------
  // greece
  'gr': {
    'name': 'Greece',
    'visited': true,
    'dates': [],
    'visitedStates': ['Attica', 'South Aegean'],
  },
  // italy
  'it': {
    'name': 'Italy',
    'visited': true,
    'dates': [],
    'visitedStates': ['Lazio', 'Toscana', 'Campania', 'Veneto', 'Puglia', 'Liguria'],
  },
  // albania
  'al': {
    'name': 'Albania',
    'visited': true,
    'dates': [],
    'visitedStates': [],
  },
  // croatia
  'hr': {
    'name': 'Croatia',
    'visited': true,
    'dates': [],
    'visitedStates': ['Zagrebačka županija', 'Dubrovačko-neretvanska županija'],
  },
  // united kingdom
  'gb': {
    'name': 'United Kingdom',
    'visited': true,
    'dates': [],
    'visitedStates': ['Greater London', 'South West', 'South East'],
  },
  // france
  'fr': {
    'name': 'France',
    'visited': true,
    'dates': [ //temp
      DateTime(2019, 6, 12),
      DateTime(2020, 7, 15),
      DateTime(2021, 8, 20),
      DateTime(2021, 9, 4),
      DateTime(2022, 5, 10),
      DateTime(2023, 4, 18),
      DateTime(2024, 3, 22),
      DateTime(2024, 6, 5),
    ],
    'visitedStates': ['Île-de-France', 'Provence-Alpes-Côte d\'Azur'],
  },
  // spain
  'es': {
    'name': 'Spain',
    'visited': true,
    'dates': [],
    'visitedStates': ['Catalonia', 'Balearic Islands'],
  },
  // portugal
  'pt': {
    'name': 'Portugal',
    'visited': true,
    'dates': [],
    'visitedStates': ['Lisbon', 'Porto', 'Santarém', 'Leiria', 'Aveiro'],
  },
  // the netherlands
  'nl': {
    'name': 'The Netherlands',
    'visited': true,
    'dates': [],
    'visitedStates': ['Noord-Holland', 'Utrecht', 'Zuid-Holland', 'Overijssel'],
  },
  // germany
  'de': {
    'name': 'Germany',
    'visited': true,
    'dates': [],
    'visitedStates': ['North Rhine-Westphalia'],
  },
  // belgium
  'be': {
    'name': 'Belgium',
    'visited': true,
    'dates': [],
    'visitedStates': ['Brussels Capital Region', 'Antwerp', 'West Flanders'],
  },
  // ASIA ---------------------------------------------------------------------------------------------------------------------------------
  // japan
  'jp': {
    'name': 'Japan',
    'visited': true,
    'dates': [],
    'visitedStates': ['Tokyo', 'Kyoto', 'Osaka', 'Hokkaido', 'Hiroshima', 'Nara', 'Nagano', 'Fukushima'],
  },
  // south korea
  'kr': {
    'name': 'South Korea',
    'visited': true,
    'dates': [],
    'visitedStates': ['Seoul', 'Incheon', 'Gangwon'],
  },
  // MIDDLE EAST ---------------------------------------------------------------------------------------------------------------------------------
  // united arab emirates
  'ae': {
    'name': 'United Arab Emirates',
    'visited': true,
    'dates': [],
    'visitedStates': ['Dubayy', 'Abū Z̧aby', 'Ash Shāriqah', 'Al Fujayrah', 'Musandam, Oman'],
  },
  // oman
  'om': {
    'name': 'Oman',
    'visited': true,
    'dates': [],
    'visitedStates': ['Musandam', 'Ash Shāriqah', 'Dubayy', 'Al Fujayrah'],
  },
};