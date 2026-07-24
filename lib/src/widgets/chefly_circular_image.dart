import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../theme/app_colors.dart';

/// A circular avatar that loads from a URL via [CachedNetworkImage].
///
/// States:
/// - **Loading** — shimmer circle in [AppColors.neutral100].
/// - **Loaded** — the remote image clipped to a circle.
/// - **Error / no URL** — initials avatar using the first character of
///   [fallbackName] (or `?`), with a [AppColors.primary10] background.
///
/// An optional [borderColor] ring (e.g. [AppColors.primary] for verified
/// chef badges) is drawn outside the image circle.
class CheflyCircularImage extends StatelessWidget {
  /// Creates a [CheflyCircularImage].
  const CheflyCircularImage({
    super.key,
    this.imageUrl,
    this.radius = 24,
    this.fallbackName,
    this.borderColor,
    this.borderWidth = 2,
    this.fit = BoxFit.cover,
  });

  /// Remote image URL. When `null` the fallback avatar is shown immediately.
  final String? imageUrl;

  /// Radius of the circle. Defaults to `24`.
  final double radius;

  /// Used to derive the initials shown in the fallback avatar.
  final String? fallbackName;

  /// Optional border colour drawn outside the image circle.
  final Color? borderColor;

  /// Thickness of the optional border. Defaults to `2`.
  final double borderWidth;

  /// How the image is inscribed into the circle. Defaults to [BoxFit.cover].
  final BoxFit fit;

  double get _diameter => radius * 2;

  @override
  Widget build(BuildContext context) {
    final Widget image = _image();
    final Color? border = borderColor;

    if (border != null) {
      return Container(
        width: _diameter + borderWidth * 2,
        height: _diameter + borderWidth * 2,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: border,
        ),
        padding: EdgeInsets.all(borderWidth),
        child: image,
      );
    }

    return image;
  }

  Widget _image() {
    final String? url = imageUrl;
    if (url == null || url.isEmpty) {
      return _fallbackAvatar();
    }

    return CachedNetworkImage(
      imageUrl: url,
      width: _diameter,
      height: _diameter,
      fit: fit,
      imageBuilder: (context, imageProvider) => Container(
        width: _diameter,
        height: _diameter,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(image: imageProvider, fit: fit),
        ),
      ),
      placeholder: (context, url) => _shimmerCircle(),
      errorWidget: (context, url, error) => _fallbackAvatar(),
    );
  }

  Widget _shimmerCircle() {
    return Shimmer.fromColors(
      baseColor: AppColors.neutral100,
      highlightColor: AppColors.neutral50,
      child: Container(
        width: _diameter,
        height: _diameter,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.neutral100,
        ),
      ),
    );
  }

  Widget _fallbackAvatar() {
    final String name = fallbackName ?? '';
    final String initial = name.isNotEmpty ? name[0].toUpperCase() : '?';
    return CircleAvatar(
      radius: radius,
      backgroundColor: AppColors.primary10,
      child: Text(
        initial,
        style: TextStyle(
          color: AppColors.primary,
          fontSize: radius * 0.8,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
