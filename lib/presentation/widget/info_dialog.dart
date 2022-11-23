import 'package:flutter/material.dart';

class InfoDialogs {
  static BuildContext? _context;

// отобразить алерт с оповещением о стусе загрузки или ошибки
  static Future<void> beginProcess(BuildContext context,
      {String? title, Widget? action}) {
    _context = context;
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      useRootNavigator: true,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            backgroundColor: Theme.of(context).primaryColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            title: title == null
                ? null
                : Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 14),
                  ),
            content: SizedBox(
                height: 50,
                child:
                    action ?? const Center(child: CircularProgressIndicator())),
          ),
        );
      },
    );
  }

// закрыть алерт по окончанию загрузки
  static endProcess() {
    if (_context != null) {
      Navigator.of(_context!, rootNavigator: true).pop();
      _context = null;
    }
  }

// показать снек бар
  static void snackBar(BuildContext context, String? message, {Key? key}) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        key: key,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10))),
        content: Text(
          message ?? '',
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
