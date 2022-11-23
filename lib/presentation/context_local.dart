import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/local.dart';

extension BuildContextTheme on BuildContext {
  Local get local => Local.of(this)!;
}
