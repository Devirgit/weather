part of 'weather_today_bloc.dart';

abstract class WeatherTodayEvent extends Equatable {
  const WeatherTodayEvent();

  @override
  List<Object> get props => [];
}

// событие загрузки погоды
class WeatherLoad extends WeatherTodayEvent {
  const WeatherLoad(this.cityId);

  final String cityId;

  @override
  List<Object> get props => [cityId];
}
