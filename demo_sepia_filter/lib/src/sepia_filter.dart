import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:mss_core/mss_core.dart';
import 'package:demo_image_filter_def/demo_image_filter_def.dart';

class SepiaFilter extends ImageFilterDefinition {
  @override
  String get filterName => 'Sepia';

  @override
  Future<Uint8List> apply(Uint8List imageData) async {
    // Placeholder — real implementation would transform pixel data
    return imageData;
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
        child: Text('S', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }
}

ExtensionFactory<SepiaFilter> factory() => ExtensionFactory(
      name: 'Sepia',
      create: () => SepiaFilter(),
    );
