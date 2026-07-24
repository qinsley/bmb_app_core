/// Cross-platform maps URL builder.
///
/// Builds platform-appropriate URLs for opening an address or coordinate in
/// the device's default maps application.
///
/// ⚠️  **Launching requires the url_launcher package**, which is not yet in
/// bmb_core/pubspec.yaml. Add it before calling launchQuery or
/// launchCoordinates, then uncomment the launch helpers below.
///
/// Until then you can use [buildQueryUrl] and [buildCoordinatesUrl] to obtain
/// the URL string and open it via a `url_launcher` call in the consuming app.
abstract class MapsLauncher {
  MapsLauncher._();

  // ---------------------------------------------------------------------------
  // URL builders (no dependency required)
  // ---------------------------------------------------------------------------

  /// Builds a URL that opens [query] (e.g. `"Karen, Nairobi"`) in Google Maps.
  ///
  /// Returns a `geo:` URI on Android, a `maps:` URI on iOS, and a
  /// `https://maps.google.com` URL as the universal fallback.
  static String buildQueryUrl(String query, {bool preferGoogle = true}) {
    final encoded = Uri.encodeComponent(query);
    if (preferGoogle) {
      return 'https://www.google.com/maps/search/?api=1&query=$encoded';
    }
    return 'geo:0,0?q=$encoded';
  }

  /// Builds a URL that opens [latitude],[longitude] in Google Maps.
  static String buildCoordinatesUrl(double latitude, double longitude) {
    return 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
  }

  /// Builds a URL for directions from the device's current location to
  /// [destination] (a query string, e.g. an address).
  static String buildDirectionsUrl(String destination) {
    final encoded = Uri.encodeComponent(destination);
    return 'https://www.google.com/maps/dir/?api=1&destination=$encoded';
  }

  // ---------------------------------------------------------------------------
  // Launch helpers — uncomment once url_launcher is added to pubspec.yaml
  // ---------------------------------------------------------------------------

  // /// Opens [query] in the device's maps application.
  // static Future<bool> launchQuery(String query) async {
  //   final url = Uri.parse(buildQueryUrl(query));
  //   if (!await canLaunchUrl(url)) return false;
  //   return launchUrl(url, mode: LaunchMode.externalApplication);
  // }

  // /// Opens [latitude],[longitude] in the device's maps application.
  // static Future<bool> launchCoordinates(
  //   double latitude,
  //   double longitude,
  // ) async {
  //   final url = Uri.parse(buildCoordinatesUrl(latitude, longitude));
  //   if (!await canLaunchUrl(url)) return false;
  //   return launchUrl(url, mode: LaunchMode.externalApplication);
  // }

  // /// Opens directions to [destination] in the device's maps application.
  // static Future<bool> launchDirections(String destination) async {
  //   final url = Uri.parse(buildDirectionsUrl(destination));
  //   if (!await canLaunchUrl(url)) return false;
  //   return launchUrl(url, mode: LaunchMode.externalApplication);
  // }
}
