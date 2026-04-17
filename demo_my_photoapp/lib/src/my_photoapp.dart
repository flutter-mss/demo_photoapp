import 'package:flutter/material.dart';
import 'package:mss_core/mss_core.dart';
import 'package:demo_gallery_module_def/demo_gallery_module_def.dart';
import 'package:demo_image_filter_def/demo_image_filter_def.dart';

class MyPhotoApp extends AppInterface {
  late List<ModuleInterface> _modules;
  List<ImageFilterDefinition> _filters = const [];

  List<GalleryModuleDefinition> get _galleries =>
      _modules.whereType<GalleryModuleDefinition>().toList();

  List<ImageFilterDefinition> get filters => _filters;

  @override
  void setup(List<ModuleInterface> modules) {
    _modules = modules;
  }

  @override
  void setupExtensions(List<ExtensionInterface> extensions) {
    _filters = extensions.whereType<ImageFilterDefinition>().toList();
  }

  @override
  Widget buildApp() {
    return MaterialApp(
      title: 'Photo Viewer',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: _PhotoHome(app: this),
    );
  }
}

class _PhotoHome extends StatefulWidget {
  final MyPhotoApp app;
  const _PhotoHome({required this.app});

  @override
  State<_PhotoHome> createState() => _PhotoHomeState();
}

class _PhotoHomeState extends State<_PhotoHome> {
  @override
  Widget build(BuildContext context) {
    final galleries = widget.app._galleries;
    if (galleries.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Photo Viewer')),
        body: const Center(child: Text('No gallery module loaded')),
      );
    }
    final gallery = galleries.first;
    return Scaffold(
      appBar: AppBar(title: const Text('Photo Viewer')),
      body: _PhotoGrid(
        gallery: gallery,
        onTap: (path) => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => _PhotoDetail(
              imagePath: path,
              filters: widget.app.filters,
            ),
          ),
        ),
      ),
    );
  }
}

class _PhotoGrid extends StatelessWidget {
  final GalleryModuleDefinition gallery;
  final void Function(String path) onTap;

  const _PhotoGrid({required this.gallery, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final paths = gallery.imagePaths;
    return GridView.builder(
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: paths.length,
      itemBuilder: (ctx, i) => GestureDetector(
        onTap: () => onTap(paths[i]),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: gallery.buildThumbnail(ctx, paths[i]),
        ),
      ),
    );
  }
}

class _PhotoDetail extends StatefulWidget {
  final String imagePath;
  final List<ImageFilterDefinition> filters;

  const _PhotoDetail({required this.imagePath, required this.filters});

  @override
  State<_PhotoDetail> createState() => _PhotoDetailState();
}

class _PhotoDetailState extends State<_PhotoDetail> {
  int _selected = -1; // -1 = original

  @override
  Widget build(BuildContext context) {
    final filter = _selected >= 0 ? widget.filters[_selected] : null;
    final image = Image.asset(widget.imagePath, fit: BoxFit.contain);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(filter?.filterName ?? 'Original'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: filter == null ? image : filter.wrap(image),
            ),
          ),
          if (widget.filters.isNotEmpty)
            SizedBox(
              height: 72,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: ChoiceChip(
                      label: const Text('Original'),
                      selected: _selected == -1,
                      onSelected: (_) => setState(() => _selected = -1),
                    ),
                  ),
                  for (int i = 0; i < widget.filters.length; i++)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: ChoiceChip(
                        avatar: widget.filters[i].buildPreview(context),
                        label: Text(widget.filters[i].filterName),
                        selected: _selected == i,
                        onSelected: (_) => setState(() => _selected = i),
                      ),
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
