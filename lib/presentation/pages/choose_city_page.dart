import 'package:flutter/material.dart';
import 'package:weather/core/types/types.dart';
import 'package:weather/presentation/context_local.dart';
import 'package:go_router/go_router.dart';
import 'package:weather/presentation/state/choose_city/choose_city_bloc.dart';
import 'package:weather/presentation/widget/info_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// страница ввода города
class ChooseCityPage extends StatefulWidget {
  const ChooseCityPage({Key? key}) : super(key: key);

  @override
  State<ChooseCityPage> createState() => _ChooseCityPageState();
}

class _ChooseCityPageState extends State<ChooseCityPage> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Widget? leading;
    // если какой либо город уже был открыт разрешаем кнопку назад на главный экран
    // если города нет кпоки назад не отображаем

    bool city =
        context.watch<ChooseCityBloc>().state.city == null ? false : true;

    if (city) {
      leading = IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          context.go('/');
        },
      );
    }

    return BlocListener<ChooseCityBloc, ChooseCityState>(
      listenWhen: (previous, current) =>
          previous != current && previous.status != LoadDataStatus.init,
      listener: (context, state) {
        switch (state.status) {
          case LoadDataStatus.loading:
            InfoDialogs.beginProcess(context, title: context.local.pleasewait);
            break;
          case LoadDataStatus.success:
            InfoDialogs.endProcess();
            context.go('/');
            break;
          case LoadDataStatus.error:
            InfoDialogs.endProcess();
            InfoDialogs.snackBar(context, state.errorMessage);
            break;
          default:
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(context.local.choosetitle),
          leading: leading,
        ),
        body: WillPopScope(
          onWillPop: () async => city,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 25, right: 25, bottom: 25),
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: context.local.choosecity),
                ),
              ),
              SizedBox(
                  height: 50,
                  width: 150,
                  child: ElevatedButton(
                      onPressed: () {
                        context
                            .read<ChooseCityBloc>()
                            .add(ChangeCity(_controller.text));
                      },
                      child: Text(context.local.choosebtn)))
            ],
          ),
        ),
      ),
    );
  }
}
