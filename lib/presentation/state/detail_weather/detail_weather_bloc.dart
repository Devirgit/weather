import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather/core/types/types.dart';
import 'package:weather/domain/entitis/history_weather_entity.dart';
import 'package:weather/domain/repository/weather_repository.dart';

part 'detail_weather_event.dart';
part 'detail_weather_state.dart';

class DetailWeatherBloc extends Bloc<DetailWeatherEvent, DetailWeatherState> {
  DetailWeatherBloc(WeatherRepository weatherRepository)
      : _weatherRepository = weatherRepository,
        super(const DetailWeatherState.init()) {
    on<DetailWeatherLoad>(_onDetailWeatherLoad);
  }

  final WeatherRepository _weatherRepository;

// получение детальной погоды из репозитория если приложение большое
// и/или планируется расширение логики можно использовать usecase

  Future<void> _onDetailWeatherLoad(
    DetailWeatherLoad event,
    Emitter<DetailWeatherState> emit,
  ) async {
    emit(const DetailWeatherState.loading());

    final weatherItems = await _weatherRepository.historyWeather(event.cityID);

// если резульат ошибка возвращаем состояние ошибка
// если пришли данные возвращаем новое состояние с данными
    weatherItems.result(
        (error) => emit(DetailWeatherState.error(error.message)),
        (items) => emit(DetailWeatherState.success(items)));
  }
}
