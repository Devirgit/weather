import 'package:weather/domain/entitis/today_weather_entity.dart';

class TodayWeatherModel extends TodayWeatherEntity {
  const TodayWeatherModel(
      {required double temperature,
      required double winSpeed,
      required String winDirection,
      required double humidity})
      : super(
            humidity: humidity,
            temperature: temperature,
            winDirection: winDirection,
            winSpeed: winSpeed);

// создание модели погоды из json
  TodayWeatherModel.fromJson(Map<String, dynamic> map)
      : super(
          humidity: map['RelativeHumidity'] * 1.0,
          temperature: map['Temperature']['Value'] * 1.0,
          winDirection: map['Wind']['Direction']['Localized'] as String,
          winSpeed: map['Wind']['Speed']['Value'] * 1.0,
        );
}
