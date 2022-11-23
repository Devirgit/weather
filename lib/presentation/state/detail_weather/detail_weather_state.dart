part of 'detail_weather_bloc.dart';

class DetailWeatherState extends Equatable {
  const DetailWeatherState._(
      {this.errorMessage,
      this.items = const [],
      this.status = LoadDataStatus.init});

  const DetailWeatherState.success(List<HistoryWeatherEntity> items)
      : this._(items: items, status: LoadDataStatus.success);

  const DetailWeatherState.init() : this._();

  const DetailWeatherState.error(String? message)
      : this._(
          errorMessage: message,
          status: LoadDataStatus.error,
        );

  const DetailWeatherState.loading() : this._(status: LoadDataStatus.loading);

  final LoadDataStatus status;
  final String? errorMessage;
  final List<HistoryWeatherEntity> items;

  @override
  List<Object> get props => [status, items];
}
