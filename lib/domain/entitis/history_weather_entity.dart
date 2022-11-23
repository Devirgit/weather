import 'package:equatable/equatable.dart';

//сущьность данных на несколько дней
class HistoryWeatherEntity extends Equatable {
  const HistoryWeatherEntity(
      {required this.date,
      required this.temperatureMax,
      required this.temperatureMin,
      required this.winDirection,
      required this.winSpeed});

  //дата
  final DateTime date;

  // минимальная температура в эту дату
  final double temperatureMin;

  // максимальная температура в эту дату
  final double temperatureMax;

  // скорость ветра
  final double winSpeed;

  //направление ветра
  final String winDirection;

  @override
  List<Object?> get props =>
      [date, temperatureMin, temperatureMax, winSpeed, winDirection];
}
