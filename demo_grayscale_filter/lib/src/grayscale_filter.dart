import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:mss_core/mss_core.dart';
import 'package:demo_image_filter_def/demo_image_filter_def.dart';

class GrayscaleFilter extends ImageFilterDefinition {
  @override
  String get filterName => 'Grayscale';

  @override
  Future<Uint8List> apply(Uint8List imageData) async {
    return imageData;
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
        child: Text('G', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }
}

ExtensionFactory<GrayscaleFilter> factory() => ExtensionFactory(
      name: 'Grayscale',
      create: () => GrayscaleFilter(),
    );
