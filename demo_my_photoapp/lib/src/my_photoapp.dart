import 'package:flutter/material.dart';
import 'package:mss_core/mss_core.dart';
import 'package:demo_gallery_module_def/demo_gallery_module_def.dart';
import 'package:demo_image_filter_def/demo_image_filter_def.dart';

class MyPhotoApp extends AppInterface {
  late List<ModuleInterface> _modules;
  List<GalleryModuleDefinition> get _galleries =>
      _modules.whereType<GalleryModuleDefinition>().toList();
  List<ExtensionFactory<ImageFilterDefinition>> filters = [];

  @override
  void setup(List<ModuleInterface> modules) {
    _modules = modules;
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
  int _selectedFilter = -1;

  @override
  Widget build(BuildContext context) {
    final galleries = widget.app._galleries;
    final filters = widget.app.filters;

    return Scaffold(
      appBar: AppBar(title: const Text('Photo Viewer')),
      body: Column(
        children: [
          if (filters.isNotEmpty)
            SizedBox(
              height: 60,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.all(8),
                children: [
                  ChoiceChip(
                    label: const Text('None'),
                    selected: _selectedFilter == -1,
                    onSelected: (_) => setState(() => _selectedFilter = -1),
                  ),
                  for (int i = 0; i < filters.length; i++)
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: ChoiceChip(
                        label: Text(filters[i].name),
                        selected: _selectedFilter == i,
                        onSelected: (_) => setState(() => _selectedFilter = i),
                      ),
                    ),
                ],
              ),
            ),
          Expanded(
            child: galleries.isEmpty
                ? const Center(child: Text('No gallery module loaded'))
                : galleries.first.buildUI(context),
          ),
        ],
      ),
    );
  }
}
