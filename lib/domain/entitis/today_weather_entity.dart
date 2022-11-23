import 'package:equatable/equatable.dart';

//сущьность текущей погоды
class TodayWeatherEntity extends Equatable {
  const TodayWeatherEntity(
      {required this.humidity,
      required this.temperature,
      required this.winDirection,
      required this.winSpeed});

  //  температура
  final double temperature;

  // скорость ветра
  final double winSpeed;

  //направление ветра
  final String winDirection;

  // относительная влажность
  final double humidity;

  @override
  List<Object?> get props => [temperature, winSpeed, winDirection, humidity];
}
