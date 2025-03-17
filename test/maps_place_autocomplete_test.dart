import 'package:flutter_test/flutter_test.dart';
import 'package:maps_place_autocomplete/maps_place_autocomplete.dart';

void main() {
  test('Test _getSuggestionTest function', () async {

    final mapsPlaceAutocomplete = MapsPlaceAutocomplete(
      apiKey: 'api_key',
    );

    final result = await mapsPlaceAutocomplete.getSuggestionList('New', 'session_token');

    // Check that the result is as expected
    expect(result, isList);
    expect(result.isNotEmpty, true);
  });
}
