import 'package:flutter/widgets.dart';
import 'package:mss_core/mss_core.dart';

/// A gallery module provides a grid/list of images.
abstract class GalleryModuleDefinition extends ModuleInterface {
  /// The list of image asset paths this gallery provides.
  List<String> get imagePaths;

  /// Build a thumbnail widget for an image.
  Widget buildThumbnail(BuildContext context, String imagePath);
}
