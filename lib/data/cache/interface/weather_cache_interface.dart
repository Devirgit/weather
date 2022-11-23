import 'package:weather/data/model/city_model.dart';

abstract class WeatherCache {
// сохранение данных города в кеш
  Future<void> writeCityID(CityModel sity);

  // полчение данных города из кеша
  Future<CityModel?> readCityID();
}
