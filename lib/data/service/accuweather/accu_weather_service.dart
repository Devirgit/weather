import 'package:dio/dio.dart';
import 'package:weather/core/error/exception.dart';
import 'package:weather/data/model/today_weather_model.dart';
import 'package:weather/data/model/history_weather_model.dart';
import 'package:weather/data/model/city_model.dart';
import 'package:weather/data/service/interface/weather_service_interface.dart';

typedef RequestCallback = dynamic Function(dynamic respons);

// api запросы для получения данных о погоде от accuweather
class AccuWeatherService implements WeatherService {
  AccuWeatherService(String token) : _token = token;

  final String _token;

  static const String _url = 'http://dataservice.accuweather.com/';
  final Dio _dio = Dio();

  Future<dynamic> _request(
    RequestOptions requestOptions,
    RequestCallback onResult,
  ) async {
    try {
      final request = await _dio.fetch(requestOptions.copyWith(
        baseUrl: _url,
      ));

      if ((request.data is Map<String, dynamic>)) {
        if ((request.data as Map<String, dynamic>)
            .containsKey('DailyForecasts')) {
          return onResult(request.data['DailyForecasts']);
        } else {
          throw const ServerException('response-error');
        }
      }

      if (request.data is List && (request.data as List).isNotEmpty) {
        return onResult(request.data[0]);
      }
      throw const ServerException('response-error');
    } on DioError catch (e) {
      throw ServerException.fromCode(e.type);
    }
  }

  List<HistoryWeatherModel> getCollection(List<dynamic> items) {
    final List<HistoryWeatherModel> result = [];
    if (items.isNotEmpty) {
      for (Map<String, dynamic> element in items) {
        result.add(HistoryWeatherModel.fromJson(element));
      }
    }
    return result;
  }

  @override
  Future<List<HistoryWeatherModel>> historyWeather(String cityKey) async {
    final options = RequestOptions(
      path: 'forecasts/v1/daily/5day/$cityKey',
      method: 'GET',
      queryParameters: {
        'apikey': _token,
        'details': true,
        'metric': true,
        'language': 'ru-RU'
      },
    );

    return await _request(options, (items) {
      return getCollection(items);
    });
  }

  @override
  Future<CityModel> searchCity(String name) async {
    final options = RequestOptions(
      path: 'locations/v1/cities/search',
      method: 'GET',
      queryParameters: {'apikey': _token, 'q': name, 'language': 'ru-RU'},
    );
    return await _request(options, (item) {
      return CityModel.fromJson(item as Map<String, dynamic>);
    });
  }

  @override
  Future<TodayWeatherModel> todayWeatcher(String cityKey) async {
    final options = RequestOptions(
      path: 'forecasts/v1/hourly/1hour/$cityKey',
      method: 'GET',
      queryParameters: {
        'apikey': _token,
        'details': true,
        'metric': true,
        'language': 'ru-RU'
      },
    );

    return await _request(options, (item) {
      return TodayWeatherModel.fromJson(item as Map<String, dynamic>);
    });
  }
}
