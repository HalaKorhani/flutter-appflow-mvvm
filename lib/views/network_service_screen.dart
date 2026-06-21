import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodels/network_service_view_model.dart';

// Screen responsible for showing network monitoring feature.
class NetworkServiceScreen extends StatelessWidget {
  const NetworkServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<NetworkServiceViewModel>();

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Center(
        child: Text(
          viewModel.currentStatus,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
