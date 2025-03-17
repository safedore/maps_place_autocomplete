library maps_place_autocomplete;

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

class MapsPlaceAutocomplete {
  MapsPlaceAutocomplete(
      {required this.apiKey, this.onTap});
  final String apiKey;
  final Function(dynamic)? onTap;

  Future<List> getSuggestionList(String input, String sessionToken) async {
    String placesApiKey = apiKey;
    String baseURL = 'https://places.googleapis.com/v1/places:autocomplete/';
    var response = await http.post(Uri.parse(baseURL), body: {
      'sessionToken': sessionToken,
      'input': input,
    }, headers: {
      "X-Goog-Api-Key": placesApiKey
    });
    if (response.statusCode == 200) {
      if (json.decode(response.body)['suggestions'] != null) {
        final suggestions = await json.decode(response.body)['suggestions'];
        return suggestions;
      }
      return [];
    } else {
      log('${jsonDecode(response.body)['error']['message']}');
      return [];
    }
  }
}