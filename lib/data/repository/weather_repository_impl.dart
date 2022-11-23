import 'package:weather/core/error/crud_server_failure.dart';
import 'package:weather/core/error/exception.dart';
import 'package:weather/data/cache/interface/weather_cache_interface.dart';
import 'package:weather/data/service/interface/weather_service_interface.dart';
import 'package:weather/domain/entitis/today_weather_entity.dart';
import 'package:weather/domain/entitis/history_weather_entity.dart';
import 'package:weather/domain/entitis/city_entity.dart';
import 'package:weather/core/error/failure.dart';
import 'package:weather/core/components/respons.dart';
import 'package:weather/domain/repository/weather_repository.dart';

// имплементация репозитория
class WeatherRepositoryImpl extends WeatherRepository {
  WeatherRepositoryImpl(
      {required this.weatherCache, required this.weatherService});

  // сервис получения погоды
  final WeatherService weatherService;

  // сервис сохранения данных на устройстве
  final WeatherCache weatherCache;

// проверяет наличие ошибки запроса, возвращает тип Failure или данные
  Future<Respons<Failure, T>> _catchData<T>(ResultFunction<T> onAction) async {
    try {
      return Right(await onAction());
    } on ServerException catch (e) {
      return Left(CRUDServerFailure.fromType(e.type));
    }
  }

// выдам только три отсортированных по минимальной темратуре дня
  @override
  Future<Respons<Failure, List<HistoryWeatherEntity>>> historyWeather(
      String cityKey) {
    return _catchData(() async {
      final weather = await weatherService.historyWeather(cityKey);

      List<HistoryWeatherEntity> sortWeather = [];
      if (weather.length > 3) {
        sortWeather.addAll(weather.getRange(0, 3));
      }

      sortWeather.sort(
        (a, b) => (a.temperatureMin - b.temperatureMin).round(),
      );

      return sortWeather;
    });
  }

// проверяем наличе данных города в кеше при отсутствии имени города в параметрах,
// если город найден возвращаем его
//если не найден возвращаем ошибку
// при наличии имени города в параметрах запрашиваем данные с сервера
// при получении данных сохраняем город в кеш

  @override
  Future<Respons<Failure, CityEntity>> searchCity([String? cityName]) async {
    if (cityName == null) {
      final city = await weatherCache.readCityID();
      if (city != null) {
        return Right(city);
      }
    } else {
      return await _catchData(
        () async {
          final city = await weatherService.searchCity(cityName);

          await weatherCache.writeCityID(city);

          return city;
        },
      );
    }

    return Left(CRUDServerFailure.fromType('get-city-error'));
  }

  @override
  Future<Respons<Failure, TodayWeatherEntity>> todayWeather(String cityKey) {
    return _catchData(
      () async => await weatherService.todayWeatcher(cityKey),
    );
  }
}
