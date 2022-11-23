import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather/core/types/types.dart';
import 'package:weather/domain/entitis/city_entity.dart';
import 'package:weather/domain/repository/weather_repository.dart';

part 'choose_city_event.dart';
part 'choose_city_state.dart';

class ChooseCityBloc extends Bloc<ChooseCityEvent, ChooseCityState> {
  ChooseCityBloc(WeatherRepository weatherRepository)
      : _weatherRepository = weatherRepository,
        super(const ChooseCityState.init()) {
    on<CityFromCache>(_onCityFromCache);
    on<ChangeCity>(_onChangeCity);
  }

  final WeatherRepository _weatherRepository;

// попытка получить данные города из кеша успех возвращает
//город неудача, возвращает статус пусто

  Future<void> _onCityFromCache(
    CityFromCache event,
    Emitter<ChooseCityState> emit,
  ) async {
    final city = await _weatherRepository.searchCity();

    city.result((error) => emit(const ChooseCityState.notCyty()),
        (item) => emit(ChooseCityState.success(item)));
  }

// получаем данные города согласно введенных данных
// успех возвращает город, неудача озвращает ошибку

  Future<void> _onChangeCity(
    ChangeCity event,
    Emitter<ChooseCityState> emit,
  ) async {
    emit(const ChooseCityState.loading());

    final city = await _weatherRepository.searchCity(event.cityName);

    city.result((error) => emit(ChooseCityState.error(error.message)),
        (item) => emit(ChooseCityState.success(item)));
  }
}
