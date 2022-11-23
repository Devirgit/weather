import 'package:weather/core/components/respons.dart';
import 'package:weather/core/error/failure.dart';
import 'package:weather/domain/entitis/city_entity.dart';
import 'package:weather/domain/entitis/history_weather_entity.dart';
import 'package:weather/domain/entitis/today_weather_entity.dart';

//репозитори погоды
abstract class WeatherRepository {
  // получить данные города либо ошибку
  Future<Respons<Failure, CityEntity>> searchCity([String? cityName]);

  // получить погоду текущего дня или ошибку
  Future<Respons<Failure, TodayWeatherEntity>> todayWeather(String cityKey);

  //полуичть данные погоды на несколько дней или ошибку
  Future<Respons<Failure, List<HistoryWeatherEntity>>> historyWeather(
      String cityKey);
}
