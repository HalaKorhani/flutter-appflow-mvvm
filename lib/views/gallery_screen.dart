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
          const SizedBox(height: 16),

          // Show error card when gallery permission is denied.
          if (viewModel.permissionDenied)
            Card(
              color: Colors.red.shade100,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Text(
                  viewModel.message ?? 'Permission denied.',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

          // Show normal message when permission is not denied.
          if (!viewModel.permissionDenied && viewModel.message != null)
            Text(viewModel.message!, textAlign: TextAlign.center),

          const SizedBox(height: 16),

          Expanded(
            child: Center(
              child: viewModel.selectedImage == null
                  ? const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.image, size: 80, color: Colors.grey),
                        SizedBox(height: 8),
                        Text('No image selected yet'),
                      ],
                    )
                  : const SizedBox(),
            ),
          ),
        ],
      ),
    );
  }
}
