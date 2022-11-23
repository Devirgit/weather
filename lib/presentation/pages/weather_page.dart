import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/core/types/types.dart';
import 'package:weather/presentation/context_local.dart';
import 'package:go_router/go_router.dart';
import 'package:weather/presentation/state/choose_city/choose_city_bloc.dart';
import 'package:weather/presentation/state/weather/weather_today_bloc.dart';
import 'package:weather/presentation/widget/info_dialog.dart';

// главная страница с текущей погодой
class WeatherPage extends StatelessWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            context.go('/city');
          },
        ),
        title: BlocBuilder<ChooseCityBloc, ChooseCityState>(
          buildWhen: (previous, current) =>
              previous.city != current.city && previous != current,
          builder: (context, state) {
            // если город в блоке определен загружаем
            // данные погоды по данному городу
            if (state.city != null) {
              context
                  .read<WeatherTodayBloc>()
                  .add(WeatherLoad(state.city!.key));
            }
            return Text(context.local.apptitle(state.city?.name ?? ''));
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: IconButton(
                onPressed: () {
                  context.go('/details');
                },
                icon: const Icon(Icons.view_timeline_outlined)),
          )
        ],
      ),
      body: BlocListener<WeatherTodayBloc, WeatherTodayState>(
        listenWhen: (previous, current) =>
            previous != current && previous.status != LoadDataStatus.init,
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
        child: BlocBuilder<WeatherTodayBloc, WeatherTodayState>(
            builder: (context, state) {
          return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  state.errorMessage ?? '',
                  style: const TextStyle(color: Colors.red),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      state.weather?.temperature.toString() ?? '-',
                      style: const TextStyle(
                          fontSize: 65, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      String.fromCharCodes([0176]),
                      style: const TextStyle(fontSize: 25),
                    ),
                    const Text('C', style: TextStyle(fontSize: 25)),
                  ],
                ),
                _WeatherViewParams(
                    context.local.humidity(state.weather?.humidity ?? '-')),
                _WeatherViewParams(context.local.windspeed(
                    state.weather?.winSpeed ?? '-',
                    state.weather?.winDirection ?? '-')),
              ]);
        }),
      ),
    );
  }
}

// визуальное оформление виджета дополнительной информации (ветер, влажность)
class _WeatherViewParams extends StatelessWidget {
  const _WeatherViewParams(this.text, {Key? key}) : super(key: key);

  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).appBarTheme.backgroundColor),
        child: Text(
          text,
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ));
  }
}
