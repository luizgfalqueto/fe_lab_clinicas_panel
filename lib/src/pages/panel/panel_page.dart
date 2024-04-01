import 'package:fe_lab_clinicas_core/fe_lab_clinicas_core.dart';
import 'package:fe_lab_clinicas_panel/src/models/panel_checkin_model.dart';
import 'package:fe_lab_clinicas_panel/src/pages/panel/panel_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:signals_flutter/signals_flutter.dart';

import 'widgets/panel_principal_widget.dart';
import 'widgets/password_tile.dart';

class PanelPage extends StatefulWidget {
  const PanelPage({super.key});

  @override
  State<PanelPage> createState() => _PanelPageState();
}

class _PanelPageState extends State<PanelPage> {
  final controller = Injector.get<PanelController>();

  @override
  void initState() {
    controller.listenerPanel();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var sizeOf = MediaQuery.sizeOf(context);

    final PanelCheckinModel? current;
    final PanelCheckinModel? lastCall;
    final List<PanelCheckinModel>? others;

    final listPanel = controller.panelData.watch(context);

    current = listPanel.firstOrNull;
    if (listPanel.isNotEmpty) {
      listPanel.removeAt(0);
    }

    lastCall = listPanel.firstOrNull;
    if (listPanel.isNotEmpty) {
      listPanel.removeAt(0);
    }

    others = listPanel;

    return Scaffold(
      appBar: LabClinicasAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 32,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                lastCall != null
                    ? SizedBox(
                        width: sizeOf.width * .4,
                        child: PanelPrincipalWidget(
                          label: 'Senha anterior',
                          password: lastCall.password,
                          deskNumber: '0${lastCall.attendantDesk}',
                          labelColor: LabClinicasTheme.orangeColor,
                          buttonColor: LabClinicasTheme.blueColor,
                        ),
                      )
                    : const SizedBox.shrink(),
                const SizedBox(
                  width: 20,
                ),
                current != null
                    ? SizedBox(
                        width: sizeOf.width * .4,
                        child: PanelPrincipalWidget(
                          label: 'Chamando senha',
                          password: current.password,
                          deskNumber: '0${current.attendantDesk}',
                          labelColor: LabClinicasTheme.blueColor,
                          buttonColor: LabClinicasTheme.orangeColor,
                        ),
                      )
                    : const SizedBox.shrink(),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            const Divider(
              color: LabClinicasTheme.orangeColor,
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              'Últimos chamados',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: LabClinicasTheme.orangeColor,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Wrap(
              runAlignment: WrapAlignment.center,
              spacing: 10,
              runSpacing: 10,
              children: others
                  .map((e) => PasswordTile(
                        password: e.password,
                        deskNumber: e.attendantDesk.toString(),
                      ))
                  .toList(),
            )
          ],
        ),
      ),
    );
  }
}
