import 'package:flutter/material.dart';
import 'package:mss_core/mss_core.dart';
import 'package:demo_image_filter_def/demo_image_filter_def.dart';

/// Classic sepia tone — applied at paint time via a color matrix.
class SepiaFilter extends ImageFilterDefinition {
  @override
  String get filterName => 'Sepia';

  // Standard sepia matrix (approx. Microsoft/Adobe reference values).
  static const List<double> _matrix = <double>[
    0.393, 0.769, 0.189, 0, 0,
    0.349, 0.686, 0.168, 0, 0,
    0.272, 0.534, 0.131, 0, 0,
    0,     0,     0,     1, 0,
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
          colors: [Color(0xFFC19A6B), Color(0xFF8B6914)],
        ),
        borderRadius: BorderRadius.circular(6),
      ),
      child: const Center(
        child: Text('S',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }
}

ExtensionFactory<SepiaFilter> factory() => ExtensionFactory(
      name: 'Sepia',
      create: () => SepiaFilter(),
    );
