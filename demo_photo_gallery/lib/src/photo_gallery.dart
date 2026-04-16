import 'package:flutter/material.dart';
import 'package:demo_gallery_module_def/demo_gallery_module_def.dart';

class PhotoGallery extends GalleryModuleDefinition {
  static const _sampleColors = [
    Colors.red, Colors.blue, Colors.green, Colors.orange,
    Colors.purple, Colors.teal, Colors.pink, Colors.amber,
    Colors.cyan, Colors.indigo, Colors.lime, Colors.brown,
  ];

  @override
  List<String> get imagePaths =>
      List.generate(_sampleColors.length, (i) => 'sample_$i');

  @override
  Widget buildThumbnail(BuildContext context, String imagePath) {
    final index = int.tryParse(imagePath.split('_').last) ?? 0;
    final color = _sampleColors[index % _sampleColors.length];
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Icon(Icons.photo, color: Colors.white.withValues(alpha: 0.7), size: 32),
      ),
    );
  }

  @override
  Widget buildUI(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: imagePaths.length,
      itemBuilder: (ctx, i) => buildThumbnail(ctx, imagePaths[i]),
    );
  }
}
