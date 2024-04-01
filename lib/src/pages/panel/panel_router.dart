import 'package:fe_lab_clinicas_panel/src/pages/panel/panel_controller.dart';
import 'package:fe_lab_clinicas_panel/src/pages/panel/panel_page.dart';
import 'package:fe_lab_clinicas_panel/src/repositories/panel_checkin/panel_checkin_repositry.dart';
import 'package:fe_lab_clinicas_panel/src/repositories/panel_checkin/panel_checkin_repositry_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';

class PanelRouter extends FlutterGetItPageRouter {
  const PanelRouter({super.key});

  @override
  List<Bind<Object>> get bindings => [
        Bind.lazySingleton<PanelCheckinRepositry>(
            (i) => PanelCheckinRepositryImpl(restClient: i())),
        Bind.lazySingleton((i) => PanelController(repository: i())),
      ];

  @override
  String get routeName => '/panel';

  @override
  WidgetBuilder get view => (_) => const PanelPage();
}
