import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather/core/types/types.dart';
import 'package:weather/domain/entitis/today_weather_entity.dart';
import 'package:weather/domain/repository/weather_repository.dart';

part 'weather_today_event.dart';
part 'weather_today_state.dart';

class WeatherTodayBloc extends Bloc<WeatherTodayEvent, WeatherTodayState> {
  WeatherTodayBloc(WeatherRepository weatherRepository)
      : _weatherRepository = weatherRepository,
        super(const WeatherTodayState.init()) {
    on<WeatherLoad>(_onWeatherLoad);
  }

  final WeatherRepository _weatherRepository;

// получение дневной погоды
  Future<void> _onWeatherLoad(
    WeatherLoad event,
    Emitter<WeatherTodayState> emit,
  ) async {
    if (event.cityId != state.cityID) {
      emit(const WeatherTodayState.loading());

      final weather = await _weatherRepository.todayWeather(event.cityId);

      weather.result(
          (error) => emit(WeatherTodayState.error(error.message, event.cityId)),
          (item) => emit(WeatherTodayState.success(item, event.cityId)));
    }
  }
}
