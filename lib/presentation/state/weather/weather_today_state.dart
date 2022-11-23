part of 'weather_today_bloc.dart';

class WeatherTodayState extends Equatable {
  const WeatherTodayState._(
      {this.status = LoadDataStatus.init,
      this.weather,
      this.cityID,
      this.errorMessage});

  const WeatherTodayState.success(TodayWeatherEntity weather, String cityID)
      : this._(
            weather: weather, status: LoadDataStatus.success, cityID: cityID);

  const WeatherTodayState.init() : this._();

  const WeatherTodayState.error(String? message, String? cityID)
      : this._(
            errorMessage: message,
            status: LoadDataStatus.error,
            cityID: cityID);

  const WeatherTodayState.loading() : this._(status: LoadDataStatus.loading);

  final LoadDataStatus status;
  final String? errorMessage;
  final TodayWeatherEntity? weather;
  final String? cityID;

  @override
  List<Object> get props => [status];
}
