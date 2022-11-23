import 'package:weather/domain/entitis/history_weather_entity.dart';

class HistoryWeatherModel extends HistoryWeatherEntity {
  const HistoryWeatherModel({
    required DateTime date,
    required double temperatureMin,
    required double temperatureMax,
    required double winSpeed,
    required String winDirection,
  }) : super(
            date: date,
            temperatureMax: temperatureMax,
            temperatureMin: temperatureMin,
            winDirection: winDirection,
            winSpeed: winSpeed);

// получение данных из json
  HistoryWeatherModel.fromJson(Map<String, dynamic> map)
      : super(
            date: DateTime.parse(map['Date']),
            temperatureMax: map['Temperature']['Maximum']['Value'] * 1.0,
            temperatureMin: map['Temperature']['Minimum']['Value'] * 1.0,
            winSpeed: map['Day']['Wind']['Speed']['Value'] * 1.0,
            winDirection:
                map['Day']['Wind']['Direction']['Localized'] as String);
}
