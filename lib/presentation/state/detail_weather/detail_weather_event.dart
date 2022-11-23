part of 'detail_weather_bloc.dart';

abstract class DetailWeatherEvent extends Equatable {
  const DetailWeatherEvent();

  @override
  List<Object> get props => [];
}

// событие загрузки детальной погоды на несколько дней
class DetailWeatherLoad extends DetailWeatherEvent {
  const DetailWeatherLoad(this.cityID);

  final String cityID;

  @override
  List<Object> get props => [cityID];
}
