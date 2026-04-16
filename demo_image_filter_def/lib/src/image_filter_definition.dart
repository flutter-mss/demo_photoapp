import 'dart:typed_data';

import 'package:flutter/widgets.dart';
import 'package:mss_core/mss_core.dart';

/// An image filter applies a visual transformation to image data.
abstract class ImageFilterDefinition extends ExtensionInterface {
  /// Display name of this filter.
  String get filterName;

  /// Apply the filter to raw image bytes.
  Future<Uint8List> apply(Uint8List imageData);

  /// Build a small preview widget showing the filter effect.
  Widget buildPreview(BuildContext context);
}

typedef ImageFilterFactory = ImageFilterDefinition Function();
