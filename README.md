# maps_place_autocomplete

A Flutter package for integrating the Google Places Autocomplete API to provide place suggestions based on user input. This package simplifies using the Places Autocomplete API to fetch location search suggestions in your app.

## Features

- Fetches place suggestions based on user input.
- Displays suggestions in a widget when below code is called:
  ```
  PlaceSuggestionWidget(
    apiKey: 'apiKey', 
    input: input, 
    sessionToken: 'sessionToken', 
    onTap: (selectedData) {
       // do what you need here
    },
    errorWidget: SizedBox(),
  ),
- Displays suggestions in a list (data type List) when 
  ```
  final suggestions = await MapsPlaceAutocomplete(
    apiKey: 'apiKey'
  ).getSuggestionList(input, 'sessionToken')
  ```
    is called.

- Easy to integrate with any Flutter app.
- Handles error states with a customizable error widget.
- Supports a callback function on tap for selecting a place.

[//]: # (- Supports customizable UI elements for displaying suggestions.)

## Getting Started

To get started with the `maps_place_autocomplete` package, follow these steps:

### 1. Add the package to your `pubspec.yaml`

```yaml
dependencies:
  maps_place_autocomplete: ^1.0.0  # Replace with the latest version
```

### 2. Get your Google Places API key

- Go to the [Google Cloud Console](https://console.cloud.google.com/).
- Enable the Google Places API and generate your API key.

### 3. Integrate the package into your Flutter app

Use the package by providing the API key and customizing the UI elements as needed.

## Usage

Here's a simple example of how to use the `MapsPlaceAutocomplete` widget in your Flutter app:

```dart
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:maps_place_autocomplete/maps_place_autocomplete.dart';
import 'package:maps_place_autocomplete/maps_place_autocomplete_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppStateElement();
}

class _MyAppStateElement extends State<MyApp> {
  final controller = TextEditingController();
  String input = '';

  // to fetch place suggestions: 
  void getPlacesData() async {
    if (kDebugMode) {
      print(await MapsPlaceAutocomplete(apiKey: 'apiKey')
              .getSuggestionList(input, 'sessionToken'));
    }
  }

  @override
  Widget build(BuildContext context) {
    // to fetch place suggestions: 
    getPlacesData();
    // this has been called here for illustration purpose only 
    // not necessary here
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text('Maps Place Autocomplete')),
        body: Column(
          children: [
            TextField(
              controller: controller,
              onChanged: (value) {
                setState(() {
                  input = value;
                });
              },
            ),
            if (controller.text.isNotEmpty) ...[
              PlaceSuggestionWidget(
                apiKey: 'apiKey',
                input: input,
                sessionToken: 'sessionToken',
                onTap: (p0) {
                  // do what you need here
                },
                errorWidget: const SizedBox(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
```

## Customization

### 1. `onTap`
A callback function triggered when a suggestion is tapped. The value follows the format specified in the [Google Places Autocomplete API](https://developers.google.com/maps/documentation/places/web-service/place-autocomplete#example_autocomplete_requests).

### 2. `errorWidget`
A widget to display in case of an error (e.g., no suggestions or API failure).

## Additional Information

- **API Key**: Ensure your API key is set up in the Google Cloud Console with the necessary permissions for the Google Places API.
- **Issues**: If you encounter any problems or have questions, please open an issue on the repository.
