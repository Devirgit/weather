import 'package:flutter/material.dart';
import 'package:weather/common/theme/light_colors.dart';
import 'package:weather/common/theme/light_theme.dart';
import 'package:weather/internal/di/di.dart';
import 'package:weather/internal/di/repository_module.dart';

abstract class Dependency {
// регистрация зависимостей
  static init(String apiKey) async {
    Di.reg<ThemeData>(() => lightTheme(UILigthColor()));

    final repository = RepositoryModule.inst.weatherRepository(apiKey);
    // проверка наличия сохраненных данных города, если они есть
    // отправляем пользователя на главный экран, иначе на экран выбора города
    final city = await repository.searchCity();
    city.result((none) => Di.reg<String?>(name: 'initPath', () => '/city'),
        (city) => Di.reg<String?>(name: 'initPath', () => '/'));

    Di.reg(() => repository);
  }
}
