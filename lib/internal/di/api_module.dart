import 'package:weather/data/cache/hive/hive_weather_cache.dart';
import 'package:weather/data/cache/interface/weather_cache_interface.dart';
import 'package:weather/data/service/accuweather/accu_weather_service.dart';
import 'package:weather/data/service/interface/weather_service_interface.dart';
import 'package:weather/data/service/test_weather_service.dart';

// подключаем сервисы с которыми будем работаь
class ApiModule {
  static WeatherCache get weatherCache => HiveWeatherCache();

  static WeatherService weatherService(String apiToken) => // TestWeather();
      AccuWeatherService(apiToken);
}
