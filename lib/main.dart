import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pika_dex/data_controller.dart';
import 'package:pika_dex/pages/main_app_page.dart';
import 'package:pika_dex/themes/app_themes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(PikaDex());
}

class PikaDex extends StatefulWidget with WidgetsBindingObserver {
  @override
  State<PikaDex> createState() => _PikaDexState();
}

class _PikaDexState extends State<PikaDex> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppThemes.darkTheme,
      darkTheme: AppThemes.darkTheme,
      home: Scaffold(body: MainAppPage()),
      initialBinding: BindingsBuilder(() {
        Get.put<DataController>(DataController());
      }),
    );
  }
}
