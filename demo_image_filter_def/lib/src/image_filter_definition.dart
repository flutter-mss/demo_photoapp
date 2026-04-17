import 'dart:typed_data';

import 'package:flutter/widgets.dart';
import 'package:mss_core/mss_core.dart';

/// An image filter applies a visual transformation to image data.
///
/// Two integration points:
///   - [wrap] composes at render time (fast; wraps a widget tree like
///     `Image.asset(...)` and applies a ColorFilter or similar). This
///     is what the photo-app host calls for preview/detail views.
///   - [apply] operates on raw bytes (for export / upload paths).
///     Default is an identity transform — override when a filter
///     needs to ship real bytes (e.g. save-to-disk).
abstract class ImageFilterDefinition extends ExtensionInterface {
  /// Display name of this filter.
  String get filterName;

  /// Wrap a child widget so the filter's visual effect is applied at
  /// paint time. Default is a no-op; concrete filters typically return
  /// a [ColorFiltered] that composes a color matrix.
  Widget wrap(Widget child) => child;

  /// Bytes-level transform. Default returns the input unchanged so
  /// filters that live entirely at paint time don't have to implement
  /// a redundant encode/decode round-trip.
  Future<Uint8List> apply(Uint8List imageData) async => imageData;

  /// Build a small preview widget showing the filter effect.
  Widget buildPreview(BuildContext context);
}

typedef ImageFilterFactory = ImageFilterDefinition Function();
