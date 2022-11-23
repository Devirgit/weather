import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:weather/internal/config_api.dart';
import 'package:weather/internal/di/register.dart';
import 'package:weather/presentation/app.dart';

// иницииализируем зависимости и запускам приложение
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Dependency.init(ApiConfig.apiKey);

  runApp(const App());
}
