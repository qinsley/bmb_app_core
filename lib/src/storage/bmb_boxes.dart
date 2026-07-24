/// Hive box name constants. Centralised here so the same string isn't
/// hardcoded in multiple datasources (a real source of bugs in the
/// previous codebase).
abstract class TbBoxes {
  static const cart = 'bmb.cart';
  static const user = 'bmb.user';
  static const cook = 'bmb.cook';
  static const settings = 'bmb.settings';
  static const cachedFeed = 'bmb.cached_feed';
}

/// Common key constants within boxes.
abstract class TbKeys {
  static const currentUser = 'current_user';
  static const currentCart = 'current_cart';
  static const lastLocation = 'last_location';
  static const themeMode = 'theme_mode';
}
