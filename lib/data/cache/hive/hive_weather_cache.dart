import 'package:hive_flutter/adapters.dart';

import 'package:weather/data/cache/hive/city_adapter.dart';
import 'package:weather/data/cache/interface/weather_cache_interface.dart';
import 'package:weather/data/model/city_model.dart';

// кеш на базе hive
class HiveWeatherCache implements WeatherCache {
  static final HiveWeatherCache _instantce = HiveWeatherCache._internal();

  factory HiveWeatherCache() {
    return _instantce;
  }

  HiveWeatherCache._internal() {
    Hive.registerAdapter(CityModelAdapter());
  }
  static const _dataAppCache = 'data_app_cache';
  static const _cityKey = 'city_key';

  @override
  Future<CityModel?> readCityID() async {
    final box = await Hive.openBox(_dataAppCache);
    return box.get(_cityKey);
  }

  @override
  Future<void> writeCityID(CityModel city) async {
    final box = await Hive.openBox(_dataAppCache);
    return await box.put(_cityKey, city);
  }
}
