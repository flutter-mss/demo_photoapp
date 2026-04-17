import 'package:flutter/material.dart';
import 'package:mss_core/mss_core.dart';
import 'package:demo_image_filter_def/demo_image_filter_def.dart';

/// Luminance-weighted grayscale. Applied at paint time via a color
/// matrix — no per-pixel work, no decode round-trip.
class GrayscaleFilter extends ImageFilterDefinition {
  @override
  String get filterName => 'Grayscale';

  // Rec. 709 luminance coefficients: Y = 0.2126 R + 0.7152 G + 0.0722 B.
  static const List<double> _matrix = <double>[
    0.2126, 0.7152, 0.0722, 0, 0,
    0.2126, 0.7152, 0.0722, 0, 0,
    0.2126, 0.7152, 0.0722, 0, 0,
    0,      0,      0,      1, 0,
  ];

  @override
  Widget wrap(Widget child) {
    return ColorFiltered(
      colorFilter: const ColorFilter.matrix(_matrix),
      child: child,
    );
  }

  @override
  Widget buildPreview(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Colors.grey, Colors.black54],
        ),
        borderRadius: BorderRadius.circular(6),
      ),
      child: const Center(
        child: Text('G',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }
}

ExtensionFactory<GrayscaleFilter> factory() => ExtensionFactory(
      name: 'Grayscale',
      create: () => GrayscaleFilter(),
    );
