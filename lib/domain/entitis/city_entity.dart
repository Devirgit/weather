import 'package:equatable/equatable.dart';

//сущьность найденного города
class CityEntity extends Equatable {
  const CityEntity({required this.key, required this.name});

  // ключ города для запроса данных
  final String key;

  // название города
  final String name;

  @override
  List<Object?> get props => [key, name];
}
