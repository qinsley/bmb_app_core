/// Spatial scale and border-radius tokens for Chefly.
///
/// **Rule:** No raw numeric literals for spacing or radii are allowed anywhere
/// else in `chefly_core` or the consumer apps.  Every layout value must
/// reference a constant defined here, e.g. `AppSpacing.md` or
/// `AppRadius.card`.
///
/// The scale is an 8-pt grid with a 4-pt half-step at the bottom.
abstract class AppSpacing {
  // ---------------------------------------------------------------------------
  // Spacing scale
  // ---------------------------------------------------------------------------

  /// 4 pt — Tight gap between icon and label, badge padding.
  static const double xs = 4;

  /// 8 pt — Default padding inside compact components (chip, tag).
  static const double sm = 8;

  /// 12 pt — Gap between list items, icon-to-text gap in rows.
  static const double md = 12;

  /// 16 pt — Default horizontal screen margin, card padding.
  static const double lg = 16;

  /// 24 pt — Section spacing, card-to-card vertical gap.
  static const double xl = 24;

  /// 32 pt — Hero section padding, large gap between page sections.
  static const double xxl = 32;

  /// 48 pt — Full-bleed image heights, large illustration gutters.
  static const double xxxl = 48;

  // ---------------------------------------------------------------------------
  // Semantic aliases
  // ---------------------------------------------------------------------------

  /// Horizontal edge-to-content margin used on all full-width screens.
  static const double screenHorizontal = lg;

  /// Vertical space between major page sections.
  static const double sectionGap = xl;

  /// Padding inside card components.
  static const double cardPadding = lg;

  /// Gap between a label and its helper text or secondary line.
  static const double labelGap = xs;

  /// Vertical rhythm between rows in a list.
  static const double listItemGap = sm;
}

/// Border-radius tokens for Chefly.
///
/// Always reference these constants instead of `BorderRadius.circular(<number>)`.
abstract class AppRadius {
  /// 4 pt — Tags, small badges.
  static const double xs = 4;

  /// 8 pt — Input fields, compact cards.
  static const double sm = 8;

  /// 12 pt — Standard cards, bottom-sheet corners.
  static const double md = 12;

  /// 16 pt — Featured cards, image tiles.
  static const double lg = 16;

  /// 24 pt — Large modal sheets.
  static const double xl = 24;

  /// 999 pt — Pill-shaped buttons, chips.
  static const double pill = 999;
}
