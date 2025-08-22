import 'package:flutter/widgets.dart';
import 'package:lista_tarefas/model/tarefas_modelo.dart';

import 'tarefas_custom.dart';

class TarefasRepositoy extends ChangeNotifier {
  final _custonDio = TarefasCustom();
  List<TarefaModelo> _tarefas = [];

  TarefasRepositoy();
  var _apenasNaoConcluidos = false;
  bool _carregando = false;

  set apenasNaoConcluidos(bool value) {
    _apenasNaoConcluidos = value;
    obterTarefas();
    notifyListeners();
  }

  bool get apenasNaoConcluidos => _apenasNaoConcluidos;
  bool get carregando => _carregando;
  List<TarefaModelo> get tarefas => _tarefas;

  Future<void> obterTarefas() async {
     _carregando = true;
    notifyListeners();
    var url = "/lista_de_tarefas";
    if (_apenasNaoConcluidos) {
      url = "$url?where={\"concluido\":false}";
    }
    var result = await _custonDio.dio.get(url);
    var modelo = TarefasModelo.fromJson(result.data);
    _tarefas = modelo.tarefas;
     _carregando = false;
      notifyListeners();
  }

  Future<void> criar(TarefaModelo tarefaModelo) async {
    try {
      await _custonDio.dio.post(
        "/lista_de_tarefas",
        data: tarefaModelo.toJsonEndPoint(),
      );
      await obterTarefas();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> atualizar(TarefaModelo tarefaModelo) async {
    try {
      await _custonDio.dio.put(
        "/lista_de_tarefas/${tarefaModelo.objectId}",
        data: tarefaModelo.toJsonEndPoint(),
      );
      await obterTarefas();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> remover(String objectId) async {
    try {
      await _custonDio.dio.delete("/lista_de_tarefas/$objectId");
      await obterTarefas();
    } catch (e) {
      rethrow;
    }
  }
}
