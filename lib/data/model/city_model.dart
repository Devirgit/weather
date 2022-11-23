import 'package:weather/domain/entitis/city_entity.dart';

// модель для работы с внешними сервисами
class CityModel extends CityEntity {
  const CityModel({required String key, required String name})
      : super(key: key, name: name);

// получение данных из json
  CityModel.fromJson(Map<String, dynamic> map)
      : super(key: map['Key'] as String, name: map['LocalizedName'] as String);
}
