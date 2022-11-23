import 'package:weather/data/model/city_model.dart';
import 'package:weather/data/model/history_weather_model.dart';
import 'package:weather/data/model/today_weather_model.dart';

// интерфейс для сервиса работы с погодой
abstract class WeatherService {
  Future<CityModel> searchCity(String name);

  Future<TodayWeatherModel> todayWeatcher(String cityKey);

  Future<List<HistoryWeatherModel>> historyWeather(String cityKey);
}
