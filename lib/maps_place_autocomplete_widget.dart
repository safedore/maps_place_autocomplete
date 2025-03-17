import 'package:flutter/material.dart';
import 'package:maps_place_autocomplete/maps_place_autocomplete.dart';

class PlaceSuggestionWidget extends StatelessWidget {
  final String apiKey;
  final String input;
  final String sessionToken;
  final Function(dynamic)? onTap;
  final Widget? errorWidget;

  const PlaceSuggestionWidget({super.key,
    required this.apiKey,
    required this.input,
    required this.sessionToken,
    this.onTap,
    this.errorWidget,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: MapsPlaceAutocomplete(apiKey: apiKey).getSuggestionList(input, sessionToken),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          // If there is an error fetching data
          return errorWidget ?? Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          // If no data or empty data
          return errorWidget ?? const Center(child: Text('No suggestions available.'));
        } else {
          // Once data is available, display it
          List<dynamic> suggestions = snapshot.data!;
          return ListView.separated(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: suggestions.length,
            separatorBuilder: (context, pos) => const Divider(),
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () async {
                  if (onTap != null) onTap!(suggestions[index]);
                },
                child: Container(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      const Icon(Icons.location_on),
                      const SizedBox(width: 9),
                      if (suggestions[index]['placePrediction']['text'] != null) ...[
                        Expanded(child: Text("${suggestions[index]['placePrediction']['text']['text'] ?? ""}")),
                      ],
                    ],
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}