import 'package:flutter/material.dart';
import 'package:weather/presentation/pages/choose_city_page.dart';
import 'package:weather/presentation/pages/detail_weather_page.dart';
import 'package:weather/presentation/pages/weather_page.dart';
import 'package:weather/presentation/route/page_types.dart';

abstract class RoutePageConfig {
//Настройки главной страницы
  static PageConfig homePage() => const PageConfig(
        key: ValueKey('home_page'),
        child: WeatherPage(),
      );
//найтройки страницы погоды на 3 дня
  static PageConfig detailPage() => const PageConfig(
        key: ValueKey('detail_page'),
        child: DetailWeatherPage(),
      );
//найтройки страницы выбора города
  static PageConfig chooseSityPage() => const PageConfig(
        key: ValueKey('choose_sity_page'),
        child: ChooseCityPage(),
      );
}

class PageConfig extends NaviPage {
  const PageConfig(
      {required super.child,
      super.key,
      super.title,
      super.fullScreenDialog,
      super.type = NaviPageType.slideRightTransition});
}
