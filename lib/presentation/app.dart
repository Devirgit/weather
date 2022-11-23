import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/internal/di/di.dart';
import 'package:flutter_gen/gen_l10n/local.dart';
import 'package:weather/presentation/route/go_routing.dart';
import 'package:weather/presentation/state/choose_city/choose_city_bloc.dart';
import 'package:weather/presentation/state/weather/weather_today_bloc.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final routConfig = Routing();

    final router = routConfig.initRouter(Di.get(name: 'initPath'));

    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) =>
                ChooseCityBloc(Di.get())..add(CityFromCache())),
        BlocProvider(create: (context) => WeatherTodayBloc(Di.get())),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: Di.get<ThemeData>(),
        localizationsDelegates: Local.localizationsDelegates,
        supportedLocales: Local.supportedLocales,
        routerConfig: router,
      ),
    );
  }
}
