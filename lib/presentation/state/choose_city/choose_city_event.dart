part of 'choose_city_bloc.dart';

abstract class ChooseCityEvent extends Equatable {
  const ChooseCityEvent();

  @override
  List<Object> get props => [];
}

// событие загрузки сохраненного города  из кеша
class CityFromCache extends ChooseCityEvent {}

// событие загрузки данных нового города
class ChangeCity extends ChooseCityEvent {
  const ChangeCity(this.cityName);

  final String cityName;

  @override
  List<Object> get props => [cityName];
}
