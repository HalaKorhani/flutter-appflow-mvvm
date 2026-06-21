import 'package:flutter/material.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:provider/provider.dart';

import 'repositories/auth_repository.dart';
import 'repositories/gallery_repository.dart';
import 'repositories/timer_repository.dart';
import 'repositories/todo_repository.dart';
import 'viewmodels/auth_view_model.dart';
import 'viewmodels/gallery_view_model.dart';
import 'viewmodels/network_service_view_model.dart';
import 'viewmodels/timer_view_model.dart';
import 'viewmodels/todo_view_model.dart';
import 'views/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Required by flutter_foreground_task so the main UI isolate can receive
  // messages from the foreground-service Dart isolate.
  FlutterForegroundTask.initCommunicationPort();

  runApp(const AppFlowMvvmApp());
}

class AppFlowMvvmApp extends StatelessWidget {
  const AppFlowMvvmApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MultiProvider creates all ViewModels once and makes them available
    // to the UI. This keeps UI widgets clean and MVVM-friendly.
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel(AuthRepository())),
        ChangeNotifierProvider(
          create: (_) => TimerViewModel(TimerRepository()),
        ),
        ChangeNotifierProvider(create: (_) => TodoViewModel(TodoRepository())),
        ChangeNotifierProvider(
          create: (_) => GalleryViewModel(GalleryRepository()),
        ),
        ChangeNotifierProvider(
          create: (_) => NetworkServiceViewModel()..initialize(),
        ),
      ],
      child: WithForegroundTask(
        // WithForegroundTask helps the plugin keep the foreground task attached
        // to the Flutter UI while the app is open.
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'App Flow MVVM',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const SplashScreen(),
        ),
      ),
    );
  }
}
