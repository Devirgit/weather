import 'package:weather/core/error/failure.dart';

class CRUDServerFailure extends ServerFailure {
  const CRUDServerFailure([String message = 'Ошибка обращения к серверу.'])
      : super(message);

  factory CRUDServerFailure.fromType(String type) {
    switch (type) {
      case 'response-error':
        return const CRUDServerFailure('Ошибка получения данных.');
      case 'get-city-error':
        return const CRUDServerFailure('Не удалось получить данные города.');
      default:
        return CRUDServerFailure(ServerFailure.getMessage(type));
    }
  }
}
