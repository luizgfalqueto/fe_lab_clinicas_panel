import 'package:fe_lab_clinicas_panel/src/models/panel_checkin_model.dart';
import 'package:fe_lab_clinicas_panel/src/repositories/panel_checkin/panel_checkin_repositry.dart';
import 'package:signals_flutter/signals_flutter.dart';

class PanelController {
  PanelController({required PanelCheckinRepositry repository})
      : _repository = repository;

  final PanelCheckinRepositry _repository;
  final panelData = listSignal<PanelCheckinModel>([]);

  Connect? _panelConnect;

  Function? _socketDispose;

  void listenerPanel() {
    final (:channel, :dispose) = _repository.openChanelSocket();
    _socketDispose = dispose;

    _panelConnect = connect(panelData);
    final panelStream = _repository.getTodayPanel(channel);

    _panelConnect!.from(panelStream);
  }

  void dispose() {
    _panelConnect?.dispose();
    if (_socketDispose != null) {
      _socketDispose!();
    }
  }
}
