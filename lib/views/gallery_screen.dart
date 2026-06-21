import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodels/gallery_view_model.dart';

// Screen responsible for displaying gallery image selection feature.
class GalleryScreen extends StatelessWidget {
  const GalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<GalleryViewModel>();

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FilledButton.icon(
            onPressed: viewModel.pickImage,
            icon: const Icon(Icons.photo_library),
            label: const Text('Pick Image from Gallery'),
          ),
        ],
      ),
    );
  }
}
