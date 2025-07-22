import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'core/config/app_config.dart';
import 'core/di/injection_container.dart';
import 'core/routes/app_routes.dart';
import 'core/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = View.of(context).platformDispatcher.platformBrightness;
    
    return GetMaterialApp(
      title: AppConfig.appName,
      theme: brightness == Brightness.light 
          ? AppTheme.lightTheme 
          : AppTheme.darkTheme,
      initialRoute: AppRoutes.HOME,
      getPages: AppRoutes.routes,
      debugShowCheckedModeBanner: false,
    );
  }
}