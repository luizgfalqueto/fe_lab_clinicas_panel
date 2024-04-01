import 'package:fe_lab_clinicas_panel/src/models/panel_checkin_model.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

abstract interface class PanelCheckinRepositry {
  ({WebSocketChannel channel, Function dispose}) openChanelSocket();
  Stream<List<PanelCheckinModel>> getTodayPanel(WebSocketChannel chanel);
}