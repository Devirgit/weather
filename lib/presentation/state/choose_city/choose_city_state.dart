part of 'choose_city_bloc.dart';

class ChooseCityState extends Equatable {
  const ChooseCityState._(
      {this.city, this.errorMessage, this.status = LoadDataStatus.init});

  const ChooseCityState.init() : this._();

  const ChooseCityState.notCyty() : this._(status: LoadDataStatus.none);

  const ChooseCityState.error(String? message)
      : this._(errorMessage: message, status: LoadDataStatus.error);

  const ChooseCityState.loading() : this._(status: LoadDataStatus.loading);

  const ChooseCityState.success(CityEntity city)
      : this._(city: city, status: LoadDataStatus.success);

  final CityEntity? city;
  final LoadDataStatus status;
  final String? errorMessage;

  @override
  List<Object> get props => [status];
}
