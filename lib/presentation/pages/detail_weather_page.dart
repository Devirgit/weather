import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/core/types/types.dart';
import 'package:weather/internal/di/di.dart';
import 'package:weather/presentation/context_local.dart';
import 'package:go_router/go_router.dart';
import 'package:weather/presentation/state/choose_city/choose_city_bloc.dart';
import 'package:weather/presentation/state/detail_weather/detail_weather_bloc.dart';
import 'package:weather/presentation/widget/info_dialog.dart';

// страница погоды на несколько дней
class DetailWeatherPage extends StatelessWidget {
  const DetailWeatherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DetailWeatherBloc(Di.get()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(context.local.detailtitle),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              context.go('/');
            },
          ),
        ),
        body: Builder(builder: (context) {
          final city = context.watch<ChooseCityBloc>().state.city;
          if (city != null) {
            context.read<DetailWeatherBloc>().add(DetailWeatherLoad(city.key));
          }

          return BlocListener<DetailWeatherBloc, DetailWeatherState>(
            listenWhen: (previous, current) => previous != current,
            listener: (context, state) {
              // в зависимости от статуса отображаем алерт с
              // информацией для пользователя

              switch (state.status) {
                case LoadDataStatus.loading:
                  InfoDialogs.beginProcess(context,
                      title: context.local.pleasewait);
                  break;
                case LoadDataStatus.success:
                  InfoDialogs.endProcess();
                  break;
                case LoadDataStatus.error:
                  InfoDialogs.endProcess();
                  InfoDialogs.snackBar(context, state.errorMessage);
                  break;
                default:
              }
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 10, top: 5, right: 10),
              child: BlocBuilder<DetailWeatherBloc, DetailWeatherState>(
                builder: (context, state) {
                  return ListView.builder(
                    itemCount: state.items.length,
                    itemBuilder: (context, index) {
                      final dayWeather = state.items[index];
                      return _WeatherItem(
                        date: context.local.datewithouttime(dayWeather.date.day,
                            dayWeather.date.month, dayWeather.date.year),
                        temperature:
                            '${context.local.temperatur(dayWeather.temperatureMin, dayWeather.temperatureMax)}${String.fromCharCodes([
                              0176,
                            ])}C',
                        windspeed: context.local.windspeed(
                            dayWeather.winSpeed, dayWeather.winDirection),
                      );
                    },
                  );
                },
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _WeatherItem extends StatelessWidget {
  const _WeatherItem(
      {Key? key,
      required this.date,
      required this.temperature,
      required this.windspeed})
      : super(key: key);

  final String date;
  final String temperature;
  final String windspeed;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          title: Text(date),
          subtitle: Text(windspeed),
          trailing: Text(temperature),
        ),
      ),
    );
  }
}
