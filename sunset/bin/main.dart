import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

Future<void> main() async {
  // Customize your location here
  final coordinates = {
    'lat': '49.19516303227709',
    'lng': '16.598947382646585',
  };

  final uri = Uri(
    scheme: 'https',
    host: 'api.sunrise-sunset.org',
    path: 'json',
    queryParameters: <String, String>{
      ...coordinates,
      'formatted': '0',
    },
  );

  try {
    final response = await http.get(uri).timeout(const Duration(seconds: 5));
    final format = DateFormat.Hm();

    final json = jsonDecode(response.body) as Map<String, dynamic>;
    final results = json['results'] as Map<String, dynamic>;

    final sunrise = DateTime.parse(results['sunrise'] as String).toLocal();
    final sunset = DateTime.parse(results['sunset'] as String).toLocal();

    print('️${format.format(sunrise)} — ${format.format(sunset)}');
  } catch (e) {
    print('☀️ ERROR');
  }
}
