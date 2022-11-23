import 'package:weather/core/error/exception.dart';
import 'package:weather/data/model/today_weather_model.dart';
import 'package:weather/data/model/history_weather_model.dart';
import 'package:weather/data/model/city_model.dart';
import 'package:weather/data/service/interface/weather_service_interface.dart';

// тестовые данные

class TestWeather implements WeatherService {
  @override
  Future<List<HistoryWeatherModel>> historyWeather(String cityKey) async {
    if (cityKey != '295902') {
      throw const ServerException('response-error');
    }

    return [
      HistoryWeatherModel(
          date: DateTime(2022, 11, 23),
          temperatureMax: 2,
          temperatureMin: -1,
          winDirection: 'СВ',
          winSpeed: 15),
      HistoryWeatherModel(
          date: DateTime(2022, 11, 24),
          temperatureMax: 3,
          temperatureMin: 3,
          winDirection: 'ВВ',
          winSpeed: 2),
      HistoryWeatherModel(
          date: DateTime(2022, 11, 25),
          temperatureMax: 5,
          temperatureMin: -7,
          winDirection: 'ЮВ',
          winSpeed: 12),
      HistoryWeatherModel(
          date: DateTime(2022, 11, 26),
          temperatureMax: 2,
          temperatureMin: -1,
          winDirection: 'СВ',
          winSpeed: 17),
      HistoryWeatherModel(
          date: DateTime(2022, 11, 27),
          temperatureMax: 7,
          temperatureMin: -1,
          winDirection: 'СВ',
          winSpeed: 1),
    ];
  }

  @override
  Future<CityModel> searchCity(String name) async {
    if (name == 'Пекин') {
      return const CityModel(key: '1', name: 'Пекин');
    }

    if (name != 'Тамбов') {
      throw const ServerException('response-error');
    }
    return const CityModel(key: '295902', name: 'Тамбов');
  }

  @override
  Future<TodayWeatherModel> todayWeatcher(String cityKey) async {
    if (cityKey != '295902') {
      throw const ServerException('response-error');
    }
    return const TodayWeatherModel(
        humidity: 75, temperature: 4.2, winDirection: 'СВ', winSpeed: 12.2);
  }
}
