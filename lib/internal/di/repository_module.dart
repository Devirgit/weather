import 'package:weather/data/repository/weather_repository_impl.dart';
import 'package:weather/domain/repository/weather_repository.dart';
import 'package:weather/internal/di/api_module.dart';

class RepositoryModule {
  RepositoryModule._();

  static final inst = RepositoryModule._();
// указываем какой репозиторий будет использоваться
  WeatherRepository weatherRepository(String apiToken) => WeatherRepositoryImpl(
      weatherCache: ApiModule.weatherCache,
      weatherService: ApiModule.weatherService(apiToken));
}
